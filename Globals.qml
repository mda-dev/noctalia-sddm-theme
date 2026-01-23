import QtQuick 2.15
import QtQuick.Window 2.15
pragma Singleton

QtObject {
    // set up JetBrains
    // ---------------------
    // Mutable properties
    // ---------------------

    id: global

    // ---------------------
    // Immutable properties
    // ---------------------
    readonly property real scaleFactor: Math.max(0.5, Math.min(screenWidth / 1920, screenHeight / 1080))
    readonly property real fontS: 14 * scaleFactor
    readonly property real fontM: 16 * scaleFactor
    readonly property real fontL: 18 * scaleFactor
    readonly property real fontXL: 22 * scaleFactor
    readonly property real fontXXL: 24 * scaleFactor
    readonly property real screenWidth: Screen.width
    readonly property real screenHeight: Screen.height
    readonly property string defaultBackground: "Assets/background.png"
    readonly property string defaultAvatar: "Assets/logo.svg"
    readonly property string font: "Fira Sans, Noto Sans, sans-serif"
    readonly property int backgroundBlur: config.blurRadius || 0
    readonly property real cardOpacity: config.cardOpacity || 0
    readonly property real cardBorderRadius: (config.cardRadius || 20) * scaleFactor
    readonly property real buttonBorderRadius: (config.borderRadius || 20) * scaleFactor
    readonly property real inputBorderRadius: (config.passwordInputRadius || 20) * scaleFactor
    // Colors
    readonly property color mPrimary: config.mPrimary || "#fff59b"
    readonly property color mOnPrimary: config.mOnPrimary || "#0e0e43"
    readonly property color mSecondary: config.mSecondary || "#a9aefe"
    readonly property color mOnSecondary: config.mOnSecondary || "#0e0e43"
    readonly property color mTertiary: config.mTertiary || "#9BFECE"
    readonly property color mOnTertiary: config.mOnTertiary || "#0e0e43"
    readonly property color mError: config.mError || "#FD4663"
    readonly property color mOnError: config.mOnError || "#0e0e43"
    readonly property color mSurface: config.mSurface || "#070722"
    readonly property color mOnSurface: config.mOnSurface || "#f3edf7"
    readonly property color mSurfaceVariant: config.mSurfaceVariant || "#11112d"
    readonly property color mOnSurfaceVariant: config.mOnSurfaceVariant || "#7c80b4"
    readonly property color mOutline: config.mOutline || "#21215F"
    readonly property color mShadow: config.mShadow || "#070722"
    readonly property color mHover: config.mHover || "#9BFECE"
    readonly property color mOnHover: config.mOnHover || "#0e0e43"
    readonly property color mDebug: "purple"
    readonly property bool isDarkMode: isDarkColor(mSurface)

    function isDarkColor(color) {
        var brightness = Math.sqrt(0.299 * Math.pow(color.r, 2) + 0.587 * Math.pow(color.g, 2) + 0.114 * (Math.pow(color.b, 2)));
        return brightness < 0.5;
    }

    function getColorOffset(color) {
        if (isDarkMode)
            return Qt.lighter(color, 1.7);
        else
            return Qt.darker(color, 1.2);
    }

}
