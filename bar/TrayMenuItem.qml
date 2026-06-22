pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell
import org.kde.kirigami

import qs
import qs.parts
import qs.bar

Squircle {
    id: root
    required property QsMenuEntry modelData
    required property QsMenuOpener opener
    color: "transparent"
    radius: 10

    Layout.fillWidth: true

    signal openSubmenu(handle: QsMenuHandle)

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        enabled: (!root.modelData?.isSeparator ?? false) && (root.modelData?.enabled ?? false)
        hoverEnabled: true
        onEntered: root.color = Colors.highlight
        onExited: root.color = "transparent"
        onClicked: {
            if (root.modelData?.hasChildren ?? false) {
                root.openSubmenu(root.modelData);
            } else {
                root.modelData?.triggered();
            }
        }
    }

    implicitHeight: (root.modelData?.isSeparator ?? false ? 1 : rowLayout.implicitHeight) + Config.menuPadding * 2
    implicitWidth: rowLayout.implicitWidth + Config.menuPadding * 2

    Rectangle {
        visible: root.modelData?.isSeparator ?? false
        anchors.fill: parent
        anchors.margins: Config.menuPadding
        color: Colors.bgPrimary
    }

    RowLayout {
        id: rowLayout
        visible: !root.modelData?.isSeparator ?? false

        spacing: Config.menuPadding

        anchors.fill: parent
        anchors.margins: Config.menuPadding

        Loader {
            id: loader

            active: (root.modelData?.icon ?? false) != ""
            visible: active

            sourceComponent: Icon {
                id: icon

                implicitWidth: Config.barIconSize
                implicitHeight: Config.barIconSize

                isMask: true
                color: Colors.fgLight

                source: Config.getImage(root.modelData?.icon ?? "")
            }
        }

        Text {
            // Maintain vertical alignment when some entries have icons and some don't
            Layout.leftMargin: root.opener.children.values.some(e => e.icon != "") && !loader.active ? Config.barIconSize + rowLayout.spacing : Config.menuPadding * 0.5
            Layout.rightMargin: Config.menuPadding * 0.5
            Layout.fillWidth: true

            text: root.modelData?.text ?? ""
            color: (root.modelData?.enabled ?? false) ? Colors.fgLight : Qt.lighter(Colors.fgLight, 0.6)
        }

        MaterialIcon {
            visible: root.modelData?.hasChildren ?? false
            text: "chevron_right"
            font.pointSize: 13
            font.weight: Font.DemiBold
            Layout.alignment: Qt.AlignRight
        }
    }
}
