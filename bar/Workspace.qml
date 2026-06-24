import Quickshell.Widgets
import Quickshell.Hyprland
import QtQuick
import QtQuick.Effects
import org.kde.kirigami
import qs

WrapperMouseArea {
    id: root
    required property var modelData
    onPressed: Hyprland.dispatch(`hl.dsp.focus({workspace = ${modelData.index}})`)

    implicitHeight: parent.height
    implicitWidth: ws.implicitWidth

    Rectangle {
        id: ws
        color: "transparent"
        // color: "white"

        implicitHeight: wsRect.implicitHeight
        implicitWidth: wsRect.implicitWidth

        Behavior on implicitWidth {
            NumberAnimation {
                duration: 325
                easing.type: Easing.OutQuint
            }
        }

        Rectangle {
            id: wsRect
            radius: 16

            anchors.centerIn: parent
            implicitHeight: {
                if (root.modelData.workspace?.focused ?? false) {
                    return Config.barIconSize * 1.3;
                }
                return Config.barIconSize;
            }
            implicitWidth: {
                if (root.modelData.workspace?.focused ?? false) {
                    return Config.barIconSize * 1.3;
                }
                return Config.barIconSize;
            }
            // implicitWidth: windowIcon.implicitWidth + 8
            // implicitHeight: windowIcon.implicitHeight + 8

            Icon {
                id: windowIcon
                anchors.centerIn: parent
                source: AppSearch.findIconForWorkspace(root.modelData.index)
                visible: source !== undefined

                implicitHeight: root.modelData.workspace?.focused ? Config.barIconSize : Config.barIconSize - 10
                implicitWidth: root.modelData.workspace?.focused ? Config.barIconSize : Config.barIconSize - 10
            }

            Behavior on color {
                ColorAnimation {
                    duration: 325
                    easing.type: Easing.OutQuint
                }
            }
            color: root.modelData.workspace?.focused ? Colors.highlight : Colors.bgSecondary
        }

        MultiEffect {
            source: wsRect
            anchors.fill: wsRect
            shadowEnabled: true
            shadowVerticalOffset: 2
            blurMax: 16
            opacity: 0.8
        }
    }
}
