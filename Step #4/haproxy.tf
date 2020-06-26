resource "digitalocean_droplet" "proxy" {
  image              = "ubuntu-18-04-x64"
  name               = "proxy"
  region             = "nyc1"
  size               = "s-1vcpu-1gb"
  private_networking = "true"

  ssh_keys = [
    "${var.SSH_FINGERPRINT}",
  ]

  # connection = {
  #   user        = "root"
  #   type        = "ssh"
  #   private_key = "${file(var.PRIVATE_KEY_PATH)}"
  #   timeout     = "2m"
  # }
  
    connection {
      user        = "root"
      type        = "ssh"
      private_key = "${file(var.PRIVATE_KEY_PATH)}"
      timeout     = "2m"
      host        = digitalocean_droplet.proxy.ipv4_address
  }

  provisioner "remote-exec" {
    inline = [
      "sleep 25",
      "sudo apt-get update",
      "sudo apt-get -y install haproxy",
    ]
  }

  provisioner "file" {
    content      = "${data.template_file.haproxy.rendered}"
    destination = "/etc/haproxy/haproxy.cfg"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo service haproxy restart"
    ]
  }
}
