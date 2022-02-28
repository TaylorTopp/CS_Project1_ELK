# CS_Project1_ELK
Creating a cloud monitoring system by configuring an ELK server
## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![ELK Network Diagram](https://github.com/TaylorTopp/CS_Project1_ELK/blob/main/Diagrams/Cloud-ELK-Network1.PNG)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the YAML playbook file may be used to install only certain pieces of it, such as Filebeat.

This document contains the following details:
- Description of the Topologu
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly available, in addition to restricting traffic to the network.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the files and system logs.

The configuration details of each machine may be found below.

| Name     | Function | Local IP Address | Public IP Address | Operating System |
|----------|----------|------------|----------------|------------------|
| Jump-Box-Provisioner | Gateway  | 10.0.0.4 | 20.211.168.169  | Linux (ubuntu 20.04)           |
| Web-1     | DVWA Container Host         | 10.0.0.5 | 20.211.31.149 (Load Balancer)          | Linux (ubuntu 20.04)                 |
| Web-2     | DVWA Container Host         | 10.0.0.6 | 20.211.31.149 (Load Balancer)         | Linux (ubuntu 20.04)                 |
| ELK-VM     | ELK Stack Server         | 10.1.0.4 | 40.127.93.150          | Linux (ubuntu 20.04)                 |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the Jump-Box-Provisioner machine can accept connections from the Internet. Access to this machine is only allowed from the following IP address:
- 115.128.11.95

Machines within the network can only be accessed by the Jump Box machine, with IP 10.0.0.4.

A summary of the access policies in place can be found in the table below.

| Name     | Publicly Accessible | Allowed Internal IP Addresses | Allowed Public IP Addresses* |
|----------|---------------------|----------------------|-------------------|
| Jump-Box-Provisioner | Yes          | N/A    | 115.128.11.95    |
| Web-1         | No                    | 10.0.0.4                     | 115.128.11.95 |
| Web-2         | No                    | 10.0.0.4                     | 115.128.11.95 |
| ELK-VM        | No                    | 10.0.0.4                     | 115.128.11.95 |

**Note the public IP address can only access the docker image being hosted on the VM, for Web-1 & Web-2 this is DVWA, for ELK-VM this is Kibana*

### DVWA Setup and Configuration

For future pentesting capabilities and public facing access to select machine, a DVWA docker image was set up on both of the Web VM's.

