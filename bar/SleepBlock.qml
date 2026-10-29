import Quickshell
import QtQuick
import Quickshell.Wayland
import org.kde.kirigami

import qs
import qs.parts

BarGroup {
    id: root
    required property var window
    
    IdleInhibitor {
        id: inhibitor
        window: root.window
        enabled: false
    }


    Icon {
        id: icon

        implicitHeight: Config.barIconSize
        implicitWidth: Config.barIconSize

        anchors.centerIn: parent

        readonly property string disabledIcon: Quickshell.iconPath("unlock-symbolic")
        readonly property string enabledIcon: Quickshell.iconPath("lock-symbolic")

        source: inhibitor.enabled ? enabledIcon : disabledIcon
        MouseArea {
            id: mouseArea

            implicitHeight: Config.barIconSize
            implicitWidth: Config.barIconSize
            anchors.centerIn: parent
            
            
            onClicked: event => {
                switch (event.button)
                {
                case Qt.LeftButton:
                    inhibitor.enabled = ! inhibitor.enabled
                    break;
                }
            }
        }
    }
}
