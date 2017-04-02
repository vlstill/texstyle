ALL_MD=$(wildcard *.md)

all : mds pres.pdf

.PRECIOUS: %.md.tex %.pdf

mds :	$(ALL_MD:.md=.pdf)

%.pdf : %.md paradise-slide.cls template.tex
	 pandoc --slide-level=2 -V documentclass=paradise-slide -s $< -t beamer -f markdown+raw_tex -o $@ --template=template.tex

pres.pdf : pres.tex paradise-slide.cls
	rubber --pdf $<