This was done using another ansible playbook which can be found [here](https://github.com/TaylorTopp/CS_Project1_ELK/blob/main/Ansible/dvwa_playbook.yml).

This playbook does the following on the targetted webservers:
- Install docker & docker.io
- Install python3
- Download and install the DVWA docker container and allow port 80
- Ensure docker image runs on startup

To run this playbook simply use `ansible-playbook dvwa_playbook.yml`

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because it allows docker images to be redeployed to the machines instantly. This means minor changes can be made to the playbook file and distributed with a single command.

The playbook implements the following tasks:
- Sets the virtual memory map count to 262144 and fixed this value on startup
- Installs docker, docker.io, and python3
- Downloads and installs the ELK stack from sepb/elk, and allows access on ports 5601, 9200, and 5044
- Enables docker service on system boot

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

![docker ps output](https://github.com/TaylorTopp/CS_Project1_ELK/blob/main/Ansible/docker_ps.PNG)

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- Web-1 : 10.0.0.5
- Web-2 : 10.0.0.6

We have installed the following Beats on these machines:
- Filebeat
- Metricbeat

These Beats allow us to collect the following information from each machine:
- Filebeat monitors and collects logs for files and locations specified on the target machine. This will help track any changes to files in these systems.
- Metricbeat collects data from the operating system and services running on the target machine. Metricbeat will help monitor the health of the machines and determine and issues with their performance.

### Configuring Filebeat & Metricbeat

Note it is essential to download and install configuration playbooks for Filebeat & Metricbeat to ensure the elk-install.yml playbook works as this playbook is a full ansible configuration for installation of ELK stack on the ELK-VM, and Filebeat & Metricbeat on the Web VM's.

For the metricbeat and filebeat portions you will also need to do the following:
- Type the following commands for filebeat and metricbeat respectively:
  - `curl https://gist.githubusercontent.com/slape/5cc350109583af6cbe577bbcc0710c93/raw/eca603b72586fbe148c11f9c87bf96a63cb25760/Filebeat > /etc/ansible/filebeat-config.yml`
  - `curl https://gist.githubusercontent.com/slape/58541585cc1886d2e26cd8be557ce04c/raw/0ce2c7e744c54513616966affb5e9d96f5e12f73/metricbeat > /etc/ansible/metricbeat-config.yml`
- Edit filebeat-config.yml
  - Line #1106 & #1806: replace the IP with your ELK-VM IP
- Edit metricbeat-config.yml
  - Line #62 & #95: replace the IP with your ELK-VM IP
- Once the playbook has run verify the data is being collected by going to the Kibana webpage, and then the following:
  - For filebeat, select "Add Log Data" > "System Logs" > "DEB", scroll to Step 5: Module Status and click "Check Data". You should see a message as per the image below.
  - For metricbeat, select "Add metric data" > "System metrics" > "DEB", scroll to Step 5 and click "Check Data". You should see a message as per the image below.

Filebeat status confirmation:
![filebeat status](https://github.com/TaylorTopp/CS_Project1_ELK/blob/main/Diagrams/Filebeat_OK.PNG)

Metricbeat status confirmation:
![metricbeat status](https://github.com/TaylorTopp/CS_Project1_ELK/blob/main/Diagrams/Metricbeat_OK.PNG)

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the elk-install.yml file to /etc/ansible.
- Update the playbook file to include the correct hosts that you wish to target. You may need to specify the hosts in the ansible.cfg file.
- Run the playbook by using `ansible-playbook elk-install.yml`, and navigate to the target via SSH to check that the installation worked as expected. You will then need to run `sudo docker ps` as above to ensure the container is running.
- You can then navigate to the public IP of the ELK-VM at http://your-IP:5601/app/kibana#/home?_g=() to ensure that Kibana is running. You will also need to ensure you network security group is correctly configured to allow traffic on port 5601 to the ELK-VM from your local machine.
- See playbook used for this install [here](https://github.com/TaylorTopp/CS_Project1_ELK/blob/main/Ansible/elk-install.yml)

<details>
  <summary>Or you can view it here!</summary>
  
  ```
---
- name: ELK Installer
  hosts: elk
  remote_user: ELKUser
  become: true
  tasks:

  - sysctl:
      name: vm.max_map_count
      value: 262144
      state: present
  - name: increase vm on startup
    command: echo "vm.max_map_count" >> /etc/sysctl.conf
  - name: docker.io install
    apt:
     update_cache: yes
     name: docker.io
     state: present
  - name: python3
    apt:
     name: python3-pip
     state: present
  - name: docker
    pip:
     name: docker
     state: present  
  - name: install elk docker container
    docker_container:
     name: ELK
     image: sebp/elk:761
     state: started
     restart_policy: always
     published_ports:
      - "5601:5601"
      - "9200:9200"
      - "5044:5044"
  - name: Enable service docker on boot
    systemd:
     name: docker
     enabled: True

- name: Configure filebeat
  hosts: webservers
  become: true
  tasks:

    - name: Download .deb file
      get_url:
       url: https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.4.0-amd64.deb
       dest: /etc

    - name: Install filebeat
      command: dpkg -i /etc/filebeat-7.4.0-amd64.deb

    - name: copy config file
      copy:
       src: /etc/ansible/filebeat-config.yml
       dest: /etc/filebeat/filebeat.yml

    - name: enable filebeat
      command: filebeat modules enable system

    - name: filebeat setup
      command: filebeat setup

    - name: start filebeat
      command: service filebeat start

    - name: Enable service filebeat on boot
      systemd:
       name: filebeat
       enabled: True
- name: Configure metricbeat
  hosts: webservers
  become: true
  tasks:

    - name: Download .deb file
      get_url:
       url: https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-7.4.0-amd64.deb
       dest: /etc

    - name: Install metricbeat
      command: dpkg -i /etc/metricbeat-7.4.0-amd64.deb

    - name: copy config file
      copy:
       src: /etc/ansible/metricbeat-config.yml
       dest: /etc/metricbeat/metricbeat.yml

    - name: enable metricbeat
      command: metricbeat modules enable docker

    - name: metricbeat setup
      command: metricbeat setup

    - name: Enable service metricbeat on boot
      systemd:
       name: metricbeat
       enabled: True
  ```
</details>
