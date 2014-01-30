ccflags = -Wall -Werror

#Make all targets EXCEPT pdf since pdflatex is freakin' huge
simple: doc exec

#Make all targets
all: simple pdf

install:
	mkdir /usr/share/shunit.d
	cp ./shunit.d/* /usr/share/shunit.d/
	mkdir /usr/share/doc/shunit
	cp -rf ./sample_tests /usr/share/doc/shunit
	cp COPYING /usr/share/doc/shunit
	cp ./doc/* /usr/share/doc/shunit
	cp Makefile /usr/share/doc/shunit
	cp shunit.sh /usr/bin/
	cp shpp.sh /usr/bin/
	ln -s ./shunit.sh /usr/bin/shunit
	ln -s ./shpp.sh /usr/bin/shpp
	cp shunit-out-pretty /usr/bin

remove:
	-rm -rfv /usr/share/shunit.d
	-rm -rfv /usr/share/doc/shunit
	-rm /usr/bin/shunit
	-rm /usr/bin/shunit.sh
	-rm /usr/bin/shpp
	-rm /usr/bin/shpp.sh
	-rm /usr/bin/shunit-out-pretty
clean:
	-rm ./doc/*.html
	-rm ./doc/*.pdf
	-rm ./doc/*.epub
	-rm *.o
	-rm shunit-out-pretty

#
#Executables
#
exec: shunit-out-pretty

shunit-out-pretty: shunit-out-pretty.cpp
	c++  $(ccflags) -o shunit-out-pretty shunit-out-pretty.cpp

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

