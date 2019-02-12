.PHONY: toc

MARKDOWN_FILE?=README.md

toc:
	markdown-toc --indent "    " -i $(MARKDOWN_FILE)
