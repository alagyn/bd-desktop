pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import qs

BarGroup {
    id: root

    RowLayout {
        anchors.centerIn: parent
        spacing: 3
        
        Repeater {
            model: ResourceState.cpu_percent

            Rectangle {
                required property string modelData

                implicitWidth: 4
                implicitHeight: Config.barIconSize * modelData
                Layout.alignment: Qt.AlignBottom
            }
        }
    }
}
