# -*- mode: ruby -*-

# vi: set ft=ruby :



Vagrant.configure("2") do |config|

  # config.vm.box = "Ubuntu-16LTS"

  config.vm.box = "ubuntu/xenial64"




  config.vm.network "forwarded_port", guest: 8080, host: 8090

  config.vm.provider "virtualbox" do |vb|

     vb.memory = "1024"

  end



  config.vm.provision "shell", inline: <<-SHELL

    apt-get update -y

    apt-get upgrade -y

    echo "Install common tools"

    apt-get install -y nano git

    echo "Install Java and Maven"

    apt-get install -y maven 
	
	echo mvn -version

    echo "Install Ruby"

    apt-get install -y ruby

    echo "Install Python 2"

    apt-get install -y python python-pip

    echo "Install Python 3"

    apt-get install -y python3 python3-pip
	
	echo "Installing PostgreSQL"
	
	apt install -y postgresql postgresql-contrib
	


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
