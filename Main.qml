import QtGraphicalEffects 1.12
import QtQuick 2.15

Rectangle {
    // CardTop {
    //     radius: Global.cardBorderRadius
    //     opacity: Global.cardOpacity
    // }

    id: root

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

    FastBlur {
        anchors.fill: parent
        source: wallpaper
        radius: 20
        transparentBorder: false
        visible: Global.backgroundBlur > 0
        cached: true
    }

    CardBottom {
        radius: Global.cardBorderRadius
        opacity: Global.cardOpacity
    }

    UserSelector {
    }

}
