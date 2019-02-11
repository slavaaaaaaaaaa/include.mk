VAULT_VARS_FILE?=inventory/group_vars/all
VAULT_PASSWORD_FILE?=secret/vault_password

.PHONY: vault_encrypt vault_decrypt check_vault_enc check_vault_dec

vault_encrypt: check_vault_enc
	ansible-vault encrypt --vault-password-file=$(VAULT_PASSWORD_FILE) $(VAULT_VARS_FILE)
	mv $(VAULT_VARS_FILE) $(VAULT_VARS_FILE).enc

vault_decrypt: check_vault_dec
	ansible-vault decrypt --vault-password-file=$(VAULT_PASSWORD_FILE) $(VAULT_VARS_FILE).enc
	mv $(VAULT_VARS_FILE).enc $(VAULT_VARS_FILE)

check_vault_dec:
	test -f $(VAULT_VARS_FILE).enc

check_vault_enc:
	test -f $(VAULT_VARS_FILE)
