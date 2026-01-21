import ".."
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Button {
    id: root

    property string label: "[default label]"
    property color textColor: Global.mOnSurface
    property string utf8Icon: "\uf011"
    property color baseColor: Global.mSurfaceVariant

    background: Rectangle {
        radius: Global.buttonBorderRadius
        color: root.down || root.hovered ? root.textColor : "transparent"
        border.width: 1 * Global.scaleFactor
        border.color: root.textColor
    }

    contentItem: RowLayout {
        spacing: 10 * Global.scaleFactor

        Item {
            Layout.fillWidth: true
        }

        Icon {
            utf8Code: root.utf8Icon
            Layout.fillHeight: true
            color: root.down || root.hovered ? Global.mSurface : root.textColor
        }

        Text {
            text: root.label
            font.pixelSize: Global.fontM
            font.bold: true
            color: root.down || root.hovered ? Global.mSurface : root.textColor
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            Layout.fillHeight: true
        }

        Item {
            Layout.fillWidth: true
        }

    }

}
