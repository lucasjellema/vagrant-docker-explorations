ENV['VAGRANT_DEFAULT_PROVIDER'] = 'docker'


Vagrant.configure("2") do |config|

  config.vm.define "my-little-container" do |m|
  
    m.vm.provider :docker do |d| 
      d.build_dir = "."
	  d.name = 'my-little-container'
      d.vagrant_machine = "dockerhostvm"
      d.vagrant_vagrantfile = "./DockerHostVagrantfile" 
      d.remains_running = true 
      d.volumes = ["/share_x/:/dock_host", "/host_data/:/dock_host_data"] 
      # (see issue https://github.com/mitchellh/vagrant/issues/3951) 
      d.has_ssh = true # essential for the provisioning to take place (execute Docker file to provision container)
	  # note: when the has_ssh parameter is not set to true, we would run into this message: 	Provisioners will not be run since container doesn't support SSH.
	
  	  # ports are in the form host: container (so we expose port 80 on the container through port 8080 on the docker host
	  ## we should be able to access the Apache Server from the Vagrant host at 10.10.10.29:8080
	  ## inside the Docker host we can access the Apache Server at localhost:8080 or at http://container_IP:8080
      d.ports = ["8080:80"] 
      d.cmd = ["/usr/sbin/apache2ctl","-D", "FOREGROUND"]

	  end
  end 


  config.vm.define "my-data-container" do |m|
  m.vm.synced_folder "c:/data", "/host_data"

  m.vm.provider :docker do |d| 
      d.build_dir = "data-docker"
	  d.name = 'my-data-container'
      d.vagrant_machine = "dockerhostvm"
      d.vagrant_vagrantfile = "./DockerHostVagrantfile" 
	end
  end 

  
  config.vm.define "my-tiny-container" do |m|
  
    m.vm.provider :docker do |d| 
      d.build_dir = "tiny-docker"
	  d.name = 'my-tiny-container'
      d.vagrant_machine = "dockerhostvm"
      d.vagrant_vagrantfile = "./DockerHostVagrantfile" 
      #d.image = 'ubuntu:14.04' 
      d.remains_running = true 
	  d.link("my-little-container:my-friend")
      d.cmd = ["ping", "-c 51", "127.0.0.1"] 
      d.create_args = ["--volumes-from=my-little-container" ,  "--volumes-from=my-data-container"]
	end
  end 
  
end

## later to get into the container: vagrant docker-run -t -- bash
## vagrant up --provider=docker 

## to find out about the IP address assigned to the container
## use the following statement from the docker host (use docker ps -a to find out about the container id)
## docker inspect -f '{{ .NetworkSettings.IPAddress }}' <container id>  

## to attach to the running container
## docker attach <container id>

## to execute a command in the running container (while the container is doing in another session/process whatever the CDM or ENTRYPOINT told it to do 
## docker exec -it <container -id> bash

## to run a container in interactive mode
## docker start -i  <container id>

## to start a shell in  a running container from the Vagrant Host
## vagrant docker-run -t  -- bash

## Need to reload the docker config? Use vagrant destroy -f && vagrant up to completely wipe your setup or just use vagrant provision to do an incremental upgrade of your box with the latest docker images.

## instructions on writing Docker files:  http://kimh.github.io/blog/en/docker/gotchas-in-writing-dockerfile-en/


## to remove containers (from within dockerhost): docker rm $(docker ps -a -q)