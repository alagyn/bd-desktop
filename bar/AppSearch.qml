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
    function findIcon(name) {
        if (name === undefined) {
            return undefined;
        }
        var entry = DesktopEntries.byId(name);
        if (entry) {
            return entry.icon;
        }
        return undefined;
    }

    function findIconForWorkspace(workspaceId) {
        var win = biggestWindowForWorkspace(workspaceId);
        // console.log(win)
        if (win !== null) {
            return Quickshell.iconPath(AppSearch.findIcon(win?.class), "image-missing");
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
