//
//  MyCpuUsage.swift
//  BTTStreamDeckPluginCPUUsage


import Foundation
import SystemKit


class MyCpuUsageMonitor {
    var updateTimer: Timer?
    let stateLock: NSLock = NSLock()
    var callback: ((Double) -> Swift.Void)?
    var system = System()
    
    private var interval: Double = 3
    
    func updateInterval(_ newInterval: Double) {
        self.interval = newInterval
        guard let updateTimer = updateTimer else { return }
        updateTimer.invalidate()
        guard let callback = callback else { return }
        startMonitoring(callback)
        
    }
    
    func startMonitoring(_ loadBlock: @escaping ((Double) -> Swift.Void)) {
        updateTimer = Timer.scheduledTimer(timeInterval: self.interval, target: self, selector: #selector(updateInfo), userInfo: nil, repeats: true)
        callback = loadBlock
    }

    @objc func updateInfo(_ timer: Timer) {
        stateLock.lock()
        let cpuVal = system.usageCPU()
        
        stateLock.unlock()
        callback?(cpuVal.user + cpuVal.system + cpuVal.nice)
    }
}
