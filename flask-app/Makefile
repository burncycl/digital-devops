# 2020/05 Michael Grate

# Verify we have what we need.
ifeq (, $(shell which kubectl))
$(error kubectl Installation Not Found!)
else
export KUBECTL := $(shell which kubectl)
endif
ifeq (, $(shell which helm))
$(error helm Installation Not Found!)
else
export HELM := $(shell which helm)
endif

NAMESPACE := flask-app
APP_NAME := flask-app
OVERRIDES := ./overrides.yml

# Handle no targets specified.
all:
	$(info make deploy or deploy_overrides)
	$(error No target specified.)




deploy:
	$(HELM) upgrade --install $(APP_NAME) --namespace $(NAMESPACE) --create-namespace ./helm/$(APP_NAME)


deploy_overrides:
	$(HELM) upgrade --install $(APP_NAME) --namespace $(NAMESPACE) --create-namespace -f $(OVERRIDES) ./helm/$(APP_NAME) 
