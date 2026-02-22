import ".."
import QtQuick 2.15
import QtQuick.Controls 2.15 as Controls
import QtQuick.Layouts 1.15

Controls.ComboBox {
    id: sessionList

    model: sessionModel
    textRole: "name"
    currentIndex: Global.currentSessionIndex // Bind to the Global singleton property
    onCurrentIndexChanged: {
        Global.currentSessionIndex = currentIndex; // Update the Global singleton property
    }

    delegate: Controls.ItemDelegate {
        width: parent.width
        text: model.name || ""
        highlighted: sessionList.highlightedIndex === index

        contentItem: Text {
            text: parent.text
            font.pixelSize: Global.fontS
            color: highlighted ? Global.mTertiary : Global.mOnSurface
            verticalAlignment: Text.AlignVCenter
        }

        background: Rectangle {
            color: parent.highlighted ? Global.mSurfaceVariant : "transparent"
        }

    }

    background: Rectangle {
        id: box

        color: "transparent"
        clip: true
    }

    contentItem: Text {
        leftPadding: 10 * Global.scaleFactor
        font.pixelSize: Global.fontS
        text: sessionList.displayText || ""
        color: Global.mTertiary
        verticalAlignment: Text.AlignVCenter
    }

    popup: Controls.Popup {
        width: sessionList.width
        implicitHeight: contentItem.implicitHeight
        // hacky height meh
        height: contentItem.implicitHeight * 1.3

        contentItem: ListView {
            clip: true
            implicitHeight: contentHeight
            model: sessionList.popup.visible ? sessionList.delegateModel : null
            currentIndex: sessionList.highlightedIndex

            Controls.ScrollIndicator.vertical: Controls.ScrollIndicator {
            }

        }

        background: Rectangle {
            border.color: Global.mPrimary
            color: Global.mSurface
            radius: 0
            clip: true
        }

    }

}
