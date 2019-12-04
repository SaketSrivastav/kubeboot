CMD="hostname"
MASTER_NODE="km"

clean-cluster:
	rm -f ansible/join-command && rm -f /tmp/join-command
	vagrant destroy -f

check-nodes-ready:
	vagrant ssh $(MASTER_NODE) -c "kubectl get nodes"

 # starts all worker nodes except master. autostart flag in Vagrantfile makes it possible
cluster-up:
	vagrant up 

master-up:
	vagrant up $(MASTER_NODE)

boot-cluster:
	clean-cluster master-up cluster-up check-nodes-ready