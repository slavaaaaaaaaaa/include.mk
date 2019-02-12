GPG_KEY?=secret/gpg_key
GPG_KEY_UID?=

define RECIPIENTS

endef

.PHONY: generate-secret generate-service-gpg-key decrypt encrypt reencrypt encryptable

generate-secret:
	tr -cd 'A-Za-z0-9-_' </dev/urandom | head -c 32 && echo

generate-service-gpg-key:
	GPG_KEY_ID=$$(gpg --passphrase '' --batch --quick-generate-key "$(GPG_KEY_UID)" default default never 2>&1 | grep key | cut -d' ' -f3) && \
	gpg --export-secret-key "$$GPG_KEY_ID" > secret/gpg_key

decrypt:: encryptable
	for i in $(ENCRYPTABLE); do \
		gpg -o $$i -d $$i.asc; \
	done

encrypt:: encryptable
	for i in $(ENCRYPTABLE); do \
		gpg $(BATCH) -o $$i.asc -ase $(RECIPIENTS) $$i; \
	done

reencrypt:
	for i in $$(find . -name "*.asc"); do \
		ENCRYPTABLE=$$(echo $$i | sed -e 's/\.asc//') BATCH="--batch --yes" $(MAKE) encrypt; \
	done

encryptable:
ifndef ENCRYPTABLE
	$(error "ENCRYPTABLE is not set. Set it with e.g.: $n$n\
	$$ export ENCRYPTABLE='secrets.yml')
endif
