# 1. The deployment should take AWS credentials and AWS region as input parameters.
 provider "aws" {
    region =  "ap-southeast-2"
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
}

# 2. A VPC with the required networking, don't use the default VPC.
module "assignment_vpc" {
  source = "./modules/vpc"
}

# 3. Provision a “t2.micro” EC2 instance, with an OS of your choice.
resource "aws_instance" "assignment_ec2" { 
   ami =  "ami-0f39d06d145e9bb63"
    instance_type = "${var.instance_type}"
    availability_zone = "${var.available_zone}"
    key_name = "${var.key_name}"

    connection {
    user = "ubuntu"
    host = self.public_ip
    private_key   = "${file("assignment_key.pem")}"
    }

    provisioner "file" {
      source      = "scripts/"
      destination = "/home/ubuntu/"
    }

    provisioner "remote-exec" {

    inline = [
        #modify all shell scripts to excecutable files
        "chmod +x /home/ubuntu/deploymentScripts/*.sh",
        "/home/ubuntu/deploymentScripts/ec2FirewallSetup.sh",
        "mkdir /home/ubuntu/logs",
        "/home/ubuntu/deploymentScripts/installDocker.sh",
        "/home/ubuntu/deploymentScripts/createNginxDockerContainer.sh",
        # schedule the job 
        "(sudo crontab -l 2>/dev/null; echo \"* * * * * /home/ubuntu/deploymentScripts/logmonitor.sh >> /home/ubuntu/logs/nginxstatus.log\") | sudo crontab -",
        "/home/ubuntu/deploymentScripts/deployNode.sh"
    ]
  }

    network_interface {
      device_index = 0
      network_interface_id = "${module.assignment_vpc.networkinterface_id}"
    }

    tags = {
        Name = "${var.tag_name}"
    }
}

# 4. Change the security group of the instance to ensure its security level.
# see module in folder /modules/vpc/networking 


# 5. Change the OS/Firewall settings of the started instance to further enhance its security level.
# see scripts/deploymentScripts/ec2FirewallSetup.sh

# 6. Install Docker CE.
# see scripts/deploymentScripts/installDocker.sh 

# 7. Deploy and start a NGINX docker container in the EC2 instance.
# see scripts/deploymentScripts/createNginxDockerContainer.sh

# 8. Deploy a script (or multiple scripts) on the EC2 instance to complete the following subtasks:
# a. Log the health status and resource usage of the NGINX container every 10 seconds into a log file.
# see scripts/deploymentScripts/logmonitor.sh

# b. Write a REST API using any choice of programming language which is you are familiar
# with and read from the above log file able to a basic search. (Provide us and example use of your API using curl or any REST client)
# see scripts/nodejsScripts. Example please see readme file. 

# 9. A README.md describing what you've done as well as steps explaining how to run the infrastructure automation and execute the script(s).
# see readme
# 10. Describe any risks associated with your application/deployment
# see readme 