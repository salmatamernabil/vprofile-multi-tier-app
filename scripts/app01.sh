#!/bin/bash

yum update -y

yum install epel-release -y

dnf install java-11-openjdk java-11-openjdk-devel -y
dnf install git maven wget -y

cd /tmp

wget https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.75/bin/apache-tomcat-9.0.75.tar.gz

tar xzvf apache-tomcat-9.0.75.tar.gz

useradd --home-dir /usr/local/tomcat --shell /sbin/nologin tomcat

mkdir -p /usr/local/tomcat

cp -r apache-tomcat-9.0.75/* /usr/local/tomcat/

chown -R tomcat:tomcat /usr/local/tomcat

cat > /etc/systemd/system/tomcat.service <<'EOF'
[Unit]
Description=Tomcat
After=network.target

[Service]
User=tomcat
WorkingDirectory=/usr/local/tomcat
Environment=JRE_HOME=/usr/lib/jvm/jre
Environment=JAVA_HOME=/usr/lib/jvm/jre
Environment=CATALINA_HOME=/usr/local/tomcat
Environment=CATALINA_BASE=/usr/local/tomcat
ExecStart=/usr/local/tomcat/bin/catalina.sh run
ExecStop=/usr/local/tomcat/bin/shutdown.sh

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl start tomcat
systemctl enable tomcat

systemctl start firewalld
systemctl enable firewalld

firewall-cmd --permanent --add-port=8080/tcp
firewall-cmd --reload

cd /root

git clone -b main https://github.com/hkhcoder/vprofile-project.git

cd /root/vprofile-project

mvn install

systemctl stop tomcat

rm -rf /usr/local/tomcat/webapps/ROOT*

cp target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war

chown -R tomcat:tomcat /usr/local/tomcat/webapps

systemctl start tomcat