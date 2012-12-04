# Makefile for the doclifter project
VERS=2.8

MANDIR=/usr/share/man/man1
BINDIR=/usr/bin

DOCS    = README COPYING TODO BUGS \
		doclifter.xml doclifter.1 manlifter.xml manlifter.1
TEST    = docliftertest1.man test.troff
SOURCES = doclifter manlifter Makefile $(DOCS) $(TEST) doclifter-logo.png

all: doclifter-$(VERS).tar.gz

install: doclifter.1
	cp doclifter $(BINDIR)
	gzip <doclifter.1 >$(MANDIR)/doclifter.1.gz
	rm doclifter.1

doclifter.1: doclifter.xml
	xmlto man doclifter.xml

manlifter.1: manlifter.xml
	xmlto man manlifter.xml

doclifter.html: doclifter.xml
	xmlto xhtml-nochunks doclifter.xml

manlifter.html: manlifter.xml
	xmlto xhtml-nochunks manlifter.xml

doclifter-$(VERS).tar.gz: $(SOURCES)
	mkdir doclifter-$(VERS)
	cp $(SOURCES) doclifter-$(VERS)
	tar -czf doclifter-$(VERS).tar.gz doclifter-$(VERS)
	rm -fr doclifter-$(VERS)
	ls -l doclifter-$(VERS).tar.gz

test:
	doclifter -v docliftertest1.man

pychecker:
	@echo "Expect: Local variable (lst) not used"
	@ln -f doclifter doclifter.py
	@-pychecker --only --quiet --limit 50 doclifter.py
	@rm -f doclifter.py doclifter.pyc

dist: doclifter-$(VERS).tar.gz

clean:
	rm -f doclifter.html manlifter.html doclifter.1 manlifter.1 *.tar.gz 
	rm -f *.pyc docliftertest.xml
	rm -f SHIPPER.* index.html

release: doclifter-$(VERS).tar.gz doclifter.html manlifter.html
	shipper -u -m -t; make clean
