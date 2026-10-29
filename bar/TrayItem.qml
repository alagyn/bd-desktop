pragma ComponentBehavior: Bound

import Quickshell.Services.SystemTray
import Quickshell.Widgets
import Quickshell
import QtQuick

import qs
import qs.parts

MouseArea {
    id: root
    required property SystemTrayItem modelData
    property point position

    implicitWidth: trayIconItem.implicitWidth
    implicitHeight: trayIconItem.implicitHeight

    property alias menu: trayMenuLoader.item

    Loader {
        id: trayMenuLoader

        active: root.modelData.hasMenu && !!root.modelData?.menu

        sourceComponent: TrayMenu {
            id: trayMenu
            position: root.position
            menu: root.modelData.menu
        }
    }

    Rectangle {
        id: trayIconItem

        color: root.menu.visible ? Colors.highlight : root.containsMouse ? Colors.bgSecondary : "transparent"
        radius: 20

        implicitWidth: trayIcon.implicitWidth + Config.menuPadding * 2
        implicitHeight: trayIcon.implicitHeight + Config.menuPadding * 2

        TextTooltip {
            id: tooltip
            text: root.modelData.tooltipTitle
        }

        IconImage {
            id: trayIcon

            anchors.centerIn: parent

            mipmap: true
            source: root.modelData.icon
            implicitSize: Config.barIconSize
        }
    }

    acceptedButtons: Qt.RightButton | Qt.LeftButton

    hoverEnabled: true

    onEntered: tooltip.show = true
    onExited: tooltip.show = false
    onClicked: event => {
        switch (event.button) {
        case Qt.LeftButton:
            modelData.activate();
            break;
        case Qt.RightButton:
            if (modelData.hasMenu) {
                root.position = mapToGlobal(event.x, event.y)
                root.position.y += Config.barHeight / 2
                menu.visible = !menu.visible;
            }
            break;
        }
        event.accepted = true;
    }
}
