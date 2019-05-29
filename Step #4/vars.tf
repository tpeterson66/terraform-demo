#  Even though we assign the value in the terraform.tfvars file, we still need to declare the variables here.
#  This file can be named whatever you want since all files are loaded when you run terraform
#  if you wanted to hard code the credentials in this file, you can;
# variable "CREDENTIAL" {
#     type =  "string"
#     default = "SUPERSECRETPASSWORD"
# }
#  When going this route, you would want to make sure this file is excluded from version control
#  this would require all other users to set this file up correctly when using the project.

variable "DO_TOKEN" {}

variable "SSH_FINGERPRINT" {}

#  Added the private key path to this variable list. This is used in the web1 resource 
#  to connect to the VPS after it is provisioned.
variable "PRIVATE_KEY_PATH" {
    type = "string"
    default = "~/.ssh/dokey"
}
#  added the template file location and variables. This will be used in the haproxy resource to update 
#  the configuration file before deploying it to the server.
data "template_file" "haproxy" {
    template = "${file("./haproxy.tpl")}"
    vars {
      web1ip = "${digitalocean_droplet.web1.ipv4_address_private}"
      web2ip = "${digitalocean_droplet.web2.ipv4_address_private}"
      web3ip = "${digitalocean_droplet.web3.ipv4_address_private}"
    }
  }