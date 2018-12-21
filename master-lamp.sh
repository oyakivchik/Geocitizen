#! /usr/bin/env bash
	sudo echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -c | awk '{print $2}')-pgdg main" > /etc/apt/sources.list.d/pgdg.list
	sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 7FCC7D46ACCC4CF8
	sudo apt-get update -qy
	echo "Update && Upgrade"
    apt-get update -qy
    apt-get upgrade -qy
	echo "Install Postgresql"
	apt-get install -y postgresql postgresql-client postgresql-contrib
	ufw allow 5432
    echo "Install common tools"
    apt-get install -qy nano git
    echo "Install Maven"
    apt-get install -qy maven 	
	apt-get -qy install default-jre
	apt-get -qy install default-jdk
	add-apt-repository ppa:webupd8team/java -y
	apt-get -qy update
	sudo apt-get -y update
	sudo apt-get install -y software-properties-common debconf-utils
	sudo add-apt-repository -y ppa:webupd8team/java
	sudo apt-get -y update
	sudo echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | sudo debconf-set-selections
	sudo apt-get install -y oracle-java8-installer
	wget http://mirror.olnevhost.net/pub/apache/tomcat/tomcat-9/v9.0.14/bin/apache-tomcat-9.0.14.tar.gz && mkdir  /opt/apache-tomcat9
	mkdir  /opt/apache-tomcat9
	tar xzvf apache-tomcat-9*tar.gz -C /opt/apache-tomcat9 --strip-components=1
	groupadd tomcat
	useradd -s /bin/false -g tomcat -d /opt/apache-tomcat9 tomcat
	cd /opt/apache-tomcat9
	chgrp -R tomcat /opt/apache-tomcat9
	chmod -R g+r conf
	chmod g+x conf
	chown -R tomcat webapps/ work/ temp/ logs/
	update-java-alternatives -l
	echo "CATALINA_HOME="/opt/apache-tomcat9"" >> /etc/environment
	echo "JAVA_HOME="/usr/lib/jvm/java-8-oracle"" >> /etc/environment
	echo "JRE_HOME="/usr/lib/jvm/java-8-oracle/jre"" >> /etc/environment
	source /etc/environment
	echo $JAVA_HOME
	tail -n 1 "/opt/apache-tomcat9/conf/tomcat-users.xml" | wc -c | xargs -I {} truncate "/opt/apache-tomcat9/conf/tomcat-users.xml" -s -{}
	echo  "<user username="admin" password="password" roles="manager-gui,admin-gui"/>\n</tomcat-users>" >> /opt/apache-tomcat9/conf/tomcat-users.xml
	sed -i 's/8080/8088/g' /opt/apache-tomcat9/conf/server.xml
	chmod +x /opt/apache-tomcat9/bin/startup.sh
	sh /opt/apache-tomcat9/bin/startup.sh
	ufw allow 8088
	ufw allow 8004
	ufw allow 8009
	echo "config Postgres-master"
	#echo "192.168.100.100 master-server" >> /etc/hosts
	#echo "host    replication     replica      192.168.100.200/24            md5" >> /etc/postgresql/11/main/pg_hba.conf
	#echo -e "listen_addresses = '*'\nwal_level = hot_standby\ncheckpoint_segments = 8\narchive_mode = on\narchive_command = 'cp -i %p /var/lib/postgresql/11/main/archive/%f'\nmax_wal_senders = 3\nwal_keep_segments = 8" >> /etc/postgresql/11/main/postgresql.conf
	#echo -e "postgres\npostgres" | passwd postgres
	echo "Build"
	mkdir ~/project/
	cd ~/project
	git clone https://github.com/PeterIanush/Geocitizen.git
	cd Geocitizen
	mvn clean install -DskipTests
	echo "Delivery"
	sh /opt/apache-tomcat9/bin/shutdown.sh
	cp target/citizen.war /opt/apache-tomcat9/webapps/
	sed -i 's/peer/md5/g' /etc/postgresql/11/main/pg_hba.conf
	sudo -i PGPASSWORD=postgres -u postgres psql -d template1 -c "ALTER USER postgres WITH PASSWORD 'postgres';"
	#echo -e "postgres" | sudo -i -u postgres psql -c 'createdb ss_demo_1;'
	sudo PGPASSWORD=postgres -u postgres psql -c 'CREATE DATABASE "ss_demo_2";'
	#sudo -u postgres psql -c 'grant all privileges on database ss_demo_1 to postgres;'
	sudo PGPASSWORD=postgres -u postgres psql -c 'GRANT ALL PRIVILEGES ON DATABASE "ss_demo_1" to postgres;'
	#sudo PGPASSWORD=postgres -u postgres psql -c 'GRANT ALL PRIVILEGES ON DATABASE "ss_demo_1" to postgres;'
	#sudo PGPASSWORD=postgres -u postgres psql -c 'GRANT CONNECT ON DATABASE ss_demo_1 TO postgres;'
	#sudo PGPASSWORD=postgres -u postgres psql -c 'GRANT USAGE ON SCHEMA public TO postgres;'
	#sudo PGPASSWORD=postgres -u postgres psql -c 'GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA ss_demo_1 TO postgres;'
	#sudo PGPASSWORD=postgres -u postgres psql -c 'GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO postgres;'
	ufw allow 5432
	sudo systemctl restart postgresql && sh /opt/apache-tomcat9/bin/shutdown.sh && sh /opt/apache-tomcat9/bin/startup.sh