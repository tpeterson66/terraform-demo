# Updates in step #2
In this step additional configuration is added to allow terraform to connect to the VPS and install some updates and nginx.

Begin by copying your terraform.tfvars file to this directory and running:
```
terraform init
terraform plan
terraform apply
```
Once the server is built, you will see terraform SSH into the VPS and install software updates and nginx. Once complete, obtain the public IP address from the dashboard and connect to it on http. You should see the default nginx page if successful.

If you'd like you can SSH to the server and mess around with the Digital Oceans VPS.

Once complete, run:
```
terraform destroy
```

Now move on to step 3!