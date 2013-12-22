all: html pdf epub

epub: readme.epub

readme.epub: readme.mdn
	pandoc -f markdown $^ -o $@

pdf: readme.pdf

readme.pdf: readme.mdn
	pandoc -f markdown $^ -o $@

html: index.html readme.html

readme.html: readme.mdn
	markdown $^ > $@

index.html: index.mdn
	markdown $^ > $@

clean:
	-rm *.html
	-rm *.pdf
	-rm *.epub

