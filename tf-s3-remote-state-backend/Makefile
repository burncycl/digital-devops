# 2020/05 Michael Grate

# Verify we have what we need.
ifeq (, $(shell which terraform))
$(error Terraform Installation Not Found!)
else
export TERRAFORM := $(shell which terraform)
endif

# Handle no targets specified.
all:
	$(info make bucket)
	$(error No target specified.)


bucket: init fmt validate plan apply
destroy_bucket: init validate destroy_noask


# Silently remove old terraform init. Surpress errors.
clean:
	@rm -rf ./.terraform ||:
	@rm -rf ./terraform.tfstate.backup ||:
	@rm -rf ./terraform.tfstate ||:

# Backup this terraform instance / state, because we do not have a remote state for this piece of automation.
backup: 
	mkdir -p ../../tf-backup
	cd .. && tar czf ../tf-backup/tf-remote-state-s3-backend.tgz tf-remote-state-s3-backend


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

