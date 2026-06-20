
pragma Singleton
import QtQuick
import Quickshell

Singleton {
    id: root

    readonly property color bgPrimary: Qt.rgba(0.1, 0.2, 0.39, 1)
    readonly property color bgSecondary: Qt.rgba(0.33, 0.47, 0.57, 1)
    readonly property color highlight: Qt.rgba(0.98, 0.73, 0.36, 1)
    readonly property color fgLight: Qt.rgba(1, 1, 1, 1)
    readonly property color fgDark: Qt.rgba(0, 0, 0, 1)

    readonly property real barInnerMargin: 20
}
