
## Automating the Deployment of Kubernetes and Clearwater using Ansible

This project contains Ansible playbooks for deploying a Kubernetes cluster
and then installing Clearwater IMS to that Cluster.
The Clearwater deployment uses a fork of the Metaswitch project ![clearwater-docker](https://github.com/Teszko/clearwater-docker)

## Instructions

### 1) hosts.cfg
Adjust the entries in hosts.cfg  
The number of Nodes under the [slaves] tag is unlimited. You might want to do it one at a time though, for better chances of success. At the current state only one master is supported. Set up redundant masters for production grade systems.

### 2) run the install_master playbook
```bash
ansible-playbook -i hosts.cfg install_master.yml
```
After successfully running the Playbook, log into the master and run the command `kubectl get nodes`.
Wait for the state of the master to become "ready" before proceeding.

### 3) run the install_slaves playbook
```bash
ansible-playbook -i hosts.cfg install_slaves.yml
```
This will add all nodes listed in hosts.cfg to the cluster simultaneously. Only add one Node to [slaves] in hosts.cfg at a time and run this playbook repeatedly for higher chances of success.  
Run `kubectl get nodes` on the master again and check if the Nodes become ready.


### 4) run the populate_cluster.yml playbook
```bash
ansible-playbook -i hosts.cfg populate_cluster.yml
```

This will deploy weavecope and clearwater to the kubernetes cluster.
If successful, you should be able to reach weavescope and Ellis from any node in the cluster. 
Open http://<some node ip>:30840 in a browser to reach weavescope and http://<some node ip>:30080 to reach Ellis.
Ellis can take some time to generate phone numbers after initialization. You may have to wait a minute. 
Create an account using the signup code "secret".

