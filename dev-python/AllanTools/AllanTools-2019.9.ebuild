# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_6 )
inherit distutils-r1

DESCRIPTION="Allan deviation and related time/frequency statistics"
HOMEPAGE="https://pypi.org/project/AllanTools/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE=""

DEPEND="
dev-python/pytest[${PYTHON_USEDEP}]
dev-python/pytest-runner[${PYTHON_USEDEP}]
dev-python/numpy[${PYTHON_USEDEP}]
dev-python/numpydoc[${PYTHON_USEDEP}]
dev-python/matplotlib[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"