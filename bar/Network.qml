import org.kde.kirigami
import QtQuick
import Quickshell
import Quickshell.Io
import QtQuick.Layouts
import qs

BarGroup {
    id: root

    property bool connected: false
    property string ssid: ""
    property string ipAddr: ""
    property string icon: ""

    RowLayout {
        anchors.centerIn: parent
        spacing: 6
        Icon {
            id: wifiIcon

            implicitHeight: Config.barIconSize
            implicitWidth: Config.barIconSize

            // isMask: true
            // color: Colors.foreground

            source: root.icon
        }
        Text {
            
            text: `${root.ipAddr} ${root.ssid}`
            color: Colors.fgLight
        }
    }

    Process {
        id: wifiCheck

        command: ["iwctl", "station", Config.wlanDev, "show"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                var lines = this.text.split("\n");

                function getValue(line) {
                    line = line.trim();
                    var idx = line.lastIndexOf(" ");
                    return line.substring(idx + 1, line.length);
                }

                var status = getValue(lines[5]);
                root.connected = status === "connected";
                if (root.connected) {
                    root.ssid = getValue(lines[6]);
                    root.ipAddr = getValue(lines[7]);
                    root.icon = Quickshell.iconPath("network-wireless-100");
                } else {
                    root.ssid = "[Disconnected]";
                    root.ipAddr = "xxx.xxx.xxx.xxx";
                    root.icon = Quickshell.iconPath("network-wireless-off");
                }
            }
        }
    }

    Timer {
        interval: 5000
        running: true
        repeat: true
        onTriggered: wifiCheck.running = true
    }
}
