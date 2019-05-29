#Updates in Step #4

Now that we have 3 web servers, lets configure a load balancer for the three web sites. This will be done by deploying a new resource haproxy. This resource will require a haproxy configuration file that will include the private IP addresses of the three web servers. Since the private IP address is obtained after the server is built, we must create a template file that will dynamically update the configuration file with the required information when it's available.

The new haproxy.tpl file contains the configuration required for HA proxy to load balance between the three web servers. Notice there are variables interjected in the configuration file. Once the information is available to terraform, terraform will update the file and upload it to the server.

You will notice when you deploy this project, web1, web2, and web3 will get deployed while haproxy waits until all the information it requires is available before creating the VM. This is a default behavior of terraform.

Complete this demo by deploying this project and checking if the proxy server is load balancing between the three servers.

Make sure you destroy the project to prevent usage billing.