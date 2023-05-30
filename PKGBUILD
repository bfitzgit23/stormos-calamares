
# Maintainer: Philip Müller <philm[at]manjaro[dot]org>

pkgname=calamares
pkgver=3.3.0.230305
pkgrel=1
pkgdesc='Distribution-independent installer framework'
arch=('i686' 'x86_64')
license=(GPL)
url="https://github.com/calamares/calamares/"
license=('LGPL')
depends=('kconfig' 'kcoreaddons' 'kiconthemes' 'ki18n' 'kio' 'solid' 'yaml-cpp' 'kpmcore>=4.2.0' 'mkinitcpio-openswap'
         'boost-libs' 'ckbcomp' 'hwinfo' 'qt5-svg' 'polkit-qt5' 'gtk-update-icon-cache' 'plasma-framework'
         'qt5-xmlpatterns' 'squashfs-tools' 'libpwquality' 'efibootmgr' 'icu')
conflicts=()
makedepends=('extra-cmake-modules' 'qt5-tools' 'qt5-translations' 'git' 'boost')
backup=('usr/share/calamares/modules/bootloader.conf'
        'usr/share/calamares/modules/displaymanager.conf'
        'usr/share/calamares/modules/initcpio.conf'
        'usr/share/calamares/modules/unpackfs.conf')

source=("$pkgname::git+https://github.com/calamares/calamares")

sha256sums=('SKIP')

prepare() {
	cd ${srcdir}/calamares
	sed -i -e 's/"Install configuration files" OFF/"Install configuration files" ON/' CMakeLists.txt

	# change version
	sed -i -e "s|$pkgver|$_pkgver|g" CMakeLists.txt
#	printf 'Version: %s-%s' "${_ver}" "${pkgrel}"
	sed -i -e "s|\${CALAMARES_VERSION_MAJOR}.\${CALAMARES_VERSION_MINOR}.\${CALAMARES_VERSION_PATCH}|${_ver}-${pkgrel}|g" CMakeLists.txt
	sed -i -e "s|CALAMARES_VERSION_RC 1|CALAMARES_VERSION_RC 0|g" CMakeLists.txt

	# change branding
	sed -i -e "s/default/Storm/g" src/branding/CMakeLists.txt
}

build() {
	cd ${srcdir}/calamares

	mkdir -p build
	cd build
	cmake .. \
	-DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_INSTALL_PREFIX=/usr \
	-DCMAKE_INSTALL_LIBDIR=lib \
	-DWITH_PYTHONQT=OFF \
	-DWITH_KF5DBus=OFF \
	-DBoost_NO_BOOST_CMAKE=ON \
	-DWEBVIEW_FORCE_WEBKIT=OFF \
	-DSKIP_MODULES="webview tracking interactiveterminal initramfs \
	initramfscfg dracut dracutlukscfg \
	dummyprocess dummypython dummycpp \
	dummypythonqt services-openrc \
	keyboardq localeq welcomeq"
	make
}

package() {
	cd ${srcdir}/calamares/build
	make DESTDIR="$pkgdir" install
#	install -Dm644 "${srcdir}/calamares.desktop" #"$pkgdir/etc/xdg/autostart/calamares.desktop"
#	install -Dm755 "${srcdir}/calamares_polkit" "$pkgdir/usr/bin/calamares_polkit"
#	install -Dm644 "${srcdir}/49-nopasswd-calamares.rules" #"$pkgdir/etc/polkit-1/rules.d/49-nopasswd-calamares.rules"
#	chmod 750 "$pkgdir"/etc/polkit-1/rules.d
}
