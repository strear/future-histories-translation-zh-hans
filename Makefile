.DEFAULT_GOAL := html
PANDOC ?= pandoc
MAKEFLAGS += -j8

sources := $(wildcard *.md)
objects := $(patsubst %.md,docs/%.html,$(subst $(source),$(output),$(sources)))

html: prep docs

docs: $(objects)

docs/%.html: %.md
	$(PANDOC) -f markdown -s "$^" -t html \
	          -M pagetitle=$^ --lua-filter=docs/links-to-html.lua \
	          -V lang=$$(case "$^" in [A-Z]*) echo "en-US";; *) echo "zh-CN";; esac) \
	          -V linestretch=1.8 -o $@

define _prep_script
mkdir -p docs
cat > docs/links-to-html.lua <<EOF
function Link(el)
	el.target = string.gsub(el.target, "%.md", ".html")
	return el
end
EOF
endef
export prep_script = $(value _prep_script)

prep:
	@ eval "$$prep_script"
