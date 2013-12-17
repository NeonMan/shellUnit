install:
	mkdir /usr/share/shunit.d
	cp ./shunit.d/* /usr/share/shunit.d/
	mkdir /usr/share/doc/shunit
	cp -rf ./sample_tests /usr/share/doc/shunit
	cp COPYING /usr/share/doc/shunit
	cp README /usr/share/doc/shunit
	cp Makefile /usr/share/doc/shunit
	cp shunit.py /usr/bin/
	ln -s ./shunit.py /usr/bin/shunit

remove:
	-rm -rfv /usr/share/shunit.d
	-rm -rfv /usr/share/doc/shunit
	-rm /usr/bin/shunit
	-rm /usr/bin/shunit.py
