pragma ComponentBehavior: Bound

import QtQuick
import qs
import qs.parts

BarGroup {
    id: root
    
    radius: Config.barChartRadius

    readonly property var colors: [
        Qt.rgba(0.016, 1.000, 0.000, 1.000),
        Qt.rgba(0.000, 1.000, 0.984, 1.000),
        Qt.rgba(0.984, 0.000, 1.000, 1.000),
        Qt.rgba(1.000, 0.000, 0.016, 1.000)
    ]
    
    BarChart {
        id: chart
        anchors.centerIn: parent
        model: ResourceState.cpu_percent
        colorFunc: (index) => {
            return Colors.multi_lerp(colors, index / (ResourceState.cpu_percent.length - 1))
        }
    }

    Connections {
        target: ResourceState
        function onCpu_percentChanged() {
            chart.modelChanged()
        }
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
