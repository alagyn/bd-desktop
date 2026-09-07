pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import qs

BarGroup {
    id: root

    Text {
        anchors.centerIn: parent

        color: Colors.fgLight
        text: `Mem: ${ResourceState.mem_percent}%`
    }
}
