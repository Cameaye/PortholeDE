import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import qs.singletons

Button {
    id: button
    required property var windows
    property var minimized: false

    implicitWidth: windowScroller.height
    implicitHeight: windowScroller.height

    contentItem: Image{
        source: windows[0].iconPath
        sourceSize.width: button.width
        sourceSize.height: button.height
        fillMode: Image.PreserveAspectFit
    }

    background: Rectangle{
        color: button.hovered ? Themes.primaryHoverColor  : "transparent"
        radius: 6
    }

    WindowPopupView{
        id: popup
    }
}
