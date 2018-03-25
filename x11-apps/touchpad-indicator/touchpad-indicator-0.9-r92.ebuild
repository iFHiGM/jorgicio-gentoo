# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="A simple indicator for controlling a synaptics touchpad"
HOMEPAGE="https://launchpad.net/touchpad-indicator"
SRC_URI="https://bazaar.launchpad.net/~lorenzo-carbonell/touchpad-indicator/${PV}/tarball/${PR//r}?start_revid=${PR//r} -> ${P}.tgz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/~lorenzo-carbonell/${PN}/${PV}"

DEPEND="
	dev-python/polib[${PYTHON_USEDEP}]
	dev-python/python-distutils-extra[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}
	dev-libs/libappindicator:3
	dev-python/requests[${PYTHON_USEDEP}]
	x11-libs/libnotify
	x11-drivers/xf86-input-synaptics
"

src_prepare(){
	mv extras-touchpad-indicator.desktop.in touchpad-indicator.desktop.in
	mv data/extras-touchpad-indicator.desktop data/touchpad-indicator.desktop
	find . -type f -exec \
		sed -i -e 's:/opt/extras.ubuntu.com/touchpad-indicator:/usr:g' \
				-e 's:locale-langpack:locale:g' \
				-e 's:extras-touchpad-indicator:touchpad-indicator:g' '{}' \;
	eapply_user
}
