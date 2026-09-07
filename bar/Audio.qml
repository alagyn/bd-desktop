import QtQuick
import org.kde.kirigami
import Quickshell
import Quickshell.Services.Pipewire
import qs

BarGroup {
    id: root
    Icon {
        anchors.centerIn: parent
        implicitHeight: Config.barIconSize
        implicitWidth: Config.barIconSize

        source: {
            Pipewire.defaultAudioSink?.audio.muted ?
                Quickshell.iconPath("audio-volume-muted") :
                Quickshell.iconPath("audio-volume-high-symbolic")
        }
    }
}
