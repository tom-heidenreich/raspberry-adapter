# Raspberry Adapter

A simple wlan to eth router using the raspberry pi 4.

### Required hardware
* Raspberry pi 4
* tp-link AC1300
* ethernet cable

## Content
* wifi to eth bridge
* [88x2bu-20210702](https://github.com/morrownr/88x2bu-20210702) (wifi driver)
* Docker*
* pihole (dns server)*

*optional

## Install Raspberry Pi OS
### 1.
Download Imager [here](https://downloads.raspberrypi.org/imager/imager_latest.exe)
### 2.
Go into settings. (bottom right)
### 3.
Enable `SSH`
### 4. (otional)
Enable `Wifi`
### 5.
Select `Raspberry Pi OS (other)`/`Raspberry Pi OS Lite (64-bit)`
### 6.
Select SD-Card and follow instructions.

## Setup Bridge
> Will be automated in the future.
### 1.
Connect the raspberry pi to wifi.
Open settings file with following command:
```sh
$ sudo nano /etc/wpa_supplicant/wpa_supplicant.conf
```
### 2.
Can be skipped if you already configured wifi in the Imager
Add the following lines to the file:
```sh
network={
    ssid="networkname"
    psk="networkpassword"
}
```
### 3.
Lookup the ip address of the raspberry pi:
```sh
$ hostname -I
```
In the further course the IP addresses look like this `192.168.*.1`.
Replace the `*` with the according number of your ip address.
### 4.
Run the following command to open `dhcpcd.conf`:
```sh
$ sudo nano /etc/dhcpcd.conf
```
### 5.
Add the following lines to the file:
```sh
interface eth0
static ip_address=192.168.*.1/24
static routers=192.168.*.0
```
### 6.
Restart dhcpcd
```sh
$ sudo service dhcpcd restart
```
### 7.
Run this command:
```sh
$ sudo mv /etc/dnsmasq.conf /etc/dnsmasq.conf.orig
```
### 8.
Open the next config file:
```sh
$ sudo nano /etc/dnsmasq.conf
```
### 9.
Add the following lines to the file:
```sh
interface=eth0       # Use interface eth0  
listen-address=192.168.*.1   # Specify the address to listen on  
bind-dynamic         # Bind to the interface
server=8.8.8.8       # Use Google DNS  
domain-needed        # Don't forward short names  
bogus-priv           # Drop the non-routed address spaces.  
dhcp-range=192.168.*.50,192.168.*.150,12h # IP range and lease time
```
### 10.
Configure the firewall. Open the file:
```sh
$ sudo nano /etc/sysctl.conf
```
### 11.
Find the line
```sh
#net.ipv4.ip_forward=1
```
and replace with
```sh
net.ipv4.ip_forward=1
```
### 12.
Run the following command:
```sh
$ sh ./setup.sh --bridge
```
### 13.
Open `rc.local`:
```sh
$ sudo nano /etc/rc.local
```
### 14.
Add the following line before `exit 0`:
```sh
iptables-restore < /etc/iptables.ipv4.nat
```
### 15.
Start the service:
```sh
$ sudo service dnsmasq start
```

## Setup Driver
Run Setup
### DKMS
```sh
$ ./setup.sh --dkms
```

### No DKMS
```sh
$ ./setup.sh --no-dkms
```

## Remove Driver

### DKMS
```sh
$ ./remove.sh --dkms
```

### No DKMS
```sh
$ ./remove.sh --no-dkms
```
