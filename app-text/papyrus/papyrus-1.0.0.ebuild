# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit qmake-utils eutils

DESCRIPTION="Kaqaz-based note manager focused on privacy and social features."
HOMEPAGE="http://aseman.co/en/products/papyrus"

if [[ ${PV} == *9999* ]];then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/Aseman-Land/${PN^}"
	KEYWORDS=""
else
	SRC_URI="https://github.com/Aseman-Land/${PN^}/archive/${PV}-stable.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86 ~arm"
	S="${WORKDIR}/${PN^}-${PV}-stable"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtmultimedia:5[qml]
	dev-qt/qtnetwork:5
	dev-qt/qtprintsupport:5[cups]
	dev-qt/qtsql:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
	dev-qt/qtquickcontrols:5
	dev-libs/openssl:0

"
RDEPEND="${DEPEND}"

src_prepare(){
	PATCHES=(
		"${FILESDIR}/${PN}-qobject-fix.patch"
		"${FILESDIR}/${PN}-qdatastream-fix.patch"
	)
	eapply ${PATCHES[@]}
	eapply_user
}

src_configure(){
	eqmake5 ${PN^}.pro
}

src_install(){
	emake INSTALL_ROOT="${D}" install
}
