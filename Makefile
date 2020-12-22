defaults := defaults/site
md_dir := markdown
md_sources := $(wildcard $(md_dir)/*.md)
html_dir := 
html_targets := $(subst $(md_dir)/, $(html_dir),$(subst .md,.html,$(md_sources)))
layout := ./layouts/site.html

all : $(html_targets) 

%.html : $(md_dir)/%.md Makefile
	pandoc -s -d $(defaults) -o $@ $<

serve :
	http-server

clean :
	rm -f *.html
