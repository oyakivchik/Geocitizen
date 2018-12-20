# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|


  config.vm.box = "ubuntu/xenial64"

  $script = <<SCRIPT
	sudo echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -c | awk '{print $2}')-pgdg main" > /etc/apt/sources.list.d/pgdg.list
	sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 7FCC7D46ACCC4CF8
	sudo apt-get update
SCRIPT


  config.vm.provider "virtualbox" do |vb|
    vb.gui = false

    vb.memory = "2048"
  end

 config.vm.provision :shell, inline: $script

  config.vm.define "master" do |master|
    master.vm.hostname = "masterdb"
    master.vm.network "private_network", ip: "192.168.100.100"
	config.vm.network :public_network
	config.vm.provision "shell", inline: <<-SHELL
	hostnamectl set-hostname master-server
	echo "Update && Upgrade"
    apt-get update -y
    apt-get upgrade -y
	echo "Install Postgresql"
	apt-get install -y postgresql postgresql-client postgresql-contrib
	ufw allow 5432
    echo "Install common tools"
    apt-get install -y nano git
    echo "Install Maven"
    apt-get install -y maven 	
	echo mvn -version
    echo "Install Ruby"
    apt-get install -y ruby
    echo "Install Python 2"
    apt-get install -y python python-pip
    echo "Install Python 3"
    apt-get install -y python3 python3-pip
	echo "Install java for Jenkins"
	sudo apt install openjdk-8-jdk
	echo "Install Tomcat"
	wget -P /usr/local http://www-us.apache.org/dist/tomcat/tomcat-9/v9.0.14/bin/apache-tomcat-9.0.14.tar.gz
	tar xzf /usr/local/apache-tomcat-9.0.14.tar.gz
	mv apache-tomcat-9.0.14 apache-tomcat9
	echo "export CATALINA_HOME="/usr/local/apache-tomcat9"" >> ~/.bashrc
	echo "export JAVA_HOME="/usr/lib/jvm/java-8-oracle"" >> ~/.bashrc
	echo "export JRE_HOME="/usr/lib/jvm/java-8-oracle/jre"" >> ~/.bashrc
	source ~/.bashrc
	tail -n 1 "/usr/local/apache-tomcat9/conf/tomcat-users.xml" | wc -c | xargs -I {} truncate "/usr/local/apache-tomcat9/conf/tomcat-users.xml" -s -{}
	echo -e "<user username="admin" password="password" roles="manager-gui,admin-gui"/>\n</tomcat-users>" >> /usr/local/apache-tomcat9/conf/tomcat-users.xml
	sed -i 's/8080/8088/g' /usr/local/apache-tomcat9/conf/server.xml
	chmod +x /usr/local/apache-tomcat9/bin/startup.sh
	sh /usr/local/apache-tomcat9/bin/startup.sh
	ufw allow 8088
	echo "config Postgres-master"
	echo "192.168.100.100 master-server" >> /etc/hosts
	echo "host    replication     replica      192.168.100.200/24            md5" >> /etc/postgresql/11/main/pg_hba.conf
	echo -e "listen_addresses = '*'\nwal_level = hot_standby\ncheckpoint_segments = 8\narchive_mode = on\narchive_command = 'cp -i %p /var/lib/postgresql/11/main/archive/%f'\nmax_wal_senders = 3\nwal_keep_segments = 8" >> /etc/postgresql/11/main/postgresql.conf
	echo "postgres" | passwd --stdin postgres
	echo "install Jenkins"
	if [ ! -d /var/lib/jenkins ]; then
        wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
        if [ ! -f /etc/apt/sources.list.d/jenkins.list ]; then
            echo "deb https://pkg.jenkins.io/debian-stable binary/" >> /etc/apt/sources.list.d/jenkins.list
        fi
        apt-get update
        apt-get install jenkins -y
        if [ -f /var/lib/jenkins/secrets/initialAdminPassword ]; then
          cat /var/lib/jenkins/secrets/initialAdminPassword
        fi
    fi
  SHELL
	
  end

  config.vm.define "slave" do |slave|
    slave.vm.hostname = "slavedb"
    slave.vm.network "private_network", ip: "192.168.100.200"
	config.vm.network :public_network
	config.vm.provision "shell", path: "slave-db.sh"
	
  end
	
	
    
  
end