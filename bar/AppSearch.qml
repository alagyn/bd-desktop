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
    function getWindowsForWorkspace(workspaceId) {
        const windowsInThisWorkspace = windowList.filter(w => w.workspace.id == workspaceId);
        if (windowsInThisWorkspace.length == 0)
        {
            return []
        }
        windowsInThisWorkspace.sort((a, b) => {
            return a.at[0] - b.at[0]
        })

        return windowsInThisWorkspace;
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

    function findIconsForWorkspace(workspaceId) {
        var wins = getWindowsForWorkspace(workspaceId);

        var out = wins.map((win) => Quickshell.iconPath(AppSearch.findIcon(win), "image-missing"))
        return out;
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
