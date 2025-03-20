.PHONY: toc

TOC_TARGET?=README.md
TOC_EXTRA_ARGS?=
TOC_ARGS?=--prepend'' --indent "    " --maxdepth=3 $(TOC_EXTRA_ARGS)

toc:
	markdown-toc $(TOC_ARGS) -i $(TOC_TARGET)
