all: doc test

doc: doc/manual.six

doc/manual.six: makedoc.g \
		PackageInfo.g \
		doc/Sheaves.bib doc/*.xml \
		gap/*.gd gap/*.gi examples/*.g
	        gap makedoc.g

clean:
	(cd doc ; ./clean)

test:	doc
	gap tst/testall.g

test-with-coverage: doc
	/usr/bin/time --quiet --format="%U %S\n%e" --output=performance.out gap --quitonbreak --cover stats tst/testall.g
	gap --quitonbreak --norepl -c 'LoadPackage("profiling"); OutputJsonCoverage("stats", "coverage.json");'

ci-test: test-with-coverage

archive: test
	(mkdir -p ../tar; cd ..; tar czvf tar/Sheaves.tar.gz --exclude ".DS_Store" --exclude "*~" Sheaves/doc/*.* Sheaves/doc/clean Sheaves/gap/*.{gi,gd} Sheaves/{CHANGES,PackageInfo.g,README,VERSION,init.g,read.g,makedoc.g,makefile,maketest.g,ListOfDocFiles.g} Sheaves/examples/*.g)

WEBPOS=public_html
WEBPOS_FINAL=~/Sites/homalg-project/Sheaves

towww: archive
	echo '<?xml version="1.0" encoding="UTF-8"?>' >${WEBPOS}.version
	echo '<mixer>' >>${WEBPOS}.version
	cat VERSION >>${WEBPOS}.version
	echo '</mixer>' >>${WEBPOS}.version
	cp PackageInfo.g ${WEBPOS}
	cp README ${WEBPOS}/README.Sheaves
	cp doc/manual.pdf ${WEBPOS}/Sheaves.pdf
	cp doc/*.{css,html} ${WEBPOS}
	rm -f ${WEBPOS}/*.tar.gz
	mv ../tar/Sheaves.tar.gz ${WEBPOS}/Sheaves-`cat VERSION`.tar.gz
	rm -f ${WEBPOS_FINAL}/*.tar.gz
	cp ${WEBPOS}/* ${WEBPOS_FINAL}
	ln -s Sheaves-`cat VERSION`.tar.gz ${WEBPOS_FINAL}/Sheaves.tar.gz
