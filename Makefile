defaults := defaults/site
md_dir := markdown
md_sources := $(wildcard $(md_dir)/*.md)
html_dir := plweb
html_targets := $(subst $(md_dir), $(html_dir),$(subst .md,.html,$(md_sources)))
layout := ./layouts/site.html

sitepath=/Users/heades/website/heades.github.io/plweb

all : $(html_targets) 

$(html_dir)/%.html : $(md_dir)/%.md Makefile
	pandoc -s -d $(defaults) -o $@ $<

serve :
	http-server

push: all
	cp -R $(html_dir)/* $(sitepath)
	cd $(sitepath) && git add . && git commit -a -m 'Updating PL Website.' && git push

clean :
	rm -f plweb/*.html
