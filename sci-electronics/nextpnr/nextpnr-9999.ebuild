# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{5,6,7} )

inherit python-any-r1 git-r3 cmake-utils check-reqs

DESCRIPTION="nextpnr -- a portable FPGA place and route tool"
HOMEPAGE="https://github.com/YosysHQ/nextpnr"
# SRC_URI="https://github.com/YosysHQ/$PN/archive/master.tar.gz -> $P.tar.gz"
EGIT_REPO_URI="https://github.com/YosysHQ/nextpnr.git"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE="ice40 ecp5"

DEPEND="
	ice40? ( sci-electronics/icestorm
			>=sci-electronics/yosys-0.8 )
	ecp5? ( sci-electronics/prjtrellis
			>=sci-electronics/yosys-0.8 )
	dev-cpp/eigen
	dev-libs/boost
	dev-qt/qtcore:5
	sci-electronics/yosys
"
RDEPEND="${DEPEND}"
BDEPEND=""

CHECKREQS_DISK_BUILD="4G"

src_configure() {
	local mycmakeargs=(
		$(usex ice40 $(usex ecp5 "-DARCH=all" "-DARCH=ice40") $(usex ecp5 "-DARCH=ecp5" "-DARCH=generic"))
		$(usex ice40 -DICEBOX_ROOT=/usr/share/icebox "")
		$(usex ecp5 -DTRELLIS_ROOT=/usr/share/trellis "")
	)
	cmake-utils_src_configure
}
