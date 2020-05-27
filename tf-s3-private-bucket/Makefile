# 2020/05 Michael Grate

# Setup Python virtual envrionment.
ifeq (, $(shell which python3))
$(error Python3 Installation Not Found!)
else
export PYTHON3_LOCAL := $(shell which python3)
endif
ifeq (, $(shell which virtualenv))
$(error Python Virtual Environment Installation Not Found!)
else
export VENV := $(shell which virtualenv)
endif
$(info Creating Virtual Environment...)
VENV_NAME := venv
CREATE_VENV3 := $(shell ${VENV} -p python3 ./${VENV_NAME})
VENV_ACTIVATE := ./${VENV_NAME}/bin/activate
PYTHON3 := ./${VENV_NAME}/bin/python3
PIP3 := ./${VENV_NAME}/bin/pip3
REQUIREMENTS := $(shell ${PIP3} install -r ./requirements.txt)
$(info Virtual Environment Created.)


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
test: boto3-test


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

# Tests
boto3-test:
	$(info Testing permissions and encryption are set correctly on s3 bucket.)
	$(PYTHON3) test.py

