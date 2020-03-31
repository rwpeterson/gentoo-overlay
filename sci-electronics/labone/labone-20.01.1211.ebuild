# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Platform independent instrument control for Zurich Instruments devices"
HOMEPAGE="https://www.zhinst.com/labone"
SRC_URI="https://www.zhinst.com/sites/default/files/media/release_file/2020-02/LabOneLinux64-${PV}.tar.gz"

LICENSE="zi-labone"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="mirror bindist"
IUSE="minimal"

QA_PREBUILT="*"

RDEPEND=""

S=${WORKDIR}/LabOneLinux64-${PV}

src_install() {
	local instPath=/opt/zi
	local instrDir="LabOne64-${PV}"
	local PVyymm=$(echo ${PV} | cut -d . -f 1-2 --output-delimiter=.)

	if ! use minimal ; then

		dodir ${instPath}/${instrDir}
		for dir in API DataServer Documentation Firmware WebServer release_notes_${PVyymm}.txt ; do
			cp -a "$dir" "${D}${instPath}/${instrDir}/" || die
		done

		dosym ../..${instPath}/${instrDir}/DataServer/ziServer /opt/bin/ziServer
		dosym ../..${instPath}/${instrDir}/DataServer/ziDataServer /opt/bin/ziDataServer
		dosym ../..${instPath}/${instrDir}/WebServer/ziWebServer /opt/bin/ziWebServer

	else

		insinto "${instPath}/${instrDir}/API/C/lib"
		doins API/C/lib/*.so
		insinto "${instPath}/${instrDir}/API/C/include"
		doins API/C/include/*.h

	fi

	dosym "../..${instPath}/${instrDir}/API/C/include/ziAPI.h" "usr/include/ziAPI.h"
	dosym "../..${instPath}/${instrDir}/API/C/lib/libziAPI-linux64.so" "usr/$(get_libdir)/libziAPI-linux64.so"

	# the udev integration
	# TODO: /etc/zi/{labone-data-server, hf2-data-server}/config

	sed -e 's:/usr/local/bin/ziServer:/opt/bin/ziServer:g' -i Installer/udev/hf2-config || die
	insinto /etc/zi/hf2-data-server
	newins Installer/udev/hf2-config config
	sed -e 's:/usr/local/bin/ziDataServer:/opt/bin/ziDataServer:g' -i Installer/udev/labone-config || die
	insinto /etc/zi/labone-data-server
	newins Installer/udev/labone-config config
	sed -e 's:/usr/bin/ziServer:/opt/bin/ziServer:g' -i Installer/udev/55-zhinst.rules || die
	insinto /lib/udev/rules.d
	doins Installer/udev/55-zhinst.rules
	exeinto /opt/bin
	doexe Installer/udev/hf2-data-server
	exeinto /opt/bin
	doexe Installer/udev/labone-data-server

	# just to make sure
	dosym ../../opt/bin/hf2-data-server usr/bin/hf2-data-server
	dosym ../../opt/bin/labone-data-server usr/bin/labone-data-server
}

pkg_prerm() {
	local service_paths=("/usr/bin/ziService"
		"/usr/local/bin/ziService"
		"/usr/local/bin/hf2-data-server"
		"/usr/local/bin/labone-data/server")
	for service in ${service_paths[@]}; do
		if [[ -x ${service} ]]; then
			einfo "Stopping ziService (${service})"
			${service} stop
		fi
	done
}
