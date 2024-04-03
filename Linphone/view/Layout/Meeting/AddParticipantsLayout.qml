import QtQuick 2.15
import QtQuick.Effects
import QtQuick.Layouts
import QtQuick.Controls as Control
import Linphone
import UtilsCpp 1.0

ColumnLayout {
	id: mainItem
	property string title
	property string validateButtonText
	property string placeHolderText: qsTr("Rechercher des contacts")
	property color titleColor: DefaultStyle.main2_700
	property list<string> selectedParticipants: contactList.selectedContacts
	property int selectedParticipantsCount: selectedParticipants.length
	property alias titleLayout: titleLayout
	property ConferenceInfoGui conferenceInfoGui
	signal returnRequested()
	// Layout.preferredWidth: 362 * DefaultStyle.dp

	function clearSelectedParticipants() {
		contactList.selectedContacts.clear()
	}

	RowLayout {
		id: titleLayout
		Layout.fillWidth: true
		Button {
			background: Item{}
			icon.source: AppIcons.leftArrow
			contentImageColor: DefaultStyle.main1_500_main
			Layout.preferredWidth: 24 * DefaultStyle.dp
			Layout.preferredHeight: 24 * DefaultStyle.dp
			onClicked: mainItem.returnRequested()
		}
		Text {
			text: mainItem.title
			color: mainItem.titleColor
			maximumLineCount: 1
			font {
				pixelSize: 18 * DefaultStyle.dp
				weight: 800 * DefaultStyle.dp
			}
			Layout.fillWidth: true
		}
		Button {
			Layout.preferredWidth: 70 * DefaultStyle.dp
			topPadding: 6 * DefaultStyle.dp
			bottomPadding: 6 * DefaultStyle.dp
			enabled: contactList.selectedContacts.length != 0
			// leftPadding: 12 * DefaultStyle.dp
			// rightPadding: 12 * DefaultStyle.dp
			text: mainItem.validateButtonText
			textSize: 13 * DefaultStyle.dp
			onClicked: {
				mainItem.conferenceInfoGui.core.resetParticipants(contactList.selectedContacts)
				mainItem.returnRequested()
			}
		}
	}
	ListView {
		id: participantList
		Layout.fillWidth: true
		// Layout.fillHeight: true
		Layout.preferredHeight: contentHeight
		Layout.maximumHeight: mainItem.height / 3
		width: mainItem.width
		model: contactList.selectedContacts
		clip: true
		delegate: Item {
			height: 56 * DefaultStyle.dp
			width: participantList.width
			RowLayout {
				anchors.fill: parent
				Avatar {
					Layout.preferredWidth: 45 * DefaultStyle.dp
					Layout.preferredHeight: 45 * DefaultStyle.dp
					address: modelData
				}
				Text {
					property var nameObj: UtilsCpp.getDisplayName(modelData)
					text: nameObj ? nameObj.value : ""
					font.pixelSize: 14 * DefaultStyle.dp
					font.capitalization: Font.Capitalize
				}
				Item {
					Layout.fillWidth: true
				}
				Button {
					Layout.preferredWidth: 24 * DefaultStyle.dp
					Layout.preferredHeight: 24 * DefaultStyle.dp
					background: Item{}
					icon.source: AppIcons.closeX
					contentImageColor: DefaultStyle.main1_500_main
					onClicked: contactList.selectedContacts.splice(index, 1)
				}
			}
		}
	}
	SearchBar {
		id: searchbar
		Layout.fillWidth: true
		placeholderText: mainItem.placeHolderText
	}
	Text {
		text: qsTr("Contacts")
		font {
			pixelSize: 16 * DefaultStyle.dp
			weight: 800 * DefaultStyle.dp
		}
	}
	ContactsList {
		id: contactList
		visible: contentHeight > 0 || searchbar.text.length > 0
		Layout.fillWidth: true
		Layout.fillHeight: true
		Layout.preferredHeight: contentHeight
		multiSelectionEnabled: true
		contactMenuVisible: false
		confInfoGui: mainItem.conferenceInfoGui
		searchBarText: searchbar.text
		onContactAddedToSelection: participantList.positionViewAtEnd()
		headerPositioning: ListView.InlineHeader
		header: MouseArea {
			onClicked: contactList.addContactToSelection(sipAddr.text)
			visible: searchbar.text.length > 0
			height: searchbar.text.length > 0 ? 56 * DefaultStyle.dp : 0
			width: contactList.width
			RowLayout {
				Layout.fillWidth: true
				spacing: 10 * DefaultStyle.dp
				anchors.verticalCenter: parent.verticalCenter
				anchors.leftMargin: 30 * DefaultStyle.dp
				anchors.left: parent.left
				Avatar {
					Layout.preferredWidth: 45 * DefaultStyle.dp
					Layout.preferredHeight: 45 * DefaultStyle.dp
					address: sipAddr.text
				}
				ColumnLayout {
					Text {
						id: sipAddr
						text: UtilsCpp.generateLinphoneSipAddress(searchbar.text)
						font.pixelSize: 14 * DefaultStyle.dp
					}
				}
			}
		}
	}
	Item {
		Layout.fillHeight: true
	}
}