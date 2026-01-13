import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import qs.singletons

Button {
    id: button
    property var minimized: false

    implicitWidth: windowScroller.height
    implicitHeight: windowScroller.height

    contentItem: Image{
        source: modelData[0].iconPath
        sourceSize.width: button.width
        sourceSize.height: button.height
        fillMode: Image.PreserveAspectFit
    }

    background: Rectangle{
        color: button.hovered ? Themes.primaryHoverColor  : "transparent"
        radius: 6
    }

    onHoveredChanged: {
        if(button.hovered){
            windowPopup.showWindow(button)
        }
        else{
            windowPopup.hideWindow()
        }
    }

    onClicked: {
        var workspaceId = Hyprland.focusedWorkspace.id
        Hyprland.dispatch("movetoworkspacesilent " + workspaceId + ", address:0x" + model.addresses.addresses[0]);
        Hyprland.toplevels.values.find(w => w.address === model.addresses.addresses[0]).wayland.activate()
    }
}
