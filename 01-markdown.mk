.PHONY: toc

TOC_TARGET?=README.md

toc:
	markdown-toc --prepend'' --indent "    " -i $(TOC_TARGET)
