import ".."
import QtGraphicalEffects 1.15
import QtQuick 2.15
import QtQuick.Layouts 1.15

Rectangle {
    // ========= Public API =========
    id: userCard

    // Layout / scaling
    property real cardWidth: 550 * Global.scaleFactor
    property real cardHeight: 120 * Global.scaleFactor
    property string userName
    property string userRealName
    property string userDisplayName
    property string userIcon
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
                userIcon: userCard.userIcon
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
                    height: 20
                    text: "Welcome back, " + userDisplayName + "!"
                    font.family: Global.font
                    font.pixelSize: Global.fontXXL
                    // font.bold: true
                    font.weight: Font.DemiBold
                    color: Global.mOnSurface
                }

                Text {
                    property color baseColor: Global.mSurfaceVariant

                    height: 20
                    text: Qt.formatDate(new Date(), "dddd, MMMM d")
                    font.family: Global.font
                    font.pixelSize: Global.fontXL
                    font.weight: Font.DemiBold
                    color: Global.mPrimary
                    opacity: 0.6
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

    layer.effect: DropShadow {
        anchors.fill: userCard
        source: userCard
        horizontalOffset: 0
        verticalOffset: 0
        radius: 16 * Global.scaleFactor
        samples: 24
        color: "#40000000"
        visible: offset === 0 ? true : wheel.isSelecting
    }

}
