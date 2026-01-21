import ".."
import QtQuick 2.15
import QtQuick.Layouts 1.15
import SddmComponents 2.0

Item {
    id: root

    height: 48 * Global.scaleFactor

    RowLayout {
        readonly property real layoutSpacing: 12 * Global.scaleFactor
        readonly property real iconSize: root.height - (2 * layoutSpacing)

        spacing: layoutSpacing
        anchors.fill: parent

        // Desktop enviroment selector
        DeSelector {
            Layout.preferredWidth: 240 * Global.scaleFactor
            Layout.fillHeight: true
        }

        // Power Management Buttons
        Repeater {
            model: [{
                "text": "Suspend",
                "type": "suspend",
                "textColor": Global.mPrimary,
                "icon": "\uf04c"
            }, {
                "text": "Reboot",
                "type": "reboot",
                "textColor": Global.mPrimary,
                "icon": "\uf021"
            }, {
                "text": "Shutdown",
                "type": "shutdown",
                "textColor": Global.mError,
                "icon": "\uf011"
            }]

            delegate: ControlButton {
                label: modelData.text
                textColor: modelData.textColor
                utf8Icon: modelData.icon
                Layout.fillHeight: true
                Layout.fillWidth: true
                onClicked: {
                    if (modelData.type === "suspend")
                        sddm.suspend();
                    else if (modelData.type === "reboot")
                        sddm.reboot();
                    else if (modelData.type === "shutdown")
                        sddm.powerOff();
                }
            }

        }

    }

}
