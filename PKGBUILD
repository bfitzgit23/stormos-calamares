# Maintainer: StormOS-Dev

pkgname=calamares-app
_pkgname=calamares
pkgver=3.3.15
pkgrel=1
pkgdesc='Distribution-independent installer framework'
arch=('i686' 'x86_64')
license=(GPL)
url="https://github.com/calamares/calamares"
license=('LGPL')
depends=(
  boost-libs
  ckbcomp
  cryptsetup
  dmidecode
  gptfdisk
  hwinfo
  kconfig
  kcoreaddons
  kcrash
  ki18n
  kparts
  kpmcore
  kservice
  kwidgetsaddons
  libpwquality
  mkinitcpio-openswap
  networkmanager
  polkit-qt6
  python
  qt6-declarative
  qt6-svg
  rsync
  solid
  squashfs-tools
  upower
  yaml-cpp
)
makedepends=(
  boost
  cmake
  doxygen
  extra-cmake-modules
  git
  ninja
  python-jsonschema
  python-pyaml
  python-unidecode
  qt6-tools
)

source=($pkgname::git+$url#commit=95aa33f)
sha256sums=('SKIP')

prepare() {
	# modify desktop file
	sed -i -e 's#Exec=sh.*#Exec=sh -c "/etc/calamares/launch.sh"#g' "$srcdir/$pkgname/calamares.desktop"
	sed -i -e 's#Name=.*#Name=Install stormos-calamares#g' "$srcdir/$pkgname/calamares.desktop"
	sed -i -e 's#GenericName=.*#GenericName=stormos-calamaresE#g' "$srcdir/$pkgname/calamares.desktop"
	sed -i -e 's#Icon=.*#Icon=menubutton#g' "$srcdir/$pkgname/calamares.desktop"
	sed -i -e 's#Comment=.*#Comment=stormos-calamares#g' "$srcdir/$pkgname/calamares.desktop"


	# patches here

	# change version
	cd ${srcdir}/$pkgname/src
	_ver="$(cat CMakeLists.txt | grep -m3 -e "  VERSION" | grep -o "[[:digit:]]*" | xargs | sed s'/ /./g')"
	sed -i -e "s|\${CALAMARES_VERSION_MAJOR}.\${CALAMARES_VERSION_MINOR}.\${CALAMARES_VERSION_PATCH}|${_ver}-${pkgrel}|g" CMakeLists.txt
	sed -i -e "s|CALAMARES_VERSION_RC 1|CALAMARES_VERSION_RC 0|g" CMakeLists.txt


 	# change branding
	sed -i -e "s/default/Storm/g" ${srcdir}/$pkgname/src/branding/CMakeLists.txt

}

build() {
    cd ${srcdir}/$pkgname

    _cpuCount=$(grep -c -w ^processor /proc/cpuinfo)

    export CXXFLAGS+=" -fPIC"

    cmake -S . -Bbuild \
        -GNinja \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_INSTALL_PREFIX=/usr \
        -DCMAKE_INSTALL_LIBDIR=lib \
        -DWITH_APPSTREAM=OFF \
        -DWITH_PYBIND11=OFF \
        -DWITH_QT6=ON \
        -DSKIP_MODULES="dracut dracutlukscfg \
        dummycpp dummyprocess dummypython dummypythonqt \
        finishedq keyboardq license localeq notesqml oemid \
        openrcdmcryptcfg packagechooserq fsresizer \
        rawfs mkinitfs contextualprocess interactiveterminal \
        plasmalnf services-openrc \
        summaryq tracking usersq webview welcomeq"

    cmake --build build --parallel $_cpuCount
}

package() {
    cd ${srcdir}/$pkgname/build
    DESTDIR="${pkgdir}" cmake --build . --target install

    # Delete Desktop Entry to avoid confusion for users
    rm -rf "$pkgdir/usr/share/applications"
}
