import ".."
import QtQuick

Text {
    property string utf8Code: "\uf06a"
    property real fontSize: Global.fontM

    text: utf8Code
    font.family: Global.nerdFont
    font.pixelSize: fontSize
    font.bold: true
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
}
