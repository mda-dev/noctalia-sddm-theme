import ".."
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Button {
    // Defaults that can still be overridden

    id: root

    property color bgColor: Global.mSurfaceVariant
    property color textColor: Global.mOnSurfaceVariant
    property int fontSize: Global.fontM
    property real borderRadius: Global.buttonRadius
    property string utf8Code: "\uf071"

    background: Rectangle {
        radius: root.borderRadius
        color: root.down || root.hovered ? bgColor : "transparent"
        border.color: bgColor
        border.width: 1
    }

    contentItem: Icon {
        utf8Code: root.utf8Code
        fontSize: root.fontSize
        color: root.down || root.hovered ? textColor : bgColor
        Layout.fillWidth: true
    }

}
