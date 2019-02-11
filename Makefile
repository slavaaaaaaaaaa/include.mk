GITROOT=$(shell git rev-parse --show-toplevel)/../

.DEFAULT_GOAL=toc

include $(shell test -d $(GITROOT)/include.mk/ || (git clone git@github.com:smaslennikov/include.mk.git && rm -rf include.mk/.git) && echo $(GITROOT))/include.mk/*.mk

define RECIPIENTS
-r me@smaslennikov.com
endef
