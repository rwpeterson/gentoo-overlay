# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

#GIT_COMMIT=0ec00d892a91cc68e45479b46161f649caea2933
#S=$WORKDIR/$PN-$GIT_COMMIT

DESCRIPTION="reverse-engineered tools for Lattice iCE40 FPGAs"
HOMEPAGE="http://www.clifford.at/icestorm/"
#SRC_URI="https://github.com/cliffordwolf/$PN/archive/$GIT_COMMIT.tar.gz -> $P.tar.gz"
SRC_URI="https://github.com/cliffordwolf/$PN/archive/master.tar.gz -> $P.tar.gz"
LICENSE="ISC"
SLOT=0
KEYWORDS="~amd64"

DEPEND="dev-embedded/libftdi
	dev-vcs/git
	dev-vcs/mercurial
	media-gfx/graphviz
	media-gfx/xdot
	dev-qt/qtcore:5
	dev-libs/boost"

src_install() {
		emake DESTDIR="$D" PREFIX=usr install
}
