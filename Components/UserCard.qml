import ".."
import QtQuick
import QtQuick.Effects
import QtQuick.Layouts

Rectangle {
    // ========= Public API =========
    id: userCard

    // Layout / scaling
    property real cardWidth: 550 * Global.scaleFactor
    property real cardHeight: 120 * Global.scaleFactor
    property string userName
    property string userRealName
    property string userDisplayName
    property string userHomeDir
    property int userIndex
    property bool isActive

    anchors.top: parent.top
    anchors.horizontalCenter: parent.horizontalCenter
    width: Math.max(cardWidth, Math.min(parent.width * 0.7, cardWidth))
    height: cardHeight
    color: Global.mSurface
    opacity: Global.cardOpacity
    Component.onCompleted: {
        userCard.userDisplayName = userRealName || userName;
    }

    RowLayout {
        anchors.fill: parent
        anchors.margins: 16 * Global.scaleFactor
        spacing: 16 * Global.scaleFactor

        // ========= Avatar =========
        Loader {
            active: isActive

            sourceComponent: UserAvatar {
                id: avatar

                user: userCard.userName
                userHomeDir: userCard.userHomeDir
                Layout.preferredWidth: 70 * Global.scaleFactor
                Layout.preferredHeight: 70 * Global.scaleFactor
                Layout.alignment: Qt.AlignVCenter
            }

        }

        // ========= Text =========
        Item {
            id: middle

            Layout.alignment: Qt.AlignVCenter
            Layout.fillWidth: true
            Layout.preferredHeight: 60 * Global.scaleFactor

            ColumnLayout {
                anchors.fill: parent
                Layout.alignment: Qt.AlignVCenter

                Text {
                    Layout.fillWidth: true
                    text: "Welcome back, " + userDisplayName + "!"
                    font.family: Global.font
                    font.pixelSize: Global.fontXXL
                    // font.bold: true
                    font.weight: Font.DemiBold
                    color: Global.mOnSurface
                    elide: Text.ElideRight
                    maximumLineCount: 1
                }

                Text {
                    property color baseColor: Global.mSurfaceVariant

                    Layout.fillWidth: true
                    text: Qt.formatDate(new Date(), "dddd, MMMM d")
                    font.family: Global.font
                    font.pixelSize: Global.fontXL
                    font.weight: Font.DemiBold
                    color: Global.mPrimary
                    opacity: 0.6
                    elide: Text.ElideRight
                    maximumLineCount: 1
                }

            }

        }

        Loader {
            active: userCard.isActive
            Layout.preferredHeight: 80 * Global.scaleFactor
            Layout.preferredWidth: 80 * Global.scaleFactor

            sourceComponent: Clock {
                id: clock

                value: new Date().getSeconds()

                Timer {
                    interval: 1000
                    running: true
                    repeat: true
                    onTriggered: {
                        clock.currentTime = new Date();
                        clock.value = clock.currentTime.getSeconds();
                    }
                }

            }

        }

    }

    layer.effect: MultiEffect {
        shadowEnabled: true
        shadowColor: "#40000000"
        shadowHorizontalOffset: 0
        shadowVerticalOffset: 0
        shadowBlur: 1.0
        blurMax: Math.round(16 * Global.scaleFactor)
    }

}
