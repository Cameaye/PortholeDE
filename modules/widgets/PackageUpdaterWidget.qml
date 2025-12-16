import qs.singletons
import QtQuick
import QtQuick.Controls

Button{
  id: updateButton
  visible: UpdateListener.totalPackages > 0

  implicitWidth:32
  implicitHeight:32

  background: Rectangle{
    anchors.fill: parent
    color: updateButton.hovered ? Themes.primaryHoverColor : "transparent"
    radius: 6
  }
  contentItem: Text{
    id: updateSwirly
    text: "\udb81\udeb0"
    font.pixelSize: 20
    color: Themes.textColor
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
  }

  onClicked: {}
}
