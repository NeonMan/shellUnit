all: html

html: index.html readme.html

readme.html: readme.mdn
	markdown $^ > $@

index.html: index.mdn
	markdown $^ > $@

clean:
	-rm *.html
