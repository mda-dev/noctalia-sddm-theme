import ".."
import QtGraphicalEffects 1.15
import QtQuick 2.15
import SddmComponents 2.0

Item {
    id: avatar

    property string primaryUser: userModel.lastUser
    property color borderColor: config.mPrimary
    property url fallbackLogo
    readonly property string displayName: currentRealName !== "" ? currentRealName : (displayUser !== "" ? displayUser : "User")
    property int tryIndex: 0
    property string firstUserName: ""
    property string currentIcon: ""
    property string currentHome: ""
    property string currentRealName: ""
    property string displayUser: primaryUser !== "" ? primaryUser : firstUserName
    property var iconPaths: {
        var paths = [];
        if (displayUser) {
            if (currentIcon)
                paths.push(currentIcon.startsWith("/") ? "file://" + currentIcon : currentIcon);

            if (currentHome) {
                paths.push("file://" + currentHome + "/.face.icon");
                paths.push("file://" + currentHome + "/.face");
            }
            paths.push("file:///usr/share/sddm/faces/" + displayUser + ".face.icon");
            paths.push("file:///var/lib/AccountsService/icons/" + displayUser);
        }
        paths.push("file:///usr/share/sddm/faces/.face.icon");
        return paths;
    }

    width: 80 * Global.scaleFactor
    height: 80 * Global.scaleFactor
    onDisplayUserChanged: tryIndex = 0

    Repeater {
        model: userModel

        delegate: Item {
            visible: false

            Binding {
                target: avatar
                property: "firstUserName"
                value: model.name
                when: index === 0
            }

            Binding {
                target: avatar
                property: "currentIcon"
                value: model.icon
                when: model.name === avatar.displayUser
            }

            Binding {
                target: avatar
                property: "currentHome"
                value: model.homeDir
                when: model.name === avatar.displayUser
            }

            Binding {
                target: avatar
                property: "currentRealName"
                value: model.realName
                when: model.name === avatar.displayUser
            }

        }

    }

    Rectangle {
        id: mask

        anchors.fill: parent
        radius: width / 2
        visible: false
    }

    Image {
        id: avatarImage

        anchors.fill: parent
        source: iconPaths[Math.min(tryIndex, iconPaths.length - 1)]
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
