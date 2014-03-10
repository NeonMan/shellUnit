ccflags = -std=c++11 -Wall -Werror

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
	cp -rf ./doc/* /usr/share/doc/shunit
	cp Makefile /usr/share/doc/shunit
	cp shu.sh /usr/bin/
	cp shpp.sh /usr/bin/
	ln -s ./shu.sh /usr/bin/shu
	ln -s ./shpp.sh /usr/bin/shpp
	cp shellunit-out-pretty /usr/bin
	cp shellunit-out-junit /usr/bin
	cp shellunit.conf /etc/shellunit.conf

remove:
	-rm -rfv /usr/share/shunit.d
	-rm -rfv /usr/share/doc/shunit
	-rm /usr/bin/shu
	-rm /usr/bin/shu.sh
	-rm /usr/bin/shpp
	-rm /usr/bin/shpp.sh
	-rm /usr/bin/shellunit-out-pretty
	-rm /usr/bin/shellunit-out-junit
	-rm /etc/shellunit.conf

clean:
	-rm ./doc/*.html
	-rm ./doc/*.pdf
	-rm ./doc/*.epub
	-rm *.o
	-rm shellunit-out-pretty
	-rm shellunit-out-junit
#
#Executables
#
exec: shellunit-out-pretty shellunit-out-junit

shellunit-out-junit: shellunit-out-junit.cpp
	c++ $(ccflags) -o $@ $^

shellunit-out-pretty: shellunit-out-pretty.cpp
	c++ $(ccflags) -o $@ $^

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

quickstart:
	cd doc && ./mkdoc.sh > doc.html && cd ..
