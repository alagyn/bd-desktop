pragma Singleton

import Quickshell
import QtQuick

PersistentProperties {
    reloadableId: "persistedStates"

    property var preferredMonitor: {
        const screens = [...Quickshell.screens];
        if (screens.length == 1)
            return screens[0];
        return [...Quickshell.screens].find(e => e.name == "eDP-1");
    }

    readonly property string font: "Monaspace Neon NF"

    readonly property int textSize: 13
    readonly property int barHeight: 48
    readonly property int barBottomMargin: 5
    readonly property int barSideMargin: 20
    readonly property int barWidgetSpacing: 10
    readonly property int barIconSize: 32
    readonly property int barRadius: barHeight / 2
    readonly property int barGroupHeight: barHeight - 8
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
