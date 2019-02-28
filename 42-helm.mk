RELEASE_NAME?=
VALUES_FILE?=

.PHONY: helm-install helm-upgrade helm-delete helm-status

helm-install::
ifdef RELEASE_NAME
	helm install helm/ -n $(RELEASE_NAME) -f $(VALUES_FILE)
endif

helm-upgrade::
ifdef RELEASE_NAME
	helm upgrade -f $(VALUES_FILE) $(RELEASE_NAME) helm/
endif

helm-delete::
ifdef RELEASE_NAME
	helm delete $(RELEASE_NAME) --purge
endif

helm-status::
ifdef RELEASE_NAME
	helm status $(RELEASE_NAME)
endif
