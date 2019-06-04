# Getting Started
The following files are needed to setup a simple project that will deploy a single VPS to
Digital Ocean. We setup the provider and add a simple resource.

This folder does not include the terraform.tfvars file that is used to store secrets that are not included in
version control

Once you setup the credntials file, get started by running:
```
terraform init
```

This is used to initilze terraform by downloading the required modules to communicate with known providers.

Next run:
```
terraform plan
```
This is used to run through the project and identify what Terraform will complete during the next deployment.

To deploy the project run:
```
terraform apply
```

This will run through the project and deploy a single VPS named web1. Login to the Digital Oceans web interface to check it out. 
Since authentication was not configured, simply delete the project by running:
```
terraform destroy
```

Continue on to the next step!
