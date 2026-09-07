pragma Singleton

import Quickshell
import QtQuick
import Quickshell.Io
import Quickshell.Hyprland

Singleton {
    id: root

    property var windowList: []
    // property var addresses: []
    // property var windowByAddress: ({})
    function biggestWindowForWorkspace(workspaceId) {
        const windowsInThisWorkspace = windowList.filter(w => w.workspace.id == workspaceId);
        return windowsInThisWorkspace.reduce((maxWin, win) => {
            const maxArea = (maxWin?.size?.[0] ?? 0) * (maxWin?.size?.[1] ?? 0);
            const winArea = (win?.size?.[0] ?? 0) * (win?.size?.[1] ?? 0);
            return winArea > maxArea ? win : maxWin;
        }, null);
    }
    function findIcon(window) {
        if (window=== undefined) {
            return undefined;
        }

        const values = [window.class, window.initialClass, window.initialTitle]

        for(var i = 0; i < values.length; i++)
        {
            var entry = DesktopEntries.byId(values[i]);
            if (entry) {
                return entry.icon;
            }
        }

        for(var i = 0; i < DesktopEntries.applications.values.length; i++)
        {
            const entry = DesktopEntries.applications.values[i];
            if(entry.startupClass == window.initialClass)
            {
                return entry.icon;
            }
        }

        // console.log(JSON.stringify(window))

        return undefined;
    }

    function findIconForWorkspace(workspaceId) {
        var win = biggestWindowForWorkspace(workspaceId);
        // console.log(win)
        if (win !== null) {
            // console.log(JSON.stringify(win))
            return Quickshell.iconPath(AppSearch.findIcon(win), "image-missing");
        }
        return undefined;
    }
    Connections {
        target: Hyprland

        function onRawEvent(event) {
            // console.log("Hyprland raw event:", event.name);
            if (["openlayer", "closelayer", "screencast"].includes(event.name))
                return;
            getClients.running = true;
        }
    }
    Process {
        id: getClients
        running: true
        command: ["hyprctl", "clients", "-j"]
        stdout: StdioCollector {
            id: clientsCollector
            onStreamFinished: {
                root.windowList = JSON.parse(clientsCollector.text);
                // let tempWinByAddress = {};
                // for (var i = 0; i < root.windowList.length; ++i) {
                //     var win = root.windowList[i];
                //     tempWinByAddress[win.address] = win;
                // }
                // root.windowByAddress = tempWinByAddress;
                // root.addresses = root.windowList.map(win => win.address);
            }
        }
    }
}
