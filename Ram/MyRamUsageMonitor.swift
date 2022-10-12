//
//  MyCpuUsage.swift
//  BTTStreamDeckPluginCPUUsage


import Foundation
import SystemKit

struct RAMUsage {
    var physicalMemory: Double
    var used: Double
}

class MyRamUsageMonitor {
    var updateTimer: Timer?
    let stateLock: NSLock = NSLock()
    var physicalMemory: Double = 0.0
    var callback: ((RAMUsage) -> Swift.Void)?
    
    private var interval: Double = 1
    
    func updateInterval(_ newInterval: Double) {
        self.interval = newInterval
        guard let updateTimer = updateTimer else { return }
        updateTimer.invalidate()
        guard let callback = callback else { return }
        startMonitoring(callback)
        
    }
    
    func startMonitoring(_ loadBlock: @escaping ((RAMUsage) -> Swift.Void)) {
        physicalMemory = System.physicalMemory(.megabyte)
        updateTimer = Timer.scheduledTimer(timeInterval: self.interval, target: self, selector: #selector(updateInfo), userInfo: nil, repeats: true)
        callback = loadBlock
    }

    @objc func updateInfo(_ timer: Timer) {
        stateLock.lock()
        let memoryUsage = System.memoryUsage()
        let used = memoryUsage.active + memoryUsage.compressed + memoryUsage.inactive  + memoryUsage.wired
        stateLock.unlock()
        callback?(RAMUsage(physicalMemory: self.physicalMemory, used: used))
    }
}
