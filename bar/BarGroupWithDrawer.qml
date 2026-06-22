import QtQuick
import qs.parts

MouseArea {

    id: root
    property alias barGroup: barGroup.data
    property alias drawerGroup: drawer.content

    onClicked: {
        drawer.show = true
    }

    Item {
        id: barGroup
    }

    Drawer {
        id: drawer
        // TODO
        xPos: 50
    }
}
