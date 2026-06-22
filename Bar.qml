import Quickshell // for PanelWindow
import QtQuick.Layouts
import QtQuick // for Text

import qs
import qs.bar

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData
            screen: modelData
            color: "transparent"
            anchors {
                top: false
                left: true
                right: true
                bottom: true
            }

            margins {
                bottom: Config.barBottomMargin
                left: Config.barSideMargin
                right: Config.barSideMargin
            }
            implicitHeight: Config.barHeight

            Rectangle {
                anchors.fill: parent
                color: Colors.bgPrimary
                radius: Config.barRadius
                // Left
                RowLayout {
                    id: leftWidgets
                    spacing: Config.barWidgetSpacing
                    anchors {
                        bottom: parent.bottom
                        left: parent.left
                        top: parent.top
                        leftMargin: Config.barGroupEdgeOffset
                    }
                    Bluetooth {}
                    Network {}
                }
                // Center
                RowLayout {
                    id: centerWidgets
                    spacing: 2
                    anchors {
                        bottom: parent.bottom
                        horizontalCenter: parent.horizontalCenter
                        top: parent.top
                    }
                    Workspaces {}
                }
                // Right
                RowLayout {
                    id: rightWidgets
                    spacing: Config.barWidgetSpacing
                    anchors {
                        bottom: parent.bottom
                        right: parent.right
                        top: parent.top
                        rightMargin: Config.barGroupEdgeOffset
                    }
                    // TODO Brightness/Volume
                    Tray {}
                    Battery {}
                    Clock {}
                }
            }
        }
    }
}
