import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.singletons

RowLayout {
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
