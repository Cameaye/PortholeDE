import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Hyprland
import qs.singletons

Button {
    id: button
    property var minimized: false

    implicitWidth: windowScroller.height
    implicitHeight: windowScroller.height

    contentItem: Image{
        source: windowInfo.iconPath
        sourceSize.width: button.width
        sourceSize.height: button.height
        fillMode: Image.PreserveAspectFit
    }

    background: Rectangle{
        color: button.hovered ? Themes.primaryHoverColor  : "transparent"
        radius: 6
    }

    onHoveredChanged: {
        // if(button.hovered){
        //     windowPopup.showWindow(button)
        // }
        // else{
        //     windowPopup.hideWindow()
        // }
    }

    onClicked: {
        var workspaceId = Hyprland.focusedWorkspace.id
        var address = windowInfo.addresses.values().next().value
        Hyprland.dispatch("movetoworkspacesilent " + workspaceId + ", address:0x" + address);
        Hyprland.toplevels.values.find(w => w.address === address).wayland.activate()
    }
}
