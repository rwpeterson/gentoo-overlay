# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit autotools

DESCRIPTION="LifeLines is a genealogy program to help with your family history research."
HOMEPAGE="https://lifelines.github.io/lifelines/"

LICENSE="MIT"
SLOT="0"
IUSE="doc"

if [[ ${PV} == 9999* ]] ; then
		inherit git-r3
		EGIT_REPO_URI="https://github.com/lifelines/lifelines.git"
else
		SRC_URI="https://github.com/lifelines/lifelines/releases/download/${PV}/${P}.tar.gz"
		KEYWORDS="amd64"
fi

DEPEND="sys-libs/ncurses"
RDEPEND="${DEPEND}"
BDEPEND="
	sys-devel/bison
	doc? (
		app-text/dblatex
		app-text/xmlto
		dev-texlive/texlive-latexrecommended
	)"

#src_unpack() {
#	unpack master.zip
#	mv $PN-master $P
#}

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf \
		$(use_with doc docs)\
		LDFLAGS="-ltinfow"
}

src_install() {
	rm -rf ${D}/*
	default
}
