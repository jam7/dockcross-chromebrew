
SCRIPTS = chromeos-armv7 chromeos-x86 chromeos-x64

gcc: gcc-armv7 gcc-x64 gcc-x86

gcc-armv7:
	./chromeos-armv7 crew install buildessential

gcc-x64:
	./chromeos-x64 crew install buildessential

gcc-x86:
	./chromeos-x86 crew install buildessential

install: install-armv7 install-x64 install-x86

install-armv7:
	./chromeos-armv7 bash -c 'wget -q -O - https://raw.github.com/skycocker/chromebrew/master/install.sh | bash'

install-x64:
	./chromeos-x64 bash -c 'wget -q -O - https://raw.github.com/skycocker/chromebrew/master/install.sh | bash'

install-x86:
	./chromeos-x86 bash -c 'wget -q -O - https://raw.github.com/skycocker/chromebrew/master/install.sh | bash'

install-jam: install-jam-armv7 install-jam-x64 install-jam-x86

install-jam-armv7:
	./chromeos-armv7 bash -c 'wget -q -O - https://raw.github.com/jam7/chromebrew/master/install.sh | bash'

install-jam-x64:
	./chromeos-x64 bash -c 'wget -q -O - https://raw.github.com/jam7/chromebrew/master/install.sh | bash'

install-jam-x86:
	./chromeos-x86 bash -c 'wget -q -O - https://raw.github.com/jam7/chromebrew/master/install.sh | bash'

scripts: ${SCRIPTS}

chromeos-armv7:
	docker run --rm jam7/chromeos-armv7 | sed -e '/^HOST_VOLUMES=/s;$$;"-v ${PWD}/armv7:/usr/local --cpuset-cpus=0 ";' > $@
	chmod a+x $@

chromeos-x64:
	docker run --rm jam7/chromeos-x64 | sed -e '/^HOST_VOLUMES=/s;$$;"-v ${PWD}/x64:/usr/local --cpuset-cpus=0 ";' > $@
	chmod a+x $@

chromeos-x86:
	docker run --rm jam7/chromeos-x86 | sed -e '/^HOST_VOLUMES=/s;$$;"-v ${PWD}/x86:/usr/local --cpuset-cpus=0 ";' > $@
	chmod a+x $@

clean: FORCE
	rm -f ${SCRIPTS}

FORCE:
