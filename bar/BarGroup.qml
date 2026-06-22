import QtQuick

import qs

Rectangle {
    id: root
    default property alias contentItem: contentItem.data

    color: Colors.bgSecondary
    radius: Config.barGroupRadius

    implicitWidth: contentItem.childrenRect.width + 15
    implicitHeight: Config.barGroupHeight

    border {
        color: "black"
        width: 1
    }
   
    Item {
        id: contentItem
        // anchors.fill: parent
        anchors.centerIn: parent
    }
}
