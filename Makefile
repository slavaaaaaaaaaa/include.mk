GITROOT=$(shell git rev-parse --show-toplevel)/../

.DEFAULT_GOAL=toc

include $(shell test -d $(GITROOT)/include.mk/ || git clone https://github.com/sadasystems/include.mk && echo $(GITROOT))/include.mk/*.mk

define RECIPIENTS
-r me@smaslennikov.com
endef
