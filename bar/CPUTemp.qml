pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io
import qs
import qs.parts

BarGroup {
    id: root

    radius: Config.barChartRadius

    BarChart {
        id: chart
        model: ResourceState.cpu_temp
        colorFunc: (index) => {
            return "#DA4167"
        }
    }

    Connections {
        target: ResourceState
        function onCpu_tempChanged() {
            chart.modelChanged()
        }
    }
}
