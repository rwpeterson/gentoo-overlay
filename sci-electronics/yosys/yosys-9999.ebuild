# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{5,6,7} )

# Here select the commit of abc used by the unpatched yosys makefile
# Instead of having make internally `git clone` this repo, we do it here 

if [[ ${PV} == "9999" ]]; then
	ABC_GIT_COMMIT=71f2b40320127561175ad60f6f2428f3438e5243
else
	# Yosys 0.9
	ABC_GIT_COMMIT=3709744c60696c5e3f4cc123939921ce8107fe04
fi

DESCRIPTION="yosys - Yosys Open SYnthesis Suite"
HOMEPAGE="https://github.com/YosysHQ/yosys"

inherit git-r3 python-any-r1

if [[ ${PV} == "9999" ]]; then
	#EGIT_REPO_URI="https://github.com/YosysHQ/yosys.git"
	SRC_URI="https://github.com/YosysHQ/yosys/archive/master.tar.gz -> yosys-master.tar.gz
			https://github.com/berkeley-abc/abc/archive/${ABC_GIT_COMMIT}.tar.gz -> abc-${ABC_GIT_COMMIT}.tar.gz"
else
	SRC_URI="https://github.com/YosysHQ/yosys/archive/${PN}${P}.tar.gz -> ${P}.tar.gz
			https://github.com/berkeley-abc/abc/archive/${ABC_GIT_COMMIT}.tar.gz -> abc-${ABC_GIT_COMMIT}.tar.gz"
fi

PATCHES="${FILESDIR}/${PN}-makefile-fix.patch"

LICENSE="ISC"
SLOT="0"
IUSE=""
KEYWORDS="~amd64"
DEPEND="
	${PYTHON_DEPS}
	dev-libs/libffi
	dev-lang/tcl
	dev-libs/boost
	dev-vcs/git
	media-gfx/graphviz
	media-gfx/xdot
	sys-devel/clang:*
	sys-devel/make
	sys-libs/readline
	sys-libs/zlib
"
RDEPEND="${DEPEND}"
BDEPEND="
	sys-devel/bison
	sys-devel/flex
"

src_unpack() {
	mkdir ${S}
	if [[ ${PV} == "9999" ]]; then
		unpack ${PN}-master.tar.gz
		cp -a ${PN}-master/. ${S}
	else
		unpack ${P}.tar.gz
		cp -a ${P}/. ${S}
	fi
	unpack abc-${ABC_GIT_COMMIT}.tar.gz
	mv abc-${ABC_GIT_COMMIT} ${S}/abc
}
