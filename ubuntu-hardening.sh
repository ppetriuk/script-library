#!/bin/bash


## WIP not tested

# Keep everything up-to date

#apt-get update && apt-get upgrade


# Who has UID 0
echo "Only root should have UID 0, check the output below and press the key to continue"

awk -F: '($3=="0"){print}' /etc/passwd

echo "Press any key to continue"
while [ true ] ; do
read -t 3 -n 1
if [ $? = 0 ] ; then
exit
fi; done

# Check accounts with empty passwords
echo "Should be no empty passwords, check the output below and press the key to continue"

cat /etc/shadow | awk -F: '($2==""){print $1}'

echo "Press any key to continue"
while [ true ] ; do
read -t 3 -n 1
if [ $? = 0 ] ; then
exit
fi; done

# Add my user
adduser ppetriuk

# Secure Shared Memory
echo "tmpfs /run/shm tmpfs defaults,noexec,nosuid 0 0" >> ./etc/fstab

# Enable SSH Login for Specific Users Only, only from  Campbell location
echo "AllowUsers ppetriuk@64.124.158.*" >> ./etc/ssh/sshd_config
# systemctl restart sshd

# Add Security Login Banner

cat <<EOT >> ./etc/issue.net
This system is for the use of authotized users only. Usage of this system maybe monitored and recorded by system personnel.

Anyone using this syetm expressly consents to such monitoring and is advised that if such monitoring reveals possible evidences of criminal activity, system personnel may provide the evidence from such monitoring to law enforcement officials.
EOT


sed -i "" "s+session optional pam_motd.so motd=/run/motd.dynamic+#session optional pam_motd.so motd=/run/motd.dynamic+g" etc/pam.d/sshd
sed -i "" "s+session optional pam_motd.so noupdate+#session optional pam_motd.so noupdate+g" etc/pam.d/sshd
sed -i "" "s+#Banner /etc/issue.net+Banner /etc/issue.net+g" etc/ssh/sshd_config

# Disable root Login and change SSH port

sed -i "" "s/PermitRootLogin yes/PermitRootLogin no/g" /etc/ssh/sshd_config
sed -i "" "s/Port 22/Port 2222/g" /etc/ssh/sshd_config

# systemctl restart sshd

# Restrict SU Access

#sudo groupadd admin
#sudo usermod -a -G admin ppetriuk
#sudo dpkg-statoverride --update --add root admin 4750 /bin/su

# Install fail2ban

#sudo apt-get install fail2ban

cat <<EOF >> ./etc/fail2ban/jail.local
[sshd]
enabled = true
port = 22
filter = sshd
logpath = /var/log/auth.log
maxretry = 3
EOF

#systemctl restart fail2ban

# Check for Rootkits

apt-get install rkhunter

rkhunter -C

# Resrict IPTables to HTTP, HTTPS and SSH
iptables -A INPUT -p tcp -m tcp --dport 80 -m state --state NEW,ESTABLISHED -j ACCEPT

iptables -A INPUT -p tcp -m tcp --dport 443 -m state --state NEW,ESTABLISHED -j ACCEPT

iptables -A INPUT -p tcp -m tcp --dport 2222 -m state --state NEW,ESTABLISHED -j ACCEPT

iptables -A INPUT -I lo -j ACCEPT

iptables -A INPUT -j DROP


