pragma Singleton

import Quickshell
import QtQuick

PersistentProperties {
    reloadableId: "persistedStates"

    readonly property int textSize: 13
    readonly property int barHeight: 46
    readonly property int barBottomMargin: 5
    readonly property int barSideMargin: 20
    readonly property int barWidgetSpacing: 10
    readonly property int barIconSize: 32
    readonly property int barRadius: barHeight / 2
    readonly property int barGroupHeight: barHeight - 12
    readonly property int barGroupRadius: barGroupHeight / 2

    readonly property int barGroupEdgeOffset: (Config.barHeight - Config.barGroupHeight) / 2

    readonly property string wlanDev: "wlan0"

    readonly property real menuPadding: 2

    function getImage(image: string): string {
        if (image.search(/:\/\//) != -1)
            return Qt.resolvedUrl(image);
        return Quickshell.iconPath(image);
    }
}
