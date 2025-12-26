pragma Singleton

import Quickshell
import Quickshell.Io
import Quickshell.Services.UPower
import QtQuick

Singleton {
    id: root

    property var battery: {
        for(var i = 0; i < UPower.devices.values.length; i++) {
            var device = UPower.devices.values[i]
            if(device.isLaptopBattery){
                return device
            }
        }
        return null
    }

    property var isLaptop: {
        if(battery){
            return true
        }
        return false
    }

    property var batteryPercentage: {
        if(battery){
            return Math.round(battery.percentage * 100)
        }
        else{
            return -1
        }
    }

    property var batteryIcon: "\udb80\udc7a"

    function updateIcon(){
        if(battery){
            if(battery.timeToFull > 0){
                batteryIcon = "\udb80\udc84"
            }
            else if(batteryPercentage >= 90){
                batteryIcon = "\udb80\udc79"
            }
            else if(batteryPercentage >= 80){
                batteryIcon = "\udb80\udc82"
            }
            else if(batteryPercentage >= 70){
                batteryIcon = "\udb80\udc81"
            }
            else if(batteryPercentage >= 60){
                batteryIcon = "\udb80\udc80"
            }
            else if(batteryPercentage >= 50){
                batteryIcon = "\udb80\udc7f"
            }
            else if(batteryPercentage >= 40){
                batteryIcon = "\udb80\udc7e"
            }
            else if(batteryPercentage >= 30){
                batteryIcon = "\udb80\udc7d"
            }
            else if(batteryPercentage >= 20){
                batteryIcon = "\udb80\udc7c"
            }
            else if(batteryPercentage >= 10){
                batteryIcon = "\udb80\udc7b"
            }
            else{
                batteryIcon = "\udb80\udc7a"
            }
        }
    }

    Timer {
        interval: 100
        running: true
        repeat: true
        onTriggered: {
            updateIcon()
        }
    }

    
}