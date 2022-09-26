resource "aws_instance" "jenkins_master" {
  ami = "ami-09208e69ff3feb1db"
  instance_type = "t2.medium"
  vpc_security_group_ids = ["sg-0b1f9a37f83ba7469"]
  subnet_id = "subnet-0dd2fa4ab8f031d8a"
  key_name = "Key_pair_ncalifornia"

  root_block_device {
    volume_size  = 30
  }

  tags = {
    Name = "Jenkins-Master" }
}

resource "aws_eip_association" "eip_assoc_jenkins" {
  instance_id   = aws_instance.jenkins_master.id
  allocation_id = aws_eip.eip_jenkins_master.id
}


resource "aws_eip" "eip_jenkins_master" {
  vpc = true
  tags = {
    Name = "Jenkins-Master"
  }

}


resource "aws_instance" "jenkins_agent1" {
  ami = "ami-09208e69ff3feb1db"
  instance_type = "t2.xlarge"
  vpc_security_group_ids = ["sg-0b1f9a37f83ba7469"]
  subnet_id = "subnet-0dd2fa4ab8f031d8a"
  key_name = "Key_pair_ncalifornia"

  root_block_device {
    volume_size  = 30
  }

  tags = {
    Name = "Jenkins-Agent1" }
}

resource "aws_eip_association" "eip_assoc_jenkins_agent1" {
  instance_id   = aws_instance.jenkins_agent1.id
  allocation_id = aws_eip.eip_jenkins_agent1.id
}


resource "aws_eip" "eip_jenkins_agent1" {
  vpc = true
  tags = {
    Name = "Jenkins-Agent1"
  }

}