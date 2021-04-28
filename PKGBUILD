pkgname=stormos-calamares
_pkgname=calamares
pkgver=3.2.39.2
pkgrel=1
pkgdesc='Distribution-independent installer framework'
arch=('i686' 'x86_64')
license=(GPL)
url="https://github.com/calamares/calamares/releases/download"
license=('LGPL')
depends=('kconfig' 'kcoreaddons' 'kiconthemes' 'ki18n' 'kio' 'solid' 'yaml-cpp' 'kpmcore' 'mkinitcpio-openswap'
         'boost-libs' 'ckbcomp' 'hwinfo' 'qt5-svg' 'polkit-qt5' 'gtk-update-icon-cache' 'plasma-framework'
         'qt5-xmlpatterns' 'squashfs-tools') # 'pythonqt>=3.2')
makedepends=('extra-cmake-modules' 'qt5-tools' 'qt5-translations' 'git' 'boost')
backup=('usr/share/calamares/modules/bootloader.conf'
        'usr/share/calamares/modules/displaymanager.conf'
        'usr/share/calamares/modules/initcpio.conf'
        'usr/share/calamares/modules/unpackfs.conf')


source+=("$_pkgname-$pkgver-$pkgrel.tar.gz::$url/v$pkgver/$_pkgname-$pkgver.tar.gz")

#sha256sums=('b36c27c1c76b7092c6e4d86e812927b410987cfbafdd3ffdf8f7256e62b4049e')

prepare() {
    cp -r /home/ben/stormos-calamares/Storm-Calamares ${srcdir}
    cp -a ${srcdir}/Storm-Calamares/* ${srcdir}/calamares-${pkgver}
    rm -rf ${srcdir}/Storm-Calamares
    cd ${srcdir}/calamares-${pkgver}
    sed -i -e 's/"Install configuration files" OFF/"Install configuration files" ON/' CMakeLists.txt
    sed -i 's/\"mkinitcpio\", \"-p\", m_kernel/\"mkinitcpio\", \"-P\"/' ${srcdir}/calamares-${pkgver}/src/modules/initcpio/InitcpioJob.cpp
}


build() {
    cd ${srcdir}/calamares-${pkgver}

    mkdir -p build
    cd build
        cmake .. \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_INSTALL_PREFIX=/usr \
        -DCMAKE_INSTALL_LIBDIR=lib \
        -DWITH_PYTHONQT:BOOL=OFF \
	-DBoost_NO_BOOST_CMAKE=ON \
        -DSKIP_MODULES="webview interactiveterminal initramfs \
                        initramfscfg dracut dracutlukscfg \
                        dummyprocess dummypython dummycpp \
                        dummypythonqt plasmalnf services-openrc"
        make
}


package() {
    cd ${srcdir}/calamares-${pkgver}/build
    make DESTDIR="$pkgdir" install
    install -Dm644 "../calamares.desktop" "$pkgdir/usr/share/applications/calamares.desktop"
	install -Dm755 "../data/calamares_polkit" "$pkgdir/usr/bin/calamares_polkit"
    install -Dm644 "../data/49-nopasswd-calamares.rules" "$pkgdir/etc/polkit-1/rules.d/49-nopasswd-calamares.rules"
    chmod 750 "$pkgdir"/etc/polkit-1/rules.d

   	# rename services-systemd back to services
	mv "$pkgdir/usr/lib/calamares/modules/services-systemd" "$pkgdir/usr/lib/calamares/modules/services"
	mv "$pkgdir/usr/share/calamares/modules/services-systemd.conf" "$pkgdir/usr/share/calamares/modules/services.conf"
	sed -i -e 's/-systemd//' "$pkgdir/usr/lib/calamares/modules/services/module.desc"
	sed -i -e 's/-systemd//' "$pkgdir/usr/share/calamares/settings.conf"
}

