resource "digitalocean_droplet" "web3" {
  image  = "ubuntu-18-04-x64"
  name   = "web3"
  region = "nyc1"
  size   = "s-1vcpu-1gb"

  #We will need this later, this allows the VPS to obtain a private IP address.
  private_networking = "true"

  #This configures the SSH key fingerprint that will be applied to the VPS for access.
  #The SSH public key must be added to the Digital Oceans interface and the fingerprint for the
  #key must be added to the configuration here
  ssh_keys = [
    "${var.SSH_FINGERPRINT}",
  ]

  #configure a connection to the server after its provisioned. SSH is the default
  connection = {
    user        = "root"
    type        = "ssh"
    private_key = "${file(var.PRIVATE_KEY_PATH)}"
    timeout     = "2m"
  }

  provisioner "file" {
    source      = "startup.sh"
    destination = "startup.sh"
  }

  #This  is executed when the server first starts and a successful connection is established
  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x startup.sh",
      "sudo ./startup.sh",
    ]
  }
}

#once complete, browse to the server on port 80 of its public IP address. You should see a text message there with the server name and IP

