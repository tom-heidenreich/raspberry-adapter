sudo sh -c "echo 1 > /proc/sys/net/ipv4/ip_forward"

# change to wlan0 if you are not using a WIFI dongle
sudo iptables -t nat -A POSTROUTING -o wlan1 -j MASQUERADE
sudo iptables -A FORWARD -i wlan1 -o eth0 -m state --state RELATED,ESTABLISHED -j ACCEPT  
sudo iptables -A FORWARD -i eth0 -o wlan1 -j ACCEPT

sudo sh -c "iptables-save > /etc/iptables.ipv4.nat"