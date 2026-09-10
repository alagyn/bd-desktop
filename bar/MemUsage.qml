pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import qs
import qs.parts

BarGroup {
    id: root

    radius: Config.barChartRadius

    RowLayout {
        anchors.centerIn: parent

        BarChart {
            id: chart
            spacing: 1
            model: ResourceState.mem_percent
            colorFunc: (index, value) => {
                if (value < 0.5)
                {
                    return "#9ED8DB"
                }
                else if(value < 0.75)
                {
                    return "#FFE400"
                }
                else
                {
                    return "#FF1900"
                }
            }
        }

        Text {
            color: Colors.fgLight
            text: `${(ResourceState.mem_percent[ResourceState.mem_percent.length - 1] * 100).toFixed(0)}%`
        }
    }

    Connections {
        target: ResourceState
        function onMem_percentChanged() {
            chart.modelChanged()
        }
    }
}
