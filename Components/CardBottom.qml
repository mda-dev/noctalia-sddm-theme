import ".."
import Qt5Compat.GraphicalEffects
import QtQuick
import QtQuick.Layouts

Item {
    id: loginCard

    readonly property real marginRatio: 0.09
    // property real marginRatio: 0.07
    readonly property real cardWidth: 750 * Global.scaleFactor
    readonly property real cardHeight: 160 * Global.scaleFactor
    property int userIndex

    anchors.bottom: parent.bottom
    anchors.bottomMargin: parent.height * marginRatio
    anchors.horizontalCenter: parent.horizontalCenter
    width: Math.max(cardWidth, Math.min(parent.width * 0.7, cardWidth))
    height: cardHeight

    Rectangle {
        id: cardBg

        color: Global.mSurface
        anchors.fill: parent
        radius: Global.cardBorderRadius
        opacity: Global.cardOpacity
        layer.enabled: Global.dropShadows

        layer.effect: DropShadow {
            id: cardShadow

            anchors.fill: cardBg
            source: cardBg
            horizontalOffset: 0
            verticalOffset: 0
            radius: 16
            samples: 24
            color: "#40000000"
        }

    }

    ColumnLayout {
        anchors.fill: parent
        //padding
        anchors.margins: 16 * Global.scaleFactor
        // spacing between items
        spacing: 16 * Global.scaleFactor

        PasswordField {
            Layout.fillWidth: true
            userIndex: loginCard.userIndex
        }

        LoginControls {
            Layout.fillWidth: true
        }

    }

}
