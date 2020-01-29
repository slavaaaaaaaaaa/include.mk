RELEASE_NAME?=
CHART_DIR?=helm/
VALUES_FILE?=$(CHART_DIR)/values.yaml

OPTIONS?=

.PHONY: helm-install helm-upgrade helm-delete helm-status

helm-install::
ifdef RELEASE_NAME
	helm install $(RELEASE_NAME) $(CHART_DIR) \
		-f $(VALUES_FILE) \
		$(OPTIONS)
endif

helm-upgrade::
ifdef RELEASE_NAME
	helm upgrade $(RELEASE_NAME) $(CHART_DIR) \
		-f $(VALUES_FILE) \
		$(OPTIONS)
endif

helm-delete::
ifdef RELEASE_NAME
	helm delete $(RELEASE_NAME)
endif

helm-status::
ifdef RELEASE_NAME
	helm status $(RELEASE_NAME)
endif
