//
//  RAMGaugePlugin.swift
//  BetterSystemGaugesRam
//
//  Created by tht7 on 12/10/2022.
//

import Foundation

@objc class CpuGaugePlugin: NSObject, BTTStreamDeckPluginInterface {
    let cpuUsageMonitor = MyCpuUsageMonitor()
    
    var delegate : BTTStreamDeckPluginDelegate?
    var image: [NSImage]?
    
    var fractionalAccuracy = 1
    
    override init() {
        super.init()
        cpuUsageMonitor.startMonitoring(self.updateRamGauge)
    }
    
    
    func didReceiveNewConfigurationValues(_ configurationValues: [AnyHashable : Any]) {
        let interval = configurationValues["plugin_var_interval"] as? Double ?? 3.0
        self.fractionalAccuracy = configurationValues["plugin_var_fractional"] as? Int ?? 1
        cpuUsageMonitor.updateInterval(interval)
        self.delegate?.requestUpdate(self)
    }
    
    func updateRamGauge(_ cpuUsed: Double) {
        let displayString = (cpuUsed/100).formatted(.percent.rounded().precision(.fractionLength(self.fractionalAccuracy)))
        let view = SwiftUIView(gaugeName: "CPU", rawPrecent: cpuUsed, formattedNumber: displayString)
        guard let image = view.renderAsImage() else { return }
        self.image = [image]
        self.delegate?.requestUpdate(self)
    }
    
    // here you can configure what items are shown in the BTT configuration side-bar for this plugin
    class func configurationFormItems() -> BTTPluginFormItem? {

        let groupItem = BTTPluginFormItem.init();
        groupItem.formFieldType = BTTFormTypeFormGroup;

        // add a bold title label
        let titleField = BTTPluginFormItem.init();
        titleField.formFieldType = BTTFormTypeTitleField;
        titleField.formLabel1 = "CPU Load Widget";

        let intervalField = BTTPluginFormItem.init();
        intervalField.formFieldID = "plugin_var_interval";
        intervalField.formFieldType = BTTFormTypeTextField;
        intervalField.dataType = BTTFormDataNumber;
        intervalField.formLabel1 = "Refresh Interval (in seconds)";
        intervalField.minValue = 1;
        intervalField.defaultValue = 3;
        
        let accuracyField = BTTPluginFormItem.init();
        accuracyField.formFieldID = "plugin_var_fractional";
        accuracyField.formFieldType = BTTFormTypeTextField;
        accuracyField.dataType = BTTFormDataNumber;
        accuracyField.formLabel1 = "The Fractional Accuracy\n(How many numbers to display after the dot)";
        accuracyField.minValue = 0;
        accuracyField.defaultValue = 1;
        
        groupItem.formOptions = [titleField, intervalField, accuracyField];

        return groupItem;
    }
    
    
    func buttonUp(_ identifier: Int) -> Bool {
        return false
    }
    
    func buttonDown(_ identifier: String?) -> Bool {
        return false
    }
    
    
    func widgetImages() -> [NSImage]? {
        return image
    }
    
}
