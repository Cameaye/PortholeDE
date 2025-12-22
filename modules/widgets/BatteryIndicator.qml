import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.singletons

Button{
  id: batteryButton

  implicitHeight: parent.height

  background: Rectangle {
    color: batteryButton.hovered ? Themes.primaryHoverColor : "transparent"
    radius: 5
  }
  contentItem: RowLayout {
    spacing: 5
    Text {
      text: PowerManager.batteryIcon
      color: Themes.textColor

      font.family: Themes.textFont
      font.pixelSize: 20
    }
    Text {
      text: PowerManager.batteryPercentage
      color: Themes.textColor
      
      font.family: Themes.textFont
      font.pixelSize: 12
    }
  }

  onClicked: {
  }
}
