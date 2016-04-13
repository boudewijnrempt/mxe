# This file is part of MXE.
# See index.html for further information.

PKG             := poppler-qt5
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 0.42.0
$(PKG)_CHECKSUM := 9fef076ffe2a4f18a4e0da547d814ef5c5e6f8a283afe3387504a0bb1a418010
$(PKG)_SUBDIR   := poppler-$($(PKG)_VERSION)
$(PKG)_FILE     := poppler-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := http://poppler.freedesktop.org/$($(PKG)_FILE)
$(PKG)_DEPS     := gcc cairo curl freetype glib jpeg lcms libpng qt5 tiff zlib

define $(PKG)_UPDATE
    $(WGET) -q -O- 'http://poppler.freedesktop.org/' | \
    $(SED) -n 's,.*"poppler-\([0-9.]\+\)\.tar\.xz".*,\1,p' | \
    head -1
endef

define $(PKG)_BUILD

    cd '$(1)' && mkdir build && cd build && cmake .. \
        -DCMAKE_TOOLCHAIN_FILE='$(CMAKE_TOOLCHAIN_FILE)' \
        -DCMAKE_BUILD_TYPE=Release 
    $(MAKE) -C '$(1)'/build -j '$(JOBS)' install VERBOSE=1

endef

$(PKG)_BUILD_SHARED =

