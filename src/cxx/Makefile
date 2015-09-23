
TOPDIR=$(shell cd ../.. && pwd)
include $(TOPDIR)/Makefile.base

#default-make-target: build-lib
default-make-target: build-lib $(OBJDIR)/$(LIBNAME) $(OBJDIR)/$(LIBNAME).$(LIBVER)

HEADERS=            \
  $(NULL)

SOURCES=          \
  $(NULL)

# mdbm_plock.cc
CPP_SOURCES=      \
  mdbm_cxx.cc


#include $(SOURCES:.c=.d)
#include $(CPP_SOURCES:.cc=.d)

LIBNAME=libmdbm_cxx.so
LIBVER=4
ifeq ($(UNAME), Darwin)
SONAME=-Wl,-install_name,$(LIBNAME).$(LIBVER)
else
SONAME=-Wl,-soname,$(LIBNAME).$(LIBVER)
endif
#-Wl,-rpath,$(DEFAULT_LIB_INSTALL_PATH)

LIB_BUILD_FLAGS += $(LIBRT)

LIB_DEST=$(PREFIX)/lib$(ARCH_SUFFIX)
ifeq ($(SET_RPATH),1)
LIB_BUILD_FLAGS += -Wl,-rpath=$(LIB_DEST)
endif

default-make-target: $(OBJDIR)/$(LIBNAME) $(OBJDIR)/$(LIBNAME).$(LIBVER)

$(OBJDIR)/$(LIBNAME) : $(SOURCES:%.c=$(OBJDIR)/%.o) $(CPP_SOURCES:%.cc=$(OBJDIR)/%.o) $(HEADERS)
	mkdir -p $(OBJDIR) && $(CC) $(CFLAGS) $(PEDANTIC) $(filter-out %.h %.hh,$^) $(LDADD) -fPIC -shared -o $@

# versioned library
$(OBJDIR)/$(LIBNAME).$(LIBVER) : $(SOURCES:%.c=$(OBJDIR)/%.o) $(CPP_SOURCES:%.cc=$(OBJDIR)/%.o) $(HEADERS)
	mkdir -p $(OBJDIR) && $(CC) $(CFLAGS) $(PEDANTIC) $(filter-out %.h %.hh,$^) $(LDADD) $(LIB_BUILD_FLAGS) -fPIC -shared $(SONAME) -o $@

install:: default-make-target
	$(INSTALL) -d $(LIB_DEST)
	$(INSTALL) -D $(OBJDIR)/$(LIBNAME).$(LIBVER) $(LIB_DEST)
	#ln -s -f -r $(LIB_DEST)/$(LIBNAME).$(LIBVER) $(LIB_DEST)/$(LIBNAME)
	# some systems don't support "ln -r" (relative links), emulate it...
	cd $(LIB_DEST); ln -s -f $(LIBNAME).$(LIBVER) $(LIBNAME)

build-lib: $(OBJDIR)/libmdbm_cxx.so 

clean :: clean-objs


