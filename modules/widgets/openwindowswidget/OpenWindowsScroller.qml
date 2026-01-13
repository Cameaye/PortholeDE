import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import Quickshell.Wayland
import qs.singletons

ListView {
    id: windowScroller
    orientation: ListView.Horizontal
    model: WindowManager.openWindows
    boundsBehavior: Flickable.StopAtBounds
    delegate: WindowButton {
        property var modelData: [{
            "id": id,
            "title": title,
            "minimized": minimized,
            "addresses": addresses,
            "iconPath": iconPath
        }]
    }

    WindowPopupView {
        id: windowPopup
    }
}