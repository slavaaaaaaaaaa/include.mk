TERRAFORM_DIR?=

.PHONY: dashboard token kubeconfig

dashboard: token
	kubectl proxy &
	open 'http://localhost:8001/api/v1/namespaces/kube-system/services/'

token:
	kubectl -n kube-system describe secret $(shell kubectl -n kube-system get secret | grep eks-admin | awk '{print $$1}')

kubeconfig:
	$(warning This will overwrite your kubeconfig in 10 seconds unless cancelled!)
	sleep 10
	$(eval BACKUP=~/.kube/config.bak$(shell date +%s))
	cp ~/.kube/config $(BACKUP) || mkdir -p ~/.kube
	$(MAKE) -C $(TERRAFORM_DIR) kubeconfig-eks
	KUBECONFIG=$(BACKUP):$(TERRAFORM_DIR)/kubeconfig kubectl config view --flatten > ~/.kube/config
