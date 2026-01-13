pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Hyprland

Singleton {
    id: root

    property ListModel openWindows: ListModel {}
    
    Component.onCompleted: {
        updateTimer.restart()
    }

    Connections {
        target: Hyprland.toplevels
        function onValuesChanged() {
            updateTimer.restart()
        }
    }

    Timer {
        id: updateTimer
        interval: 1000
        onTriggered: {
            updateOpenWindows()
        }
    }

    // Create custom window dict to return(We use function to keep binding to Hyprland toplevel values)
    function updateOpenWindows(){
        openWindows.clear()
        var groupedWindows = {}

        Hyprland.toplevels.values.filter(w => w.wayland).forEach(w => {
            var appId = w.wayland.appId
            var application = DesktopEntries.heuristicLookup(appId)

            // Check if we found something with the heuristic look up and if not check if its  chrome webapp
            if(!application){
                if(appId.includes("chrome")){
                    application = DesktopEntries.heuristicLookup("chromium")
                }
            }
            
            // We attempt to get the icon path here as not all appIds corrospond to applicaitons, so we want to make sure some icon is displayed
            var iconPath = getIcon(appId, application)

            if(!groupedWindows[appId]){
                groupedWindows[appId] = {
                    id: String(appId), // The wayland app id of the window
                    title: String(w.title),
                    minimized: Boolean((w.workspace.id == -99)),
                    addresses: {addresses: [w.address]},
                    // application: application, // The application associated with this window if any
                    iconPath: String(iconPath) // The icon path for the window
                }
                
            }
            else {
                groupedWindows.addresses.addresses.push(w.address)
            }
        })

        Object.values(groupedWindows).forEach(win => {
            openWindows.append(win)  // Arrays get converted here, but we're done modifying
        })
    }

    function getIcon(appId, application) {
        var iconPath = ""
        if(application){
            iconPath = Quickshell.iconPath(application.icon, true)
        }
        else {
            iconPath = Quickshell.iconPath(appId, true)
        }

        if(iconPath == ""){
            if(appId.includes("steam")){
                iconPath = Quickshell.iconPath(appId.replace("app", "icon"), true)
            }
            
            if(iconPath == ""){
                iconPath = Quickshell.iconPath(findIconFallback(appId), true)
            }

            if(iconPath == ""){
                iconPath = Quickshell.iconPath("application-default-icon", true)
            }
        }

        return iconPath
    }

    function findIconFallback(appId){
        // 2. Convert to lowercase for case-insensitive matching
        let searchId = appId.toLowerCase();
        
        // 3. Remove version numbers and common suffixes
        // Match patterns like "1.21.1", "v2.0", etc.
        searchId = searchId.replace(/[_\s-]*(v?\d+\.)*\d+(\.\d+)*[_\s-]*/g, '');
        
        // 4. Remove common special characters and cleanup
        searchId = searchId.replace(/[*&$@#!()[\]{}]/g, '');
        
        // 5. Remove common suffixes
        searchId = searchId.replace(/[_\s-]*(beta|alpha|stable|dev|nightly|git)$/i, '');
        
        // 6. Split on common separators and take first significant part
        let parts = searchId.split(/[_\s-]+/);
        searchId = parts[0] || searchId;
        
        // 7. Try to find icon with this cleaned name
        return searchId;
    }
}