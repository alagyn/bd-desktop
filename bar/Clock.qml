import QtQuick
import Quickshell
import qs
import qs.parts

BarGroup {
    id: clockWidget
    color: Colors.bgSecondary
    implicitWidth: child.implicitWidth + 20 
    radius: 15
    Text {
        id: child
        color: Colors.fgLight
        SystemClock {
            id: clock
            precision: SystemClock.Seconds
        }
        text: Qt.formatDateTime(clock.date, "ddd MMM d  hh:mm")
        anchors.centerIn: parent
    }
}
