.PHONY: help virtualbox aws vagrant_up  vagrant_clean
.SILENT:

VERSION = 16.04
DISTRO = ubuntu

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


virtualbox: vagrant_clean ## build virtualbox image
		rm $(DISTRO)-$(VERSION)-x64-virtualbox.box 2>/dev/null; true
		packer build -only=virtualbox-iso ubuntu1604.json

vmware: vagrant_clean ## build vmware image
		rm $(DISTRO)-$(VERSION)-x64-virtualbox.box 2>/dev/null; true
		packer build -only=vmware-iso ubuntu1604.json

aws: ## build aws image
	  packer build -only=amazon-ebs ubuntu1604.json

vagrant_up: ## starts the vagrant box
		vagrant up

vagrant_clean: ## stops and removes vagrant box
		vagrant destroy -f 2>/dev/null; true
		vagrant box remove file://$(DISTRO)-$(VERSION)-x64-virtualbox.box 2>/dev/null; true
		vagrant box list
