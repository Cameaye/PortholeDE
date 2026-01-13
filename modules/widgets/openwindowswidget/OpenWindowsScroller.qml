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

    model: WindowManager.windowKeys
    boundsBehavior: Flickable.StopAtBounds
    delegate: WindowButton {
        required property string modelData
        property var windowInfo: WindowManager.openWindows[modelData]
    }

    // WindowPopupView {
    //     id: windowPopup
    // }
}