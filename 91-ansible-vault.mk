VAULT_VARS_FILE?=inventory/group_vars/all
VAULT_PASSWORD_FILE?=secret/vault_password

.PHONY: vault_encrypt vault_decrypt

vault_encrypt: $(VAULT_PASSWORD_FILE)
	for i in $(VAULT_VARS_FILE); do \
		test -f $$i; \
		ansible-vault encrypt --vault-password-file=$(VAULT_PASSWORD_FILE) $$i; \
		mv $$i $$i.enc; \
	done

vault_decrypt: $(VAULT_PASSWORD_FILE)
	for i in $(VAULT_VARS_FILE); do \
		test -f $$i.enc; \
		ansible-vault decrypt --vault-password-file=$(VAULT_PASSWORD_FILE) $$i.enc; \
		mv $$i.enc $$i; \
	done

$(VAULT_PASSWORD_FILE):
	ENCRYPTABLE=$(VAULT_PASSWORD_FILE) make decrypt
