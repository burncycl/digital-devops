# 2020/05 Michael Grate

# Verify we have what we need.
ifeq (, $(shell which terraform))
$(error Terraform Installation Not Found!)
else
export TERRAFORM := $(shell which terraform)
endif
ifeq (, $(shell which kubectl))
$(error kubectl Installation Not Found!)
else
export KUBECTL := $(shell which kubectl)
endif
ifeq (, $(shell which aws))
$(error awscli Installation Not Found!)
else
export AWSCLI := $(shell which aws)
endif
ifeq (, $(shell which helm))
$(error helm Installation Not Found!)
else
export HELM := $(shell which helm)
endif


# Handle no targets specified.
all:
	$(info make cluster)
	$(error No target specified.)



cluster: init fmt validate plan apply 
finalize: kubeconfig configmap nginx status
destroy_cluster: init validate destroy_noask


# Silently remove old terraform init. Surpress errors.
clean:
	@rm -rf ./.terraform ||:
	@rm -rf ./terraform.tfstate.backup ||:
	@rm -rf ./terraform.tfstate ||:


# Terraform
init:
	$(TERRAFORM) init

fmt:
	$(TERRAFORM) fmt 

validate:
	$(TERRAFORM) validate 

plan:
	$(TERRAFORM) plan

apply:
	$(TERRAFORM) apply -auto-approve

destroy:
	$(TERRAFORM) destroy

destroy_noask: # WARNING: Extremely impactful!
	$(TERRAFORM) destroy -auto-approve


# Export kubeconfig from Terraform output for base user so we can use commands like kubectl.
# Reference: https://aws.amazon.com/premiumsupport/knowledge-center/eks-api-server-unauthorized-error/
# TODO # Could stand to improve this section, parameterize things. 
kubeconfig:
	#$(TERRAFORM) output kubeconfig > ~/.kube/config # This didn't work, so opted for using aws cli + roles. But leaving for posterity
	@cp ~/.kube/config ~/.kube/config.bak ||:
	@rm ~/.kube/config ||:
	$(AWSCLI) eks --region us-west-2 update-kubeconfig --name digital-devops-eks-cluster --role-arn arn:aws:iam::351484734788:role/automation-role
	@sleep 1

# Apply Config Map # Grants access to run commands against EKS cluster. Facilitates communication with EKS master.
configmap:
	$(TERRAFORM) output config_map_aws_auth > configmap.yml 
	$(KUBECTL) apply -f configmap.yml 
	@sleep 3

nginx:
	$(HELM) repo add nginx-stable https://helm.nginx.com/stable
	$(HELM) repo update
	$(HELM) install digital-devops nginx-stable/nginx-ingress
	@sleep 5

status:
	$(info IMPORTANT: The External IP/ELB address below is used with your CNAME record in DNS (e.g. devops.fyzix.net).)
	$(KUBECTL) get svc
	$(KUBECTL) get nodes -o wide 

