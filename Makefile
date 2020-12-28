defaults := defaults/site
latex_defaults := defaults/syllabus
md_dir := markdown
md_sources := $(wildcard $(md_dir)/*.md)
html_dir := plweb
html_targets := $(subst $(md_dir), $(html_dir),$(subst .md,.html,$(md_sources)))
html_layout := ./layouts/site.html
latex_layout := ./layouts/syllabus.latex

sitepath=/Users/heades/website/heades.github.io/plweb

all : $(html_targets) $(html_dir)/includes/syllabus.pdf

$(html_dir)/%.html : $(md_dir)/%.md Makefile $(html_layout)
	pandoc -s -d $(defaults) -o $@ $<

$(html_dir)/includes/syllabus.pdf : $(md_dir)/index.md $(latex_layout)
	pandoc -s -d $(latex_defaults) -o $(html_dir)/includes/syllabus.pdf $(md_dir)/index.md

serve :
	http-server

push: all
	cp -R $(html_dir)/* $(sitepath)
	cd $(sitepath) && git add . && git commit -a -m 'Updating PL Website.' && git push

clean :
	rm -f plweb/*.html
