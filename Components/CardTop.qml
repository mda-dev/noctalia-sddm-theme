import ".."
import QtGraphicalEffects 1.15
import QtQuick 2.15
import QtQuick.Layouts 1.15

Rectangle {
    // ========= Public API =========
    id: headerCard

    // Layout / scaling
    property real cardWidth: 550 * Global.scaleFactor
    property real cardHeight: 120 * Global.scaleFactor
    property real topMarginRatio: 0.095
    property int userIndex
    property int userDisplayName

    anchors.top: parent.top
    anchors.topMargin: parent.height * topMarginRatio
    anchors.horizontalCenter: parent.horizontalCenter
    width: Math.max(cardWidth, Math.min(parent.width * 0.7, cardWidth))
    height: cardHeight
    color: Global.mSurface
    opacity: Global.cardOpacity
    Component.onCompleted: {
        console.log("userIndex:" + userIndex);
        console.log("lastIndex:" + userModel.lastIndex);
        console.log("userModel:" + name);
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            clock.currentTime = new Date();
            clock.value = clock.currentTime.getSeconds();
        }
    }

    RowLayout {
        anchors.fill: parent
        anchors.margins: 16 * Global.scaleFactor
        spacing: 16 * Global.scaleFactor

        // ========= Avatar =========
        UserAvatar {
            id: avatar

            Layout.preferredWidth: 70 * Global.scaleFactor
            Layout.preferredHeight: 70 * Global.scaleFactor
            Layout.alignment: Qt.AlignVCenter
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
                    text: "Welcome back, " + avatar.displayName + "!"
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

        Clock {
            id: clock

            value: new Date().getSeconds()
            Layout.preferredWidth: 80 * Global.scaleFactor
            Layout.preferredHeight: 80 * Global.scaleFactor
        }

    }

}
