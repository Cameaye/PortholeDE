import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell

Item {
    id: root
    property int updateCount: 0

    implicitWidth: updateCount > 0 ? 32 : 0
    implicitHeight: 32
    visible: updateCount > 0

    Timer {
        interval: 600000    // 10 minutes
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: checkUpdates()
    }

    function checkUpdates() {
        Quickshell.exec(
            ["bash", "-c", "~/.local/bin/check-updates.sh"],
            (result) => {
                updateCount = parseInt(result.stdout.trim()) || 0
            }
        )
    }

    Rectangle {
        anchors.fill: parent
        radius: 6
        color: "#fab387"

        Text {
            anchors.centerIn: parent
            text: ""
            font.pixelSize: 16
        }

        Text {
            visible: updateCount > 0
            text: updateCount
            font.pixelSize: 9
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.margins: 2
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                Quickshell.exec(["kitty", "-e", "yay"])
            }
        }
    }
}
