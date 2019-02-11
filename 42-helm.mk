RELEASE_NAME?=
VALUES_FILE?=

.PHONY: install upgrade delete status

install::
ifdef RELEASE_NAME
	helm install helm/ -n $(RELEASE_NAME) -f $(VALUES_FILE)
endif

upgrade::
ifdef RELEASE_NAME
	helm upgrade -f $(VALUES_FILE) $(RELEASE_NAME) helm/
endif

delete::
ifdef RELEASE_NAME
	helm delete $(RELEASE_NAME) --purge
endif

status::
ifdef RELEASE_NAME
	helm status $(RELEASE_NAME)
endif
