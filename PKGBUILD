# Maintainer: StormOS-Dev

pkgname=calamares-app
_pkgname=calamares
pkgver=3.3.6
pkgrel=1
pkgdesc='Distribution-independent installer framework'
arch=('i686' 'x86_64')
license=(GPL)
url="https://github.com/calamares/calamares"
license=('LGPL')
depends=('ckbcomp'
	'efibootmgr'
	'gtk-update-icon-cache'
	'hwinfo'
	'icu'
	'kpmcore>=24.01.75'
	'libpwquality'
	'mkinitcpio-openswap'
	'squashfs-tools'
	'yaml-cpp'
	'kconfig>=5.246'
	'kcoreaddons>=5.246'
	'ki18n>=5.246'
	'kiconthemes>=5.246'
	'kio>=5.246'
	'polkit-qt6>=0.175.0'
	'qt6-base>=6.6.0'
	'qt6-svg>=6.6.0'
	'solid>=5.246')

makedepends=('extra-cmake-modules' 'qt6-tools' 'qt6-translations' 'git')

source=($pkgname::git+$url#commit=2e96184)
sha256sums=('SKIP')

prepare() {
	# modify desktop file
	sed -i -e 's#Exec=sh.*#Exec=sh -c "/etc/calamares/launch.sh"#g' "$srcdir/$pkgname/calamares.desktop"
	sed -i -e 's#Name=.*#Name=Install StormOS#g' "$srcdir/$pkgname/calamares.desktop"
	sed -i -e 's#GenericName=.*#GenericName=StormOS Installer#g' "$srcdir/$pkgname/calamares.desktop"
	sed -i -e 's#Icon=.*#Icon=menubutton#g' "$srcdir/$pkgname/calamares.desktop"
	sed -i -e 's#Comment=.*#Comment=StormOS Installer#g' "$srcdir/$pkgname/calamares.desktop"


	# patches here

	# change version
	cd ${srcdir}/$pkgname/src/
	_ver="$(cat CMakeLists.txt | grep -m3 -e "  VERSION" | grep -o "[[:digit:]]*" | xargs | sed s'/ /./g')"
	sed -i -e "s|\${CALAMARES_VERSION_MAJOR}.\${CALAMARES_VERSION_MINOR}.\${CALAMARES_VERSION_PATCH}|${_ver}-${pkgrel}|g" CMakeLists.txt
	sed -i -e "s|CALAMARES_VERSION_RC 1|CALAMARES_VERSION_RC 0|g" CMakeLists.txt


 	# change branding
	sed -i -e "s/default/Storm/g" ${srcdir}/$pkgname/src/branding/CMakeLists.txt

}

build() {
	cd ${srcdir}/$pkgname
	
	mkdir -p build
	cd build
        cmake .. \
              -DCMAKE_BUILD_TYPE=Release \
              -DCMAKE_INSTALL_PREFIX=/usr \
              -DCMAKE_INSTALL_LIBDIR=lib \
              -DWITH_PYTHONQT:BOOL=ON \
              -DBoost_NO_BOOST_CMAKE=ON \
              -DWITH_QT6=ON \
              -DWITH_PYBIND11=ON \
              -DWITH_APPSTREAM=OFF \
              -DBUILD_TESTING=OFF \
              -DSKIP_MODULES="tracking webview interactiveterminal initramfs \
                              initramfscfg dracut dracutlukscfg \
                              dummyprocess dummypython dummycpp \
                              dummypythonqt services-openrc"

        make
}

package() {
    install -Dm755 "../calamares_polkit" "$pkgdir/usr/bin/calamares_polkit"
	cd ${srcdir}/$pkgname/build
	make DESTDIR="$pkgdir" install
	rm "${srcdir}/$pkgname/calamares.desktop"
	rm "$pkgdir/usr/share/applications/calamares.desktop"

}
