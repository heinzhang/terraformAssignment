# terraformAssignment
A terraform assignment

## Description

This is a terraform assignment.
The code will provision an EC2 with docker container running in it. Also it will deploy a rest api service to the container. 
The detailed instruction is below and also in the main.tf step by step. 

## Getting Started
### Dependencies

* Terraform is installed
* AWS account with access_key and secrect_key
* Key pair - download the key pair in 'pem' format from your aws EC2. The key name 'assignment_key.pem' and put under the root folder



### Installing & Executing program

* Run command

```
terraform init
terraform apply
```
* Visit the log


Find IP address from the output value after executing the 'terraform apply' command
e.g.  ip address is '3.104.51.202'
Visit the ip address with 8080 port in your browser. e.g. 'http://3.104.51.202:8080'
It will show the logs recorded. 

* Search function with keyword

Use the format as below with your keyword to show the log lines which have only your keyword. 
http://{{ip adress}}/logs/{{keyword}}

e.g.http://3.104.51.202:8080/running 
The example above will show the log lines which have 'running'


* Detailed steps to finish the assignment please refer to the comment in main.tf 

## Risks 
```
- root user access should be replaced with IAM user who only have limited permission. 
- I copied the nginx conf to replace the default one to point the port nodejs use to the port Nginx use. But I use nginx latest as the docker image. It might has issue in future nginx image update. I can choose to build my own image but it is too large to upload. 
- nginx server use http which is not very secure. should use https. 
- Ubuntu firewall setting should comply with company policy. I use some basic settings only. 
- Provisioner part used too many shell scripts. Once one script is failed the rest will fail and difficult to debug. 
Using a customized docker image can help lowing the deployment risk especially for the node js deployment part. 
- code is public on github. should delete it once got reviewed. 
- key pair should not be used. Better use AWS Key Management Service. 
```

