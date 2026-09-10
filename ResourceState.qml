pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    readonly property int num_samples: 20
    
    property var cpu_percent: []
    readonly property var mem_percent: Array(num_samples).fill(0)
    property var cpu_temp_perc: Array(num_samples).fill(0)
    property real cpu_temp: 0

    property var prev_work_jiffies: []
    property var prev_total_jiffies: []
    
    // Process {
    //     id: process_cpu_percent
    //     running: true
    //     command: ["sh", "-c", "lscpu --json -e=scalmhz%"]
    //     stdout: StdioCollector {
    //         onStreamFinished:  {
    //             root.cpu_percent = JSON.parse(data)["cpus"].map(a => {
    //                 return parseFloat(a["scalmhz%"].slice(0, -1)) / 100
    //             })
    //         }
    //     }
    // }

    Process {
        id: process_cpu_percent
        running: true
        command: ["awk", "/cpu[0-9]/ {print $2+$3+$4, $2+$3+$4+$5+$6+$7+$8+$9}", "/proc/stat"]
        stdout: StdioCollector {
            onStreamFinished:  {
                var lines = String(data).split("\n").filter((x) => x.trim())
                var new_work_jiffies = Array(lines.length)
                var new_total_jiffies = Array(lines.length)
                for (var i = 0; i < lines.length; ++i)
                {
                    const vals = lines[i].split(" ")

                    new_work_jiffies[i] = parseInt(vals[0])
                    new_total_jiffies[i] = parseInt(vals[1])
                }

                if (new_work_jiffies.length == root.prev_work_jiffies.length)
                {
                    root.cpu_percent = Array(new_work_jiffies.length)
                    
                    for (var i = 0; i < new_work_jiffies.length; ++i)
                    {
                        const work_diff = new_work_jiffies[i] - root.prev_work_jiffies[i]
                        const total_diff = new_total_jiffies[i] - root.prev_total_jiffies[i]
                        if (total_diff != 0)
                        {
                            root.cpu_percent[i] = Math.max(work_diff / total_diff, 0.05)
                        }
                        else
                        {
                            root.cpu_percent[i] = 0.05
                        }
                    }

                    root.cpu_percentChanged()
                }
                else
                {
                    root.cpu_percent = Array(new_work_jiffies.length).fill(0.5)
                }
                root.prev_work_jiffies = new_work_jiffies
                root.prev_total_jiffies = new_total_jiffies
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

            root.cpu_temp = parseFloat(cpu_temp_file.text()) / 1000
            root.cpu_temp_perc.push(root.cpu_temp / Config.maxCpuTemp)
            if (root.cpu_temp_perc.length > root.num_samples)
            {
                root.cpu_temp_perc.shift()
            }

            root.cpu_temp_percChanged()
        }
    }
}

