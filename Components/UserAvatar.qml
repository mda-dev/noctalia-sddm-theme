import ".."
import QtGraphicalEffects 1.15
import QtQuick 2.15
import SddmComponents 2.0

Item {
    id: avatar

    property string primaryUser: userModel.lastUser
    property color borderColor: config.mPrimary
    property url fallbackLogo
    property int tryIndex: 0
    property string userIcon
    property string userHomeDir
    property string user
    property var iconPaths: {
        var paths = [userIcon];
        paths.push("file://" + userHomeDir + "/.face.icon");
        paths.push("file://" + userHomeDir + "/.face");
        paths.push("file:///usr/share/sddm/faces/" + user + ".face.icon");
        paths.push("file:///var/lib/AccountsService/icons/" + user);
        paths.push("file:///usr/share/sddm/faces/.face.icon");
        return paths;
    }

    width: 80 * Global.scaleFactor
    height: 80 * Global.scaleFactor

    Rectangle {
        id: mask

        anchors.fill: parent
        radius: width / 2
        visible: false
    }

    Image {
        id: avatarImage

        anchors.fill: parent
        source: iconPaths[Math.min(tryIndex, avatar.iconPaths.length - 1)]
        sourceSize: Qt.size(width, height)
        fillMode: Image.PreserveAspectCrop
        smooth: true
        asynchronous: true
        visible: status === Image.Ready
        onStatusChanged: {
            if (status === Image.Error && tryIndex < iconPaths.length - 1)
                tryIndex++;

        }
        layer.enabled: true

        layer.effect: OpacityMask {
            maskSource: mask
        }

    }

    Image {
        anchors.fill: parent
        anchors.margins: 8 * Global.scaleFactor
        source: fallbackLogo
        fillMode: Image.PreserveAspectFit
        visible: avatarImage.status !== Image.Ready
        layer.enabled: true

        layer.effect: OpacityMask {
            maskSource: mask
        }

    }

    Rectangle {
        anchors.fill: parent
        radius: width / 2
        color: "transparent"
        border.color: borderColor
        border.width: 2 * Global.scaleFactor
    }

}
