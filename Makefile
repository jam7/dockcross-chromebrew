
SCRIPTS = chromeos-armv7 chromeos-x86 chromeos-x64

install-armv7:
	./chromeos-armv7 bash -c 'wget -q -O - https://raw.github.com/jam7/chromebrew/master/install.sh | bash'

install-x64:
	./chromeos-x64 bash -c 'wget -q -O - https://raw.github.com/jam7/chromebrew/master/install.sh | bash'

install-x86:
	./chromeos-x86 bash -c 'wget -q -O - https://raw.github.com/jam7/chromebrew/master/install.sh | bash'

scripts: ${SCRIPTS}

chromeos-armv7:
	docker run --rm jam7/chromeos-armv7 | sed -e '/^HOST_VOLUMES=/s;$$;"-v ${PWD}/armv7:/usr/local ";' > $@
	chmod a+x $@

chromeos-x64:
	docker run --rm jam7/chromeos-x64 | sed -e '/^HOST_VOLUMES=/s;$$;"-v ${PWD}/x64:/usr/local ";' > $@
	chmod a+x $@

chromeos-x86:
	docker run --rm jam7/chromeos-x86 | sed -e '/^HOST_VOLUMES=/s;$$;"-v ${PWD}/x86:/usr/local ";' > $@
	chmod a+x $@

clean: FORCE
	rm -f ${SCRIPTS}

FORCE:
