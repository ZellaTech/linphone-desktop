import QtQuick 2.15
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Controls as Control
import Linphone

Button {
	id: mainItem
	property string iconUrl
	property string checkedIconUrl
	property color color: DefaultStyle.grey_500
	property color checkedColor: DefaultStyle.main2_400
	leftPadding: 0
	rightPadding: 0
	topPadding: 0
	bottomPadding: 0
	checkable: true
	background: Rectangle {
		anchors.fill: parent
		color: mainItem.enabled
				? mainItem.pressed || mainItem.checked
					? mainItem.checkedColor
					: mainItem.color
				: DefaultStyle.grey_600
		radius: mainItem.width * 1.29
	}
	icon.source: checkedIconUrl && mainItem.checked ? checkedIconUrl : iconUrl
	icon.width: width * 0.58
	icon.height: width * 0.58
	contentImageColor: enabled ? DefaultStyle.grey_0 : DefaultStyle.grey_500
}