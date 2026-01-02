pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
  id: root
  property real brightness: 1

  Process {
    id: gammaProc
    command: ["hyprctl", "hyprsunset", "gamma"]
    running: true

    stdout: StdioCollector {
      onStreamFinished: {
        root.brightness = parseInt(this.text.trim()) * .01
      }
    }
  }

  Timer {
    interval: 1000
    running: true
    repeat: true
    onTriggered: {
      gammaProc.running = true
    }
  }
}