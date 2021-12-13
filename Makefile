.DEFAULT_GOAL := docs
# MAKEFLAGS += -j8

sources := $(wildcard *.md)
objects := $(patsubst %.md,docs/%.html,$(subst $(source),$(output),$(sources)))

docs: $(objects)

docs/%.html: %.md
	pandoc -f markdown -s $^ -t html \
		   -M pagetitle=$(basename $^) --lua-filter=docs/links-to-html.lua \
		   -o $@
