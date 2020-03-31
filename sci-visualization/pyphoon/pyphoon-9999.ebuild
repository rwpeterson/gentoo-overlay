# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )
inherit python-single-r1

DESCRIPTION="ASCII art phase of the moon"
HOMEPAGE="https://github.com/chubin/pyphoon"

if [[ ${PV} == 9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/chubin/pyphoon.git"
else
	die
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
	SRC_URI="" # no releases yet...
fi

LICENSE="MIT"
SLOT="0"
IUSE="lolcat"
REQUIRED_USE=${PYTHON_REQUIRED_USE}

DEPEND="
	$(python_gen_cond_dep '
		dev-python/python-dateutil[${PYTHON_MULTI_USEDEP}]
	')
	lolcat? (
		|| (
			games-misc/lolcat
			games-misc/lolcat-jaseg
		)
	)
"
RDEPEND="${DEPEND} ${PYTHON_DEPS}"
BDEPEND="${RDEPEND}"

src_install() {
	python_doscript bin/pyphoon
	if use lolcat ; then
		dobin bin/pyphoon-lolcat
	fi
	python_domodule lib/*
}
