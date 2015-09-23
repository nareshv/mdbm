
TOPDIR=$(shell pwd)
include $(TOPDIR)/Makefile.base

SUBDIRS=src include

help:
	@echo "Without any target, the library, tools, and tests will be built."
	@echo "The following additional makefile targets are supported:"
	@echo ""
	@echo "  help      - display this help message"
	@echo "  clean     - cleans up object and intermediate files for library, tools, and tests"
	@echo "  all       - builds library, tools, tests, documentation, and perl wrapper"
	@echo "  doc       - builds doxygen and Restructured Text (via python-Sphinx)"
	@echo "  perl      - builds the perl wrapper"
	@echo "  install   - installs the library and tools"
	@echo "  test      - runs the unit, functional and smoke tests"
	@echo "  test-fast - runs the tests, skipping slow tests"
	@echo "  valg      - runs the tests under valgrind"
	@echo "  profile   - builds profile versions of the library, tools, and tests"
	@echo "  test-prof - runs profile versions of the tests"
	@echo "  echo_<name> - for makefile debugging, prints <name> = <value_of_name>"
	@echo "  value_<name> - for makefile debugging, prints <value_of_name>"


doc:
	$(MAKE) -C gendoc

perl: default
	(cd src/perl; $(PERL) Makefile.PL INSTALL_BASE=$(PERL_PREFIX) && $(MAKE) && $(MAKE) test)

all: default perl doc

install-all: all install
	$(MAKE) -C gendoc install
	$(MAKE) -C src/perl install

clean::
	$(MAKE) -C src/perl clean || $(TRUECMD)
	$(MAKE) -C gendoc clean
	rm -f src/perl/Makefile.old
	rm -rf src/perl/object

