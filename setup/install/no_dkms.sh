# update system
sudo apt update && sudo apt upgrade
# install dependencies
# driver
sudo apt install -y raspberrypi-kernel-headers build-essential bc git
# bridge
sudo apt-get install dnsmasq iptables