resource "aws_instance" "ansible_master" {
  ami = "ami-09208e69ff3feb1db"
  instance_type = "t2.medium"
  vpc_security_group_ids = ["sg-0b1f9a37f83ba7469"]
  subnet_id = "subnet-0dd2fa4ab8f031d8a"
  user_data = file("ansible.sh")
  key_name = "Key_pair_ncalifornia"

  root_block_device {
    volume_size  = 30
  }

  tags = {
    Name = "Ansible-Master"
  }
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.ansible_master.id
  allocation_id = aws_eip.eip_ansible.id
}


resource "aws_eip" "eip_ansible" {
  vpc = true
}