import QtQuick
import QtQuick.Controls
import Quickshell
import qs.singletons

Button {
    id: root
    property bool menuOpen: false

    implicitWidth: 32
    implicitHeight: parent.height

    contentItem: Text {
        id: arrowIcon
        text: "\uf077"
        font.pixelSize: 16
        color: Themes.textColor
        rotation: menuOpen ? 180 : 0
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        
        Behavior on rotation {
            NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
        }
    }

    background: Rectangle {
        color: root.hovered ? Themes.primaryHoverColor : "transparent"
        radius: 6
    }

    onClicked: {
        if(menuOpen){
            trayPopup.close()
        }
        else{
            trayPopup.open()
        }
        menuOpen = !menuOpen
    }

    SystemTrayPopup{
        id: trayPopup
    }
}