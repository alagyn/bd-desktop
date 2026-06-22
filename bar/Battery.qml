import org.kde.kirigami
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.UPower
import qs

BarGroup {
    id: root

    readonly property var battery: UPower.displayDevice
    readonly property int percentage: Math.round(battery.percentage * 100)
    visible: battery.isLaptopBattery

    RowLayout {
        id: contentItem
        anchors.centerIn: parent
        Text {
            text: `${root.percentage}%`
            color: Colors.fgLight
        }

        Icon {
            id: batIcon

            implicitHeight: Config.barIconSize
            implicitWidth: Config.barIconSize

            isMask: false

            source: {
                const nearestTen = Math.round(root.percentage / 10) * 10;
                const number = nearestTen.toString();
                let charging;

                if (root.battery.state == UPowerDeviceState.Charging) {
                    if (nearestTen == 100) {
                        charging = "-charged";
                    } else {
                        charging = "-charging";
                    }
                } else if (root.battery.state == UPowerDeviceState.FullyCharged) {
                    charging = "-charged";
                } else {
                    charging = "";
                }

                // TODO fix this hack
                return Quickshell.iconPath(`battery-0${number}${charging}`);
            }
        }
    }
}
