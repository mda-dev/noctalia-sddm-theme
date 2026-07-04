import QtQuick
import QtQuick.Effects

Rectangle {
    id: root

    function setSelectedUser(user) {
        root.selectedUser = user;
    }

    color: config.mSurfaceVariant
    LayoutMirroring.enabled: Qt.locale().textDirection == Qt.RightToLeft
    LayoutMirroring.childrenInherit: true
    width: Global.screenWidth
    height: Global.screenHeight

    // -------------------------------------------------------------------------
    // Background
    // -------------------------------------------------------------------------
    Image {
        id: wallpaper

        anchors.fill: parent
        source: config.background || Global.defaultBackground
        fillMode: Image.PreserveAspectCrop
        asynchronous: true
        cache: true
        clip: true
        visible: Global.backgroundBlur <= 0
    }

    MultiEffect {
        anchors.fill: parent
        source: wallpaper
        blurEnabled: true
        blur: 1.0
        blurMax: 32
        visible: Global.backgroundBlur > 0
    }

    UserSelector {
        id: userSelector

        width: 550 * Global.scaleFactor
        height: 250 * Global.scaleFactor
        onSelectedUser: function(currUserIndex) {
            bottomCard.userIndex = currUserIndex;
        }
    }

    CardBottom {
        id: bottomCard

        userIndex: userModel.lastIndex
    }

}
