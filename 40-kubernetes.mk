.PHONY: apply

apply::
	for i in *.yaml; do \
		if [ -e "$$i" ]; then \
			kubectl apply -f $$i; \
		fi \
	done
