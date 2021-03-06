# This file is part of MXE.
# See index.html for further information.

PKG             := qt3d
$(PKG)_IGNORE   :=
$(PKG)_VERSION   = $(qtbase_VERSION)
$(PKG)_CHECKSUM := a8248a1779b561ea450e92345e8187bacac359df0e92ad61a1ad7652bb233e29
$(PKG)_SUBDIR    = $(subst qtbase,qt3d,$(qtbase_SUBDIR))
$(PKG)_FILE      = $(subst qtbase,qt3d,$(qtbase_FILE))
$(PKG)_URL       = $(subst qtbase,qt3d,$(qtbase_URL))
$(PKG)_DEPS     := gcc qtbase qtdeclarative

define $(PKG)_UPDATE
    echo $(qtbase_VERSION)
endef

define $(PKG)_BUILD
    cd '$(1)' && '$(PREFIX)/$(TARGET)/qt5/bin/qmake'
    $(MAKE) -C '$(1)' -j '$(JOBS)'
    $(MAKE) -C '$(1)' -j 1 install
endef
