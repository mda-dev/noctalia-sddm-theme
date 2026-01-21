import ".."
import QtQuick 2.15

Text {
    property string utf8Code: "\uf06a"
    property real fontSize: Global.fontM

    text: utf8Code
    font.family: "JetBrainsMono Nerd Font"
    font.pixelSize: fontSize
    font.bold: true
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
}
