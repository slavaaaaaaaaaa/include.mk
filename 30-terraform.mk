.PHONY: outputs kubeconfig-eks

outputs:
	terraform output

kubeconfig-eks:
	terraform init
	terraform output kubeconfig > kubeconfig
