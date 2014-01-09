#Make all targets EXCEPT pdf since pdflatex is freakin' huge
simple: doc

#Make all targets
all: doc pdf

install:
	mkdir /usr/share/shunit.d
	cp ./shunit.d/* /usr/share/shunit.d/
	mkdir /usr/share/doc/shunit
	cp -rf ./sample_tests /usr/share/doc/shunit
	cp COPYING /usr/share/doc/shunit
	cp ./doc/* /usr/share/doc/shunit
	cp Makefile /usr/share/doc/shunit
	cp shunit.py /usr/bin/
	ln -s ./shunit.py /usr/bin/shunit

remove:
	-rm -rfv /usr/share/shunit.d
	-rm -rfv /usr/share/doc/shunit
	-rm /usr/bin/shunit
	-rm /usr/bin/shunit.py

#
#Documentation
#
doc: html epub

epub: doc/readme.epub

doc/readme.epub: doc/readme.mdn
	pandoc -f markdown $^ -o $@

pdf: doc/readme.pdf

doc/readme.pdf: doc/readme.mdn
	pandoc -f markdown $^ -o $@

html: doc/index.html doc/readme.html

doc/readme.html: doc/readme.mdn
	markdown $^ > $@

doc/index.html: doc/index.mdn
	markdown $^ > $@

clean:
	-rm ./doc/*.html
	-rm ./doc/*.pdf
	-rm ./doc/*.epub
