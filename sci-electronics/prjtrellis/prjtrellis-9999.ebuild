# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

#GIT_COMMIT=eff025986ebef1ea938ade7e405a6c6866d14541
#GIT_COMMIT=dc10b8a9e8d0a9a1add35f0e88a1556566a609d6 #old
#DB_GIT_COMMIT=717478b757a702bbc7e3e11a5fbecee2a64f7922
#DB_GIT_COMMIT=48f79ebb3d7684c20d2ae7f42a389032f8c8469b #old

PYTHON_COMPAT=( python3_{5,6,7} )
inherit git-r3 cmake-utils

S=$WORKDIR/$P/libtrellis

DESCRIPTION="Documenting the Lattice ECP5 bit-stream format"
HOMEPAGE="https://prjtrellis.readthedocs.io/en/latest/"
#SRC_URI="https://github.com/SymbiFlow/$PN/archive/$GIT_COMMIT.tar.gz -> $P.tar.gz
#		https://github.com/SymbiFlow/$PN-db/archive/$DB_GIT_COMMIT.tar.gz -> $PN-db-$PV.tar.gz"
SRC_URI="https://github.com/SymbiFlow/$PN/archive/master.tar.gz -> $P.tar.gz
		https://github.com/SymbiFlow/$PN-db/archive/master.tar.gz -> $PN-db-$PV.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	dev-libs/boost
	dev-vcs/git
	dev-embedded/openocd
"
RDEPEND="${DEPEND}"
BDEPEND="dev-perl/rename" #for perl-rename in src_unpack

src_unpack() {
	unpack $P.tar.gz
	unpack $PN-db-$PV.tar.gz
	perl-rename 's/[0-9a-f]{7,40}/9999/' $PN*
	rmdir $P/database
	mv $PN-db-$PV $P/database
}

# see https://github.com/SymbiFlow/prjtrellis/pull/95
src_configure() {
	local mycmakeargs=(
		-DCURRENT_GIT_VERSION=$GIT_COMMIT
	)
	cmake-utils_src_configure
}
