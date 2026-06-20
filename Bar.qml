import Quickshell // for PanelWindow
import QtQuick.Layouts
import QtQuick // for Text

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
                bottom: 5
                left: 20
                right: 20
            }
            implicitHeight: 46

            Rectangle {
                anchors.fill: parent
                color: Colors.bgPrimary
                radius: 15
                // Left
                RowLayout {
                    id: leftWidgets
                    spacing: 2
                    anchors {
                        bottom: parent.bottom
                        left: parent.left
                        top: parent.top
                        leftMargin: Config.barWidgetSpacing
                    }
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
                    spacing: 10
                    anchors {
                        bottom: parent.bottom
                        right: parent.right
                        top: parent.top
                        rightMargin: Config.barWidgetSpacing
                    }
                    // TODO Brightness/Volume
                    Battery {}
                    Clock {}
                }
            }
        }
    }
}
