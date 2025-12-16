pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
  id: root
  property int base_packages
  property int aur_packages
  property int totalPackages

  Process {
    id: base_packages_check
    command: ["sh", "-c", "checkupdates 2>/dev/null | wc -l"]
    running: true

    stdout: StdioCollector {
      onStreamFinished: root.base_packages = parseInt(this.text)
    }
  }

  Process {
    id: aur_packages_check
    command: ["sh", "-c", "yay -Qua 2>/dev/null | wc -l"]
    running: true

    stdout: StdioCollector {
      onStreamFinished: root.aur_packages = parseInt(this.text)
    }
  }

  Timer {
    interval: 1000
    running: true
    repeat: true
    onTriggered: {
      base_packages_check.running = true
      aur_packages_check.running = true
      totalPackages = root.base_packages + root.aur_packages
    }
  }
}
