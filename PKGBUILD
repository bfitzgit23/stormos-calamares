#https://github.com/calamares/calamares/releases
#change prepare number too

pkgname=calamares-app
_pkgname=calamares
pkgver=3.4.0
pkgrel=2
pkgdesc='Distribution-independent installer framework'
arch=('x86_64')
license=(GPL)
url="https://codeberg.org/Calamares/calamares.git"
license=('LGPL')
provides=('calamares')
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
backup=('usr/share/calamares/modules/bootloader.conf'
        'usr/share/calamares/modules/displaymanager.conf'
        'usr/share/calamares/modules/initcpio.conf'
        'usr/share/calamares/modules/unpackfs.conf')

source=($pkgname::git+$url#commit=0949c7eb32
	"calamares.desktop"
	"calamares_polkit")

sha256sums=('SKIP'
            'SKIP'
            'SKIP')

prepare() {

	# modify desktop file
	sed -i -e 's#Exec=sh.*#Exec=sh -c "/etc/calamares/launch.sh"#g' "$srcdir/$pkgname/calamares.desktop"
	sed -i -e 's#Name=.*#Name=Install StormOS#g' "$srcdir/$pkgname/calamares.desktop"
	sed -i -e 's#GenericName=.*#GenericName=StormOS Installer#g' "$srcdir/$pkgname/calamares.desktop"
	sed -i -e 's#Icon=.*#Icon=menubutton#g' "$srcdir/$pkgname/calamares.desktop"
	sed -i -e 's#Comment=.*#Comment=StormOS Installer#g' "$srcdir/$pkgname/calamares.desktop"

 
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
        -DSKIP_MODULES="dracut \
            dracutlukscfg \
            dummycpp \
            dummyprocess \
            dummypython \
            dummypythonqt \
            initramfs \
            initramfscfg \
            interactiveterminal \
            keyboardq \
            license \
            localeq \
            oemid \
            packagechooserq \
            partitionq \
            services-openrc \
            summaryq \
            tracking \
            welcomeq \
            zfs \
            zfshostid"

    cmake --build build --parallel $_cpuCount
}

package() {
	cd ${srcdir}/$pkgname/build
	DESTDIR="${pkgdir}" cmake --build . --target install
	install -Dm644 "$srcdir/calamares.desktop" "$pkgdir/etc/xdg/autostart/calamares.desktop"
	install -Dm644 "$srcdir/calamares.desktop" "$pkgdir/home/liveuser/Desktop/cala-launch.desktop"
	install -Dm755 "$srcdir/calamares_polkit" "$pkgdir/usr/bin/calamares_polkit"
	rm "$pkgdir/usr/share/applications/calamares.desktop"
}
