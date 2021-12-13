.DEFAULT_GOAL := doc
# MAKEFLAGS += -j8

sources := $(wildcard *.md)
objects := $(patsubst %.md,doc/%.html,$(subst $(source),$(output),$(sources)))

doc: $(objects)

doc/%.html: %.md
	pandoc -f markdown -s $^ -t html \
		   -M pagetitle=$(basename $^) --lua-filter=doc/links-to-html.lua \
		   -o $@
