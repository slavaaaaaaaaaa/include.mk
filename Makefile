GITROOT=$(shell git rev-parse --show-toplevel)/../

include $(shell test -d $(GITROOT)/include.mk/ || git clone https://github.com/sadasystems/include.mk && echo $(GITROOT))/include.mk/*.mk

define RECIPIENTS
-r me@smaslenikov.com
endef
