# CS_Project1_ELK
Creating a cloud monitoring system by configuring an ELK server
## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![ELK Network Diagram](https://github.com/TaylorTopp/CS_Project1_ELK/blob/main/Images/Cloud-ELK-Network.PNG)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the YAML playbook file may be used to install only certain pieces of it, such as Filebeat.

  - _TODO: Enter the playbook file._

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
- _TODO: What aspect of security do load balancers protect? What is the advantage of a jump box?_

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the files and system logs.
- _TODO: What does Filebeat watch for?_
- _TODO: What does Metricbeat record?_

The configuration details of each machine may be found below.
_Note: Use the [Markdown Table Generator](http://www.tablesgenerator.com/markdown_tables) to add/remove values from the table_.

| Name     | Function | Local IP Address | Public IP Address | Operating System |
|----------|----------|------------|----------------|------------------|
| Jump-Box-Provisioner | Gateway  | 10.0.0.4 | 20.211.168.169  | Linux (ubuntu 20.04)           |
| Web-1     | DVWA Container Host         | 10.0.0.5 | N/A          | Linux (ubuntu 20.04)                 |
| Web-2     | DVWA Container Host         | 10.0.0.6 | N/A          | Linux (ubuntu 20.04)                 |
| ELK-VM     | ELK Stack Server         | 10.1.0.4 | 40.127.93.150          | Linux (ubuntu 20.04)                 |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the _____ machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
- _TODO: Add whitelisted IP addresses_

Machines within the network can only be accessed by _____.
- _TODO: Which machine did you allow to access your ELK VM? What was its IP address?_

A summary of the access policies in place can be found in the table below.

| Name     | Publicly Accessible | Allowed IP Addresses |
|----------|---------------------|----------------------|
| Jump Box | Yes/No              | 10.0.0.1 10.0.0.2    |
|          |                     |                      |
|          |                     |                      |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because...
- _TODO: What is the main advantage of automating configuration with Ansible?_

The playbook implements the following tasks:
- _TODO: In 3-5 bullets, explain the steps of the ELK installation play. E.g., install Docker; download image; etc._
- ...
- ...

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

![TODO: Update the path with the name of your screenshot of docker ps output](Images/docker_ps_output.png)

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- _TODO: List the IP addresses of the machines you are monitoring_

We have installed the following Beats on these machines:
- _TODO: Specify which Beats you successfully installed_

These Beats allow us to collect the following information from each machine:
- _TODO: In 1-2 sentences, explain what kind of data each beat collects, and provide 1 example of what you expect to see. E.g., `Winlogbeat` collects Windows logs, which we use to track user logon events, etc._

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the _____ file to _____.
- Update the _____ file to include...
- Run the playbook, and navigate to ____ to check that the installation worked as expected.
- See playbook used for this install ![here](https://github.com/TaylorTopp/CS_Project1_ELK/blob/main/Ansible/elk-install.yml) or the below section.
- <details><summary>YAML playbook for ELK Install</summary>
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

_TODO: Answer the following questions to fill in the blanks:_
- _Which file is the playbook? Where do you copy it?_
- _Which file do you update to make Ansible run the playbook on a specific machine? How do I specify which machine to install the ELK server on versus which to install Filebeat on?_
- _Which URL do you navigate to in order to check that the ELK server is running?

_As a **Bonus**, provide the specific commands the user will need to run to download the playbook, update the files, etc._
