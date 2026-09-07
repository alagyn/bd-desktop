pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    property var cpu_percent
    property string cpu_freq
    property int mem_percent
    

    Process {
        id: process_cpu_percent
        running: true
        command: ["sh", "-c", "lscpu --json -e=scalmhz%"]
        stdout: StdioCollector {
            onStreamFinished:  {
                        root.cpu_percent = JSON.parse(data)["cpus"].map(a => {
                            return parseFloat(a["scalmhz%"].slice(0, -1)) / 100
                        })
                        // console.log(root.cpu_percent)
            }
        }
    }

    Process {
        id: process_mem_percent
        running: true
        command: ["sh", "-c", "free | awk 'NR==2{print $3/$2*100}'"]
        stdout: SplitParser {
            onRead: data => root.mem_percent = Math.round(data)
        }
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: () => {
            process_cpu_percent.running = true
            process_mem_percent.running = true
        }
    }
}

