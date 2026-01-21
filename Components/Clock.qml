import ".."
import QtQuick 2.15

Item {
    // smooth animation
    // Behavior on value {
    //     NumberAnimation {
    //         duration: 900 // smoothness (ms)
    //         easing.type: Easing.InOutQuad
    //     }
    // }
    // function getCustomVariant(color) {
    //     var brightness = Math.sqrt(0.299 * Math.pow(color.r, 2) + 0.587 * Math.pow(color.g, 2) + 0.114 * (Math.pow(color.b, 2)));
    //     if (brightness > 0.5)
    //         return Qt.darker(color, 1.2);
    //     else
    //         return Qt.lighter(color, 1.7);
    // }

    id: root

    // progress control
    property real value: 0
    property real maximum: 60
    property real lineWidth: 4 * Global.scaleFactor
    property color backgroundColor: config.mSurfaceVariant
    property color progressColor: config.mPrimary
    property color textColor: config.mOnSurface
    // current time
    property date currentTime: new Date()
    property color trackColor: Global.getColorOffset(backgroundColor)

    onValueChanged: canvas.requestPaint()
    onMaximumChanged: canvas.requestPaint()

    Canvas {
        id: canvas

        anchors.fill: parent
        onPaint: {
            var ctx = getContext("2d");
            ctx.clearRect(0, 0, width, height);
            var cx = width / 2;
            var cy = height / 2;
            var radius = Math.min(width, height) / 2 - lineWidth;
            // background circle
            ctx.beginPath();
            ctx.arc(cx, cy, radius, 0, 2 * Math.PI);
            ctx.strokeStyle = trackColor;
            ctx.lineWidth = lineWidth + 2 * Global.scaleFactor;
            ctx.stroke();
            // progress arc
            var progress = Math.min(value / maximum, 1);
            var startAngle = -Math.PI / 2;
            var endAngle = startAngle + progress * 2 * Math.PI;
            ctx.beginPath();
            ctx.arc(cx, cy, radius, startAngle, endAngle);
            ctx.strokeStyle = progressColor;
            ctx.lineWidth = lineWidth;
            // ctx.lineCap = "round";
            ctx.stroke();
        }
    }

    Text {
        anchors.centerIn: parent
        text: Qt.formatTime(currentTime, "HH\nmm") // 24h format
        font.family: "JetBrainsMono Nerd Font"
        color: textColor
        font.pixelSize: Global.fontM
    }

}
