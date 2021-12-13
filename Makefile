.DEFAULT_GOAL := docs
PANDOC ?= pandoc
MAKEFLAGS += -j8

sources := $(wildcard *.md)
objects := $(patsubst %.md,docs/%.html,$(subst $(source),$(output),$(sources)))

docs: $(objects)

docs/%.html: %.md
	$(PANDOC) -f markdown -s $^ -t html \
	          -M pagetitle=$(basename $^) --lua-filter=docs/links-to-html.lua \
	          -V linestretch=1.8 -o $@
