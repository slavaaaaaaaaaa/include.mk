VAULT_VARS_FILE?=inventory/group_vars/all
VAULT_PASSWORD_FILE?=secret/vault_password

.PHONY: vault_encrypt vault_decrypt

vault_encrypt: $(VAULT_VARS_FILE)
	ansible-vault encrypt --vault-password-file=$(VAULT_PASSWORD_FILE) $(VAULT_VARS_FILE)
	mv $(VAULT_VARS_FILE) $(VAULT_VARS_FILE).enc

vault_decrypt: $(VAULT_VARS_FILE).enc
	ansible-vault decrypt --vault-password-file=$(VAULT_PASSWORD_FILE) $(VAULT_VARS_FILE).enc
	mv $(VAULT_VARS_FILE).enc $(VAULT_VARS_FILE)

$(VAULT_VARS_FILE)%:
	test -f $@
