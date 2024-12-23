import QtCore
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Basic as Control
import QtQuick.Dialogs
import Linphone
import SettingsCpp 1.0
import UtilsCpp

AbstractSettingsLayout {
	id: mainItem
	width: parent?.width
	contentModel: [
		{
			title: qsTr("Paramètres"),
			subTitle: "",
			contentComponent: generalParametersComponent
		},
		{
			title: qsTr("Paramètres avancés"),
			subTitle: "",
			contentComponent: advancedParametersComponent
		}
	]

	// General parameters
	/////////////////////

	Component {
		id: generalParametersComponent
		ColumnLayout {
			id: column
			Layout.fillWidth: true
			spacing: 20 * DefaultStyle.dp
			DecoratedTextField {
				propertyName: "mwiServerAddress"
				propertyOwner: account.core
				title: qsTr("URI du serveur de messagerie vocale")
				isValid: function(text) { return UtilsCpp.isValidSIPAddress(text); }
				toValidate: true
				Layout.fillWidth: true
			}
			DecoratedTextField {
				propertyName: "voicemailAddress"
				propertyOwner: account.core
				title: qsTr("URI de messagerie vocale")
				isValid: function(text) { return UtilsCpp.isValidSIPAddress(text); }
				toValidate: true
				Layout.fillWidth: true
			}
		}
	}

	// Advanced parameters
	/////////////////////

	Component {
		id: advancedParametersComponent
		ColumnLayout {
			Layout.fillWidth: true
			spacing: 20 * DefaultStyle.dp
			Text {
				text: qsTr("Transport")
				color: DefaultStyle.main2_600
				font: Typography.p2l
			}
			ComboSetting {
				Layout.fillWidth: true
				Layout.topMargin: -15 * DefaultStyle.dp
				entries: account.core.transports
				propertyName: "transport"
				propertyOwner: account.core
			}
			DecoratedTextField {
				Layout.fillWidth: true
				title: qsTr("URL du serveur mandataire")
				propertyName: "serverAddress"
				propertyOwner: account.core
				isValid: function(text) { return UtilsCpp.isValidSIPAddress(text); }
				toValidate: true
			}
			SwitchSetting {
				titleText: qsTr("Serveur mandataire sortant")
				propertyName: "outboundProxyEnabled"
				propertyOwner: account.core
			}
			DecoratedTextField {
				Layout.fillWidth: true
				propertyName: "stunServer"
				propertyOwner: account.core
				title: qsTr("Adresse du serveur STUN")
				isValid: function(text) { return UtilsCpp.isValidIPAddress(text) || UtilsCpp.isValidHostname(text); }
				toValidate: true
			}
			SwitchSetting {
				titleText: qsTr("Activer ICE")
				propertyName: "iceEnabled"
				propertyOwner: account.core
			}
			SwitchSetting {
				titleText: qsTr("AVPF")
				propertyName: "avpfEnabled"
				propertyOwner: account.core
			}
			SwitchSetting {
				titleText: qsTr("Mode bundle")
				propertyName: "bundleModeEnabled"
				propertyOwner: account.core
			}
			DecoratedTextField {
				Layout.fillWidth: true
				propertyName: "expire"
				propertyOwner: account.core
				title: qsTr("Expiration (en seconde)")
				canBeEmpty: false
				isValid: function(text) { return !isNaN(Number(text)); }
				toValidate: true
			}
			DecoratedTextField {
				Layout.fillWidth: true
				title: qsTr("URI de l’usine à conversations")
				propertyName: "conferenceFactoryAddress"
				propertyOwner: account.core
				isValid: function(text) { return UtilsCpp.isValidSIPAddress(text); }
				toValidate: true
			}
			DecoratedTextField {
				Layout.fillWidth: true
				title: qsTr("URI de l’usine à réunions")
				propertyName: "audioVideoConferenceFactoryAddress"
				propertyOwner: account.core
				isValid: function(text) { return UtilsCpp.isValidSIPAddress(text); }
				visible: !SettingsCpp.disableMeetingsFeature
				toValidate: true
			}
			DecoratedTextField {
				Layout.fillWidth: true
				title: qsTr("URL du serveur d’échange de clés de chiffrement")
				propertyName: "limeServerUrl"
				propertyOwner: account.core
				isValid: function(text) { return UtilsCpp.isValidURL(text); }
				toValidate: true
			}
		}
	}
}
