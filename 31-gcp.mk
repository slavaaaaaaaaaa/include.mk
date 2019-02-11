.PHONY: gproject

gproject:
ifndef GOOGLE_PROJECT
	$(error "GOOGLE_PROJECT is not set. Set it with e.g.: $n$n\
	$$ export GOOGLE_PROJECT='my-project')
endif
