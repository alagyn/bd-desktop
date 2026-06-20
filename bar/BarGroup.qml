import QtQuick

import qs

Rectangle {
    id: root
    default property alias contentItem: contentItem.data

    color: Colors.bgSecondary
    radius: Config.barGroupRadius

    implicitWidth: contentItem.implicitWidth 
    implicitHeight: 30
    Item {
        id: contentItem
        // anchors.fill: parent
        anchors.centerIn: parent
    }
}
