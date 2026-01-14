pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
  id: root
  property int base_packages
  property int aur_packages

  Process {
    id: base_packages_check
    command: ["sh", "-c", "pacman -Qu 2>/dev/null | wc -l"]
    running: true

    stdout: StdioCollector {
      onStreamFinished: {
        root.base_packages = parseInt(this.text)
      }
    }
  }

  Process {
    id: aur_packages_check
    command: ["sh", "-c", "yay -Qua 2>/dev/null | wc -l"]
    running: true

    stdout: StdioCollector {
      onStreamFinished: {
        root.aur_packages = parseInt(this.text)
      }
    }
  }

  Timer {
    interval: 600000
    running: true
    repeat: true
    onTriggered: {
      base_packages_check.running = true
      aur_packages_check.running = true
    }
  }

  Component.onCompleted: {
    base_packages_check.running = true
    aur_packages_check.running = true
  }
}
