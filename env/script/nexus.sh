#!/usr/bin/env bash

apt-get update

apt install openjdk-8-jre-headless -y

cd /opt

wget https://download.sonatype.com/nexus/3/latest-unix.tar.gz

tar -zxvf latest-unix.tar.gz

mv /opt/nexus-* /opt/nexus

adduser --gecos "" --disabled-password nexus
chpasswd <<<"nexus:nexus"

echo "nexus ALL=(ALL) NOPASSWD: ALL" | sudo tee -a /etc/sudoers

chown -R nexus:nexus /opt/nexus /opt/sonatype-work

echo 'run_as_user="nexus"' | sudo tee -a /opt/nexus/bin/nexus.rc

cat <<eof | sudo tee -a /etc/systemd/system/nexus.service
[Unit]
Description=nexus service
After=network.target
[Service]
Type=forking
LimitNOFILE=65536
ExecStart=/opt/nexus/bin/nexus start
ExecStop=/opt/nexus/bin/nexus stop
User=nexus
Restart=on-abort
[Install]
WantedBy=multi-user.target
eof

systemctl start nexus

systemctl enable nexus
