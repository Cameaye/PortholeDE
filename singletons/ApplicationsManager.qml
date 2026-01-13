pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Hyprland

Singleton {
    id: root

    property var entries: []
    
    Component.onCompleted: {
        updateEntries()
    }
    
    Connections {
        target: DesktopEntries.applications
        function onValuesChanged() {
            updateEntries()
        }
    }
    
    // Updates desktop entries and filters by the passed string
    function updateEntries(filterString) {
        var apps = DesktopEntries.applications.values.slice()

        // Remove duplicate entries(DUplicates would get added sometimes after installing a new package)
        var seen = new Map()
        apps = apps.filter(app => {
            var key = app.id
            if(seen.has(key)) {
                return false
            }
            seen.set(key, true)
            return true
        })

        if (filterString && filterString.length > 0) {
            apps = apps.filter(app => 
                app.name.toLowerCase().includes(filterString.toLowerCase())
            )
        }

        entries = apps.sort((a, b) => a.name.localeCompare(b.name))
    }
}