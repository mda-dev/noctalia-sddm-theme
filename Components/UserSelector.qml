import ".."
import QtGraphicalEffects 1.12
import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    // ▲ UP

    id: root

    property int currentIndex: userModel.lastIndex
    property string currentUser: userModel.lastUser
    property int visibleCount: 5 // should be odd
    property real spacing: 20 * Global.scaleFactor
    property real scaleStep: 0.12
    readonly property int animationDuration: 500

    signal selectedUser(int userIndex)

    function clampIndex(i) {
        return Math.max(0, Math.min(userModel.count - 1, i));
    }

    function move(delta) {
        currentIndex = clampIndex(currentIndex + delta);
        selectedUser(currentIndex);
    }

    Keys.onUpPressed: move(-1)
    Keys.onDownPressed: move(1)
    anchors.top: parent.top
    anchors.topMargin: 24 * Global.scaleFactor
    anchors.horizontalCenter: parent.horizontalCenter

    Loader {
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        active: wheel.isSelecting

        sourceComponent: Button {
            id: upBtn

            enabled: currentIndex > 0
            onClicked: move(-1)
            visible: currentIndex > 0
            width: 32 * Global.scaleFactor
            height: 32 * Global.scaleFactor

            background: Rectangle {
                color: upBtn.hovered || upBtn.active ? Global.mPrimary : Global.mSurface
                radius: upBtn.height / 2
            }

            contentItem: Icon {
                utf8Code: "\udb80\udd3f"
                color: upBtn.hovered || upBtn.active ? Global.mSurface : Global.mPrimary
                fontSize: 24 * Global.scaleFactor
            }

        }

    }

    // ▼ DOWN
    Loader {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        active: wheel.isSelecting // false = completely removed

        sourceComponent: Button {
            id: downBtn

            enabled: currentIndex < userModel.count - 1
            visible: currentIndex < userModel.count - 1
            onClicked: move(1)
            width: 32 * Global.scaleFactor
            height: 32 * Global.scaleFactor

            contentItem: Icon {
                utf8Code: "\udb80\udd3c"
                color: downBtn.hovered ? Global.mSurface : Global.mPrimary
                fontSize: 24 * Global.scaleFactor
            }

            background: Rectangle {
                color: downBtn.hovered || downBtn.active ? Global.mPrimary : Global.mSurface
                radius: downBtn.height / 2
            }

        }

    }

    Item {
        id: wheel

        property bool isSelecting: false

        width: parent.width

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onClicked: {
                wheel.isSelecting = !wheel.isSelecting;
            }
        }

        anchors {
            top: parent.top
            bottom: parent.bottom
            margins: 40 * Global.scaleFactor
        }

        Repeater {
            model: userModel

            delegate: Item {
                id: slot

                // relative position to selected item
                property int offset: index - currentIndex

                width: wheel.width
                height: 120 * Global.scaleFactor
                y: wheel.height / 2 + offset * spacing - height / 2
                scale: 1 - Math.min(Math.abs(offset), visibleCount / 2) * scaleStep
                z: 100 - Math.abs(offset)
                visible: Math.abs(offset) <= visibleCount / 2 ? true : false

                Loader {
                    active: wheel.isSelecting || offset === 0

                    sourceComponent: UserCard {
                        id: userCard

                        isActive: offset === 0
                        border.width: offset === 0 ? 0 : wheel.isSelecting ? 1 : 0
                        border.color: Global.getColorOffset(Global.mPrimary)
                        radius: Global.cardBorderRadius
                        opacity: wheel.isSelecting ? 1 : Global.cardOpacity
                        anchors.topMargin: 0
                        color: offset === 0 ? Global.mSurface : Global.mPrimary
                        userIndex: index
                        userName: name
                        userRealName: realName
                        // userIcon: icon
                        userHomeDir: homeDir
                        layer.enabled: wheel.isSelecting || Global.dropShadows
                    }

                }

                Behavior on y {
                    NumberAnimation {
                        duration: animationDuration
                        easing.type: Easing.OutCubic
                    }

                }

                Behavior on scale {
                    NumberAnimation {
                        duration: animationDuration
                        easing.type: Easing.OutCubic
                    }

                }

            }

        }

    }

}
