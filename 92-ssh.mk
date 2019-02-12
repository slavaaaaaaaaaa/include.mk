SSH_KEY_FILE?=secret/id_rsa
SSH_KEY_COMMENT?=

.PHONY: generate-ssh-key

generate-ssh-key:
	ssh-keygen -trsa -b4096 -N '' -C '$(SSH_KEY_COMMENT)' -f $(SSH_KEY_FILE)
