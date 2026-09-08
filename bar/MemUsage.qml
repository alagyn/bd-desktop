pragma ComponentBehavior: Bound

import QtQuick
import qs
import qs.parts

BarGroup {
    id: root

    radius: Config.barChartRadius
    
    BarChart {
        id: chart
        model: ResourceState.mem_percent
        colorFunc: (index) => {
            return "#9ED8DB"
        }
    }

    Connections {
        target: ResourceState
        function onMem_percentChanged() {
            chart.modelChanged()
        }
    }
}
