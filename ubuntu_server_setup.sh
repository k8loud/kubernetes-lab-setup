sudo apt update
sudo apt -y upgrade
sudo apt-get install openssh-server

ssh-keygen -o -b 4096 -t rsa
