# 2020/05 BuRnCycL 

# Verify we have what we need.
ifeq (, $(shell which ansible-playbook))
$(error Ansible Installation Not Found!)
else
export ANSIBLE_PLAYBOOK := $(shell which ansible-playbook)
endif
ifeq (, $(shell which git))
$(error Git Installation Not Found!)
else
export GIT := $(shell which git)
endif

# Declare variables, not war.
ROLES_DIR := ./roles
PLAYBOOK := ./base.yml
INVENTORY := ./inventory

all: 
	$(info make env)
	$(info Will Make Dev Environment)
	$(error Please specify. )

env:
	$(ANSIBLE_PLAYBOOK) -i $(INVENTORY) $(PLAYBOOK) --ask-vault-pass

surgical:
	$(ANSIBLE_PLAYBOOK) -i $(INVENTORY) $(PLAYBOOK) --tags "golang" --ask-vault-pass

