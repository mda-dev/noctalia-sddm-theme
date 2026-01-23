import ".."
import QtQuick 2.15
import QtQuick.Layouts 1.15
import SddmComponents 2.0

Rectangle {
    id: root

    property string textVal: ""
    property bool error: false
    property int userIndex
    property var cachedUsers: []

    height: 50 * Global.scaleFactor
    color: Global.mSurface
    radius: Global.inputBorderRadius
    border.width: 2 * Global.scaleFactor
    border.color: errorMessage.text !== "" ? Global.mError : Global.mPrimary

    // Cache users
    Repeater {
        model: userModel

        delegate: Item {
            Component.onCompleted: {
                cachedUsers.push({
                    "name": name,
                    "realName": realName,
                    "icon": icon
                });
            }
        }

    }

    RowLayout {
        id: row

        readonly property real layoutSpacing: 10 * Global.scaleFactor
        readonly property real anchorMargins: 7 * Global.scaleFactor
        readonly property real iconSize: root.height - (2 * layoutSpacing)

        anchors.fill: parent
        anchors.margins: anchorMargins
        spacing: layoutSpacing

        Icon {
            id: icon

            color: Global.mPrimary
            fontSize: Global.fontXL
            utf8Code: "\udb84\udd5e"
            Layout.alignment: Qt.AlignVCenter
            Layout.preferredWidth: row.iconSize
            Layout.preferredHeight: row.iconSize
        }

        TextInput {
            id: passwordField

            verticalAlignment: Text.AlignVCenter
            echoMode: TextInput.Password
            color: error ? Global.mError : Global.mPrimary
            font.pixelSize: Global.fontS
            font.bold: true
            font.letterSpacing: 5 * Global.scaleFactor
            focus: true
            text: ""
            onAccepted: sddm.login(userModel.lastUser, passwordField.text, sessionModel.lastIndex)
            Layout.fillWidth: true
            Keys.onPressed: {
                if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                    sddm.login(userModel.lastUser, passwordField.text, sessionModel.lastIndex);
                    event.accepted = true;
                }
            }
        }
        // placeholder text

        IconButton {
            id: iconButton

            utf8Code: "\udb80\udf11"
            bgColor: Global.mPrimary
            textColor: Global.mSurface
            borderRadius: Math.max(root.radius - row.anchorMargins, 0)
            Layout.fillHeight: true
            Layout.preferredWidth: iconButton.hovered ? 100 * Global.scaleFactor : root.height - (2 * row.anchorMargins)
            onClicked: () => {
                var currUserName = cachedUsers[userIndex].name;
                sddm.login(currUserName, passwordField.text, sessionModel.lastIndex);
            }
        }

    }

    Connections {
        function onLoginFailed() {
            passwordField.text = "";
            errorMessage.text = "Authentication failed!";
        }

        target: sddm
    }

    Rectangle {
        id: errorBox

        property real padding: 12 * Global.scaleFactor
        readonly property real childrenWidth: errorLayout.implicitWidth + (padding * 2)
        readonly property real childrenHeight: errorLayout.implicitHeight + (padding * 2)

        width: Math.max(childrenWidth, 300 * Global.scaleFactor)
        height: childrenHeight
        color: Global.mError
        radius: Global.cardBorderRadius
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: childrenHeight - (3 * childrenHeight)
        visible: errorMessage.text !== ""
        opacity: Global.cardOpacity

        RowLayout {
            id: errorLayout

            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: parent.padding
            spacing: 12 * Global.scaleFactor

            Icon {
                fontSize: Global.fontXL
                color: Global.mOnError
            }

            Text {
                id: errorMessage

                color: Global.mOnError
                font.family: Global.font
                font.weight: Font.DemiBold
                font.pixelSize: Global.fontL
                font.italic: true
                text: ""
            }

        }

    }

}
