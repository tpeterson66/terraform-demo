# Step #3 Updates

Now that we can deploy a single web server running nginx, lets bump this up to a more practical application of Terraform. 

In this step, we add two additional resources, web2 and web3. Now that we have 3 resources to manage, updating the resource configuration on each server to make a change would be less than ideal. Instead, lets add a script (startup.sh) and execute that when the server is first built. 

This startup.sh script will simple perform the updates, install nginx and update the default html page to a text string including the hostname and ip address of the server so we can tell them apart.

Check out the vars.tf, web1.tf, web2.tf, web3.tf and startup.sh files to see what's changed. You'll notice we're copying a file and then executing that file on the server vs. adding the required lines to the remote-exec provisioner as in step 2.

Go ahead and deploy the project!

Once the servers a built, check the digital oceans web interface for their IP addresses and connect to them via http.

You should notice the webpage has been updated to reflect the hostname and IP address of the servers.

Once complete, go ahead and destroy the project and move on to step #4!
