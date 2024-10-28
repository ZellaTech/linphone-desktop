import QtQuick
import QtQuick.Controls.Basic as Control
import QtQuick.Effects
import QtQuick.Layouts
import Linphone
  
Control.ScrollBar {
	id: mainItem
	padding: 0
	contentItem: Rectangle {
		implicitWidth: 6 * DefaultStyle.dp
		radius: 32 * DefaultStyle.dp
		color: DefaultStyle.grey_850
	}
}