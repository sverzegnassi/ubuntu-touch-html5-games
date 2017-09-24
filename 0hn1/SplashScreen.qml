import QtQuick 2.4
import Ubuntu.Components 1.3
import QtGraphicalEffects 1.0

Rectangle {
    id: rootItem

    property int loadProgress

    color: "#222222"

    Image {
        id: img
        anchors.centerIn: parent
        width: units.gu(16); height: width
        fillMode: Image.PreserveAspectFit

        source: Qt.resolvedUrl("logo.png")
        sourceSize: Qt.size(width, height)

        smooth: true
        visible: false
    }

    Desaturate {
        anchors.fill: img
        source: img
        desaturation: loadProgress / 100
    }
}


