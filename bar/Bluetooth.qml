import org.kde.kirigami
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Bluetooth
import qs
import qs.parts

BarGroup {
    id: root

    property var adapter: Bluetooth.defaultAdapter
    property var bsState: adapter?.state
    property var connected: adapter?.devices.values.filter(d => d.state == BluetoothDeviceState.Connected)
    property var connecting: adapter?.devices.values.filter(d => d.state == BluetoothDeviceState.Connecting)

    visible: !!adapter

    readonly property var iconState: {
        if (bsState === BluetoothAdapterState.Enabled) {
            if (connected?.length) {
                return {icon:"activated-", color: Colors.highlight};
            } else {
                return {icon: "", color: Colors.fgLight}
            }
        } else {
            return {icon: "inactive-", color: Colors.fgLight};
        }
    }
    readonly property string iconPath: Quickshell.iconPath(`network-bluetooth-${iconState.icon}symbolic`)

    Icon {
        id: btIcon

        implicitHeight: Config.barIconSize
        implicitWidth: Config.barIconSize

        isMask: true
        color: root.iconState.color

        source: root.iconPath
        anchors.centerIn: parent
    }
}
