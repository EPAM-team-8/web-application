resource "aws_instance" "Web-Application" {
  ami                    = "ami-00399ec92321828f5"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [data.aws_security_group.epam-sg.id]
  key_name               = "awskey"

  tags = {
    Name = "Web-Application"
  }
}

resource "null_resource" "ansible_automation" {
  triggers = {
    build_number = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = "sleep 60; ansible-galaxy install -p ../ansible/roles -r ../ansible/requirements.yml --force && cd ../ansible && ansible-playbook --vault-password-file /home/arsen/vault -i aws_ec2.yml web-application.yml"
  }
  depends_on = [
    aws_instance.Web-Application
  ]
}
