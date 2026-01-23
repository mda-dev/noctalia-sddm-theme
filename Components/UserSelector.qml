import ".."
import QtGraphicalEffects 1.12
import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    // ▲ UP

    id: root

    property int currentIndex: userModel.lastIndex
    property int visibleCount: 5 // should be odd
    property real spacing: 20
    property real scaleStep: 0.12
    readonly property int animationDuration: 220

    function clampIndex(i) {
        return Math.max(0, Math.min(userModel.count - 1, i));
    }

    function move(delta) {
        console.log(userModel.count);
        currentIndex = clampIndex(currentIndex + delta);
    }

    Keys.onUpPressed: move(-1)
    Keys.onDownPressed: move(1)
    width: 550
    height: 250
    anchors.top: parent.top
    anchors.topMargin: 24 * Global.scaleFactor
    anchors.horizontalCenter: parent.horizontalCenter

    ListModel {
        id: pickerModel

        Component.onCompleted: {
            for (let i = 1; i <= 3; i++) append({
                "text": "Jimmeh" + i
            })
        }
    }
    // Up Button

    Button {
        id: upBtn

        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        enabled: currentIndex > 0
        onClicked: move(-1)
        visible: currentIndex > 0
        width: 32 * Global.scaleFactor
        height: 32 * Global.scaleFactor
        opacity: wheel.controlsVisible ? 1 : 0

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

    // ▼ DOWN
    Button {
        id: downBtn

        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        enabled: currentIndex < userModel.count - 1
        visible: currentIndex < userModel.count - 1
        onClicked: move(1)
        width: 32 * Global.scaleFactor
        height: 32 * Global.scaleFactor
        opacity: wheel.controlsVisible ? 1 : 0

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

    Item {
        id: wheel

        property bool controlsVisible: false

        width: parent.width

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onClicked: {
                wheel.controlsVisible = !wheel.controlsVisible;
            }
        }

        anchors {
            top: parent.top
            bottom: parent.bottom
            margins: 40
        }

        Repeater {
            model: userModel

            delegate: Item {
                id: slot

                // relative position to selected item
                property int offset: index - currentIndex

                width: wheel.width
                height: 120
                y: wheel.height / 2 + offset * spacing - height / 2
                scale: 1 - Math.min(Math.abs(offset), visibleCount / 2) * scaleStep
                z: 100 - Math.abs(offset)
                visible: Math.abs(offset) <= visibleCount / 2 ? true : false
                Component.onCompleted: {
                    console.log(name, realName, icon);
                }

                CardTop {
                    id: userCard

                    border.width: offset === 0 ? 0 : wheel.controlsVisible ? 1 : 0
                    border.color: Global.getColorOffset(Global.mPrimary)
                    radius: Global.cardBorderRadius
                    opacity: offset === 0 ? 1 : Global.cardOpacity
                    anchors.topMargin: 0
                    visible: offset === 0 ? true : wheel.controlsVisible
                    color: offset === 0 ? Global.mSurface : Global.mPrimary
                    userIndex: index
                }

                DropShadow {
                    anchors.fill: userCard
                    source: userCard
                    horizontalOffset: 0
                    verticalOffset: 0
                    radius: 20
                    samples: 24
                    color: "#40000000"
                    visible: offset === 0 ? true : wheel.controlsVisible
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
