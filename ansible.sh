#!/bin/bash
sudo hostnamecrl set-hostname ansbile --static
sudo yum update -y
sudo amazon-linux-extras install ansible2 -y