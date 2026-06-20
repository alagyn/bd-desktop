import QtQuick
import Quickshell.Widgets
import qs.parts

WrapperMouseArea {
    id: root

    required property string text
    default property alias contentItem: contentItem.data

    hoverEnabled: true
    acceptedButtons: Qt.NoButton

    onEntered: tooltip.show = true
    onExited: tooltip.show = false

    implicitWidth: contentItem.childrenRect.width
    implicitHeight: contentItem.childrenRect.height

    Item {
        id: contentItem

        TextTooltip {
            id: tooltip
            text: root.text
        }
    }
}

