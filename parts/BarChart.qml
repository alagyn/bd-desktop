pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell
import qs

RowLayout {
    id: root
    anchors.centerIn: parent
    spacing: 3

    required property var model
    required property var colorFunc


    Repeater {
        id: rep
        model: root.model

        Rectangle {
            required property var modelData
            required property int index

            implicitWidth: 5
            implicitHeight: Config.barIconSize
            Layout.alignment: Qt.AlignBottom
            color: "transparent"

            Rectangle {
                color: root.colorFunc(parent.index)
                implicitHeight: Config.barIconSize * parent.modelData
                implicitWidth: 5

                anchors.bottom: parent.bottom
            }
        }
    }
}
