## Process this file with automake to produce Makefile.in

ACLOCAL_AMFLAGS = -I m4

SOURCES = $(wildcard src/*.lua)
dist_data_DATA = $(SOURCES)
EXTRA_DIST =				\
	src/std.lua.in			\
	src/index.html			\
	src/luadoc.css			\
	$(PACKAGE).rockspec.in		\
	$(wildcard src/files/*.html)	\
	$(wildcard src/modules/*.html)

DISTCLEANFILES = $(PACKAGE).rockspec

ROCKSPEC = $(PACKAGE)-$(VERSION)-1.rockspec

$(ROCKSPEC): $(PACKAGE).rockspec dist
	sed -e 's/@MD5@/'`$(MD5SUM) $(distdir).zip | cut -d " " -f 1`'/g' < $(PACKAGE).rockspec > $@

html: $(SOURCES)
	cd src && luadoc *.lua

ChangeLog:
	git2cl > ChangeLog

release: distcheck $(ROCKSPEC)
	git diff --exit-code && \
	git push && \
	woger lua,github package=$(PACKAGE) package_name=$(PACKAGE_NAME) version=$(VERSION) description="`LUA_INIT= LUA_PATH='$(abs_srcdir)/?.rockspec.in' $(LUA) -l$(PACKAGE) -e 'print (description.summary)'`" notes=release-notes-$(VERSION) dist_type=zip github_user=rrthomas
	git tag -a -m "Release tag" rel-`echo $(VERSION) | sed -e 's/\./-/g'` && \
	git push --tags
