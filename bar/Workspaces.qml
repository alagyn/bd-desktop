import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Widgets

WrapperMouseArea {
    id: root

    Layout.fillHeight: true

    readonly property HyprlandMonitor monitor: Hyprland.monitorFor(QsWindow.window?.screen)
    readonly property int activeWorkspace: monitor?.activeWorkspace?.id ?? 1
    property int shownWorkspaces: 10
    property int baseWorkspace: Math.floor((activeWorkspace - 1) / shownWorkspaces) * shownWorkspaces + 1

    property int scrollAccumulator: 0

    acceptedButtons: Qt.NoButton

    onWheel: event => {
        event.accepted = true;
        let acc = scrollAccumulator - event.angleDelta.x - event.angleDelta.y;
        const sign = Math.sign(acc);
        acc = Math.abs(acc);

        const offset = sign * Math.floor(acc / 120);
        scrollAccumulator = sign * (acc % 120);

        if (offset) {
            const currentWorkspace = root.activeWorkspace;
            const targetWorkspace = currentWorkspace + offset;
            const id = Math.max(baseWorkspace, Math.min(baseWorkspace + shownWorkspaces - 1, targetWorkspace));
            if (id != currentWorkspace)
                Hyprland.dispatch(`hl.dsp.focus({workspace = ${id}})`);
        }
    }

    Row {
        spacing: 7

        Repeater {
            id: repeater

            model: ScriptModel {
                objectProp: "index"
                values: {
                    const workspaces = Hyprland.workspaces.values;
                    const base = root.baseWorkspace;
                    return Array.from({
                        length: root.shownWorkspaces
                    }, (_, i) => ({
                                index: base + i,
                                workspace: workspaces.find(w => w.id == base + i)
                            }));
                }
            }

            Workspace {}
        }
    }
}
