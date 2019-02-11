BASTION_HOST?=
BASTION_USERNAME?=
EXTRA_BASTION_ARGS?=

.PHONY: bastion

bastion: $(SSH_KEY)
	ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $(EXTRA_BASTION_ARGS) $(BASTION_HOST) -l $(BASTION_USERNAME) -i $(SSH_KEY)

$(SSH_KEY):
	$(MAKE) decrypt
