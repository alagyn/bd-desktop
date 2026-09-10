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
            model: ResourceState.cpu_temp_perc
            colorFunc: (index, value) => {
                if (value < 0.5)
                {
                    return "#23FF00"
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
            id: label
            color: Colors.fgLight
            text: {
                return `${ResourceState.cpu_temp.toFixed(2)}󰔄`
            }
        }
    }

    Connections {
        target: ResourceState
        function onCpu_temp_percChanged() {
            chart.modelChanged()
        }
    }
}
