#! /usr/bin/env bash
echo 192.168.100.200 slave-server>> /etc/hosts
echo "Update && Upgrade"
    apt-get update -y
    apt-get upgrade -y
echo "Install Postgresql"
	apt-get install -y postgresql postgresql-client postgresql-contrib
echo "Install common tools"
    apt-get install -y git
echo "Config Postgresql"
	echo host    replication     replica      192.168.100.200/24            md5 >> /etc/postgresql/11/main/pg_hba.conf
	echo -e "listen_addresses = '*'\nwal_level = hot_standby\ncheckpoint_segments = 8\nmax_wal_senders = 3\nwal_keep_segments = 8\nhot_standby = on" >> /etc/postgresql/11/main/postgresql.conf
	systemctl stop postgresql