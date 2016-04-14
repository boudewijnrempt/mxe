# This file is part of MXE.
# See index.html for further information.

PKG             := krita
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.99.89
$(PKG)_CHECKSUM := 
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := http://download.kde.org/unstable/krita/2.99.89//$($(PKG)_FILE)
$(PKG)_DEPS     := gcc boost curl eigen exiv2 expat fftw fontconfig freetype gettext gsl ilmbase openexr jpeg lcms linpng libraw opencolorio openjpeg poppler-qt5 qt5 qtscript tiff vc zlib

define $(PKG)_UPDATE
    echo 'TODO: write update script for $(PKG).' >&2;
    echo $($(PKG)_VERSION)
endef

define $(PKG)_BUILD
    
    mkdir '$(1)/d'

    cd '$(1)/3rdparty' && mkdir build && cd build && cmake .. \
        -DCMAKE_TOOLCHAIN_FILE='$(CMAKE_TOOLCHAIN_FILE)' \
        -DCMAKE_BUILD_TYPE=Release \
        -DEXTERNALS_DOWNLOAD_DIR='$(1)/d' \
        -DINSTALL_ROOT=${PREFIX} 

    $(MAKE) -C '$(1)'/build -j '$(JOBS)' install VERBOSE=1

    cd '$(1)' && mkdir build && cd build && cmake .. \
        -DCMAKE_TOOLCHAIN_FILE='$(CMAKE_TOOLCHAIN_FILE)' \
        -DPACKAGERS_BUILD=ON \
        -DBUILD_TESTING=OFF \
        -DKDE4_BUILD_TESTS=OFF \
        -DCMAKE_BUILD_TYPE=Release

    $(MAKE) -C '$(1)'/build -j '$(JOBS)' install VERBOSE=1

endef

$(PKG)_BUILD_SHARED =
