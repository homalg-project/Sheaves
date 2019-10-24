all: doc test

doc: doc/manual.six

doc/manual.six: makedoc.g maketest.g ListOfDocFiles.g \
		PackageInfo.g \
		doc/Sheaves.bib doc/*.xml doc/*.css \
		gap/*.gd gap/*.gi examples/*.g
	        gap makedoc.g

clean:
	(cd doc ; ./clean)

test:	doc
	gap maketest.g

test-with-coverage: doc
	OUTPUT=$$(/usr/bin/time --quiet --format="%U %S" --output=performance.out gap --banner --quitonbreak --cover stats maketest.g 2>&1); \
	echo "$$OUTPUT"; \
	! echo "$$OUTPUT" | sed "s/\r//" | grep -v "Running list" | grep -v "^#I  " | grep "" > /dev/null
	echo 'LoadPackage("profiling"); OutputJsonCoverage("stats", "coverage.json");' | gap

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
