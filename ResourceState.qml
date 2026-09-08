pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    readonly property int num_samples: 20
    
    property var cpu_percent: Array(num_samples).fill(0)
    readonly property var mem_percent: Array(num_samples).fill(0)
    property var cpu_temp: Array(num_samples).fill(0)

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
        command: ["sh", "-c", "free | awk 'NR==2{print $3/$2}'"]
        stdout: SplitParser {
            onRead: data => {
                var new_value = parseFloat(data)
                root.mem_percent.push(new_value)
                if (root.mem_percent.length > root.num_samples)
                {
                    root.mem_percent.shift()
                }

                root.mem_percentChanged()
            }
        }
    }

    FileView {
        id: cpu_temp_file
        path: "/sys/class/thermal/thermal_zone1/temp"
        
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: () => {
            process_cpu_percent.running = true
            process_mem_percent.running = true

            cpu_temp_file.reload()
            
            root.cpu_temp.push(parseFloat(cpu_temp_file.text()) / 1000 / Config.maxCpuTemp)
            if (root.cpu_temp.length > root.num_samples)
            {
                root.cpu_temp.shift()
            }

            root.cpu_tempChanged()
        }
    }
}

