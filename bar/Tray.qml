import QtQuick
import Quickshell
import Quickshell.Services.SystemTray
import QtQuick.Layouts

import qs.parts

BarGroup {
    id: root

    visible: SystemTray.items.values.length > 0

    RowLayout {
        anchors.centerIn: parent
        Repeater {
            model: SystemTray.items
            
            TrayItem {}
        }
    }
}
