#https://github.com/calamares/calamares/releases
#change prepare number too

pkgname=calamares-app
_pkgname=calamares
pkgver=3.4.0
pkgrel=5
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

#backup=('usr/share/calamares/modules/bootloader.conf'
#        'usr/share/calamares/modules/displaymanager.conf'
#        'usr/share/calamares/modules/initcpio.conf'
#        'usr/share/calamares/modules/unpackfs.conf')

source=($pkgname::git+$url#commit=0cd2e52bea
	"calamares.desktop"
	"calamares_polkit")

sha256sums=('781462670ee2c37b5ef025784c86fa69349f13a3f6ca5a8a3d4782d45f82968f'
            'a9d6f76862ecb1d3079797b86053a3ee9eb051a436bf26783018e4395137bd64'
            '4c8b48518b0047672e835e0a6c8a66342b316ab8835cf4c331030de4830dcea2')

prepare() {

	cp -rv ../modules/* ${srcdir}/$pkgname/src/modules/

	sed -i 's/command\.append("-S")/command.append("-Syy")/' "$srcdir/$pkgname/src/modules/packages/main.py"
	sed -i -e 's/"Install configuration files" OFF/"Install configuration files" ON/' "$srcdir/$pkgname/CMakeLists.txt"
# 	sed -i '/case FileSystem::Xfs:/ a case FileSystem::Bcachefs:' "$srcdir/$pkgname/src/libcalamares/partition/FileSystem.cpp"
#   sed -i '/case FileSystem::Fat16:/ i case FileSystem::Bcachefs:' "$srcdir/$pkgname/src/modules/partition/core/PartitionLayout.cpp"
	sed -i -e "s/desired_size = 512 \* 1024 \* 1024  \# 512MiB/desired_size = 512 \* 1024 \* 1024 \* 4  \# 2048MiB/" "$srcdir/$pkgname/src/modules/fstab/main.py"

	cd $pkgname
	sed -i -e "s|CALAMARES_VERSION 3.3.6|CALAMARES_VERSION $pkgver-$pkgrel|g" CMakeLists.txt
}

build() {
	cd $pkgname

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

    cmake --build build
}

package() {
	cd $pkgname/build
	DESTDIR="${pkgdir}" cmake --build . --target install
	install -Dm644 "$srcdir/calamares.desktop" "$pkgdir/etc/xdg/autostart/calamares.desktop"
	install -Dm644 "$srcdir/calamares.desktop" "$pkgdir/home/liveuser/Desktop/calamares.desktop"
	install -Dm755 "$srcdir/calamares_polkit" "$pkgdir/usr/bin/calamares_polkit"
	rm "$pkgdir/usr/share/applications/calamares.desktop"
}
