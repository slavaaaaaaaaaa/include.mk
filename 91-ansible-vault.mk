VAULT_VARS_FILE?=inventory/group_vars/all.yml
VAULT_PASSWORD_FILE?=secret/vault_password

.PHONY: vault_encrypt vault_decrypt

vault_encrypt: $(VAULT_VARS_FILE) $(VAULT_PASSWORD_FILE)
	ansible-vault encrypt --vault-password-file=$(VAULT_PASSWORD_FILE) $(VAULT_VARS_FILE)
	mv $(VAULT_VARS_FILE) $(VAULT_VARS_FILE).enc

vault_decrypt: $(VAULT_VARS_FILE).enc $(VAULT_PASSWORD_FILE)
	ansible-vault decrypt --vault-password-file=$(VAULT_PASSWORD_FILE) $(VAULT_VARS_FILE).enc
	mv $(VAULT_VARS_FILE).enc $(VAULT_VARS_FILE)

$(VAULT_VARS_FILE)%:
	test -f $$(echo $@ | sed -e 's/.o$$//') # please for the love of god someone tell me how to fix this

$(VAULT_PASSWORD_FILE):
	ENCRYPTABLE=$(VAULT_PASSWORD_FILE) make decrypt
