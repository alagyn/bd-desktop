pragma ComponentBehavior: Bound

import QtQuick
import qs
import qs.parts

BarGroup {
    id: root
    
    radius: Config.barChartRadius

    readonly property var colors: [
        "#721817",
        "#fa9f42",
        "#2b4162",
        "#e0e0e2"
    ]
    
    BarChart {
        model: ResourceState.cpu_percent
        colorFunc: (index) => root.colors[index % root.colors.length]
    }

    // RowLayout {
    //     anchors.centerIn: parent
    //     spacing: 3
        
    //     Repeater {
    //         model: ResourceState.cpu_percent

    //         Rectangle {
    //             required property string modelData

    //             implicitWidth: 4
    //             implicitHeight: Config.barIconSize * modelData
    //             Layout.alignment: Qt.AlignBottom
    //         }
    //     }
    // }
}
