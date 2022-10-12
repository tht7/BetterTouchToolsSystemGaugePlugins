//
//  RAMGaugePlugin.swift
//  BetterSystemGaugesRam
//
//  Created by tht7 on 12/10/2022.
//

import Foundation

@objc class RamGaugePlugin: NSObject, BTTStreamDeckPluginInterface {
    let ramUsageMonitor = MyRamUsageMonitor()
    
    var delegate : BTTStreamDeckPluginDelegate?
    var fractionalAccuracy = 1
    var image: [NSImage]?
    
    override init() {
        super.init()
        ramUsageMonitor.startMonitoring(self.updateRamGauge)
    }
    
    
    func didReceiveNewConfigurationValues(_ configurationValues: [AnyHashable : Any]) {
        let interval = configurationValues["plugin_var_interval"] as? Double ?? 1.0
        self.fractionalAccuracy = configurationValues["plugin_var_fractional"] as? Int ?? 1
        ramUsageMonitor.updateInterval(interval)
        self.delegate?.requestUpdate(self)
    }
    
    func updateRamGauge(_ ramUsed: RAMUsage) {
        let precent = (100 / ramUsed.physicalMemory) * self.toMB(ramUsed.used)
        let displayString = (precent/100).formatted(.percent.rounded().precision(.fractionLength(self.fractionalAccuracy)))
        let view = SwiftUIView(gaugeName: "RAM", rawPrecent: precent, formattedNumber: displayString)
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
        titleField.formLabel1 = "RAM Load Widget";

        // add a bold title label
        let intervalField = BTTPluginFormItem.init();
        intervalField.formFieldID = "plugin_var_interval";
        intervalField.formFieldType = BTTFormTypeTextField;
        intervalField.dataType = BTTFormDataNumber;
        intervalField.formLabel1 = "Refresh Interval (in seconds)";
        intervalField.minValue = 0.01;
        intervalField.defaultValue = 1;
        
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
    
    // this will tell BTT to execute the actions the user assigned to this widget
    @objc func executeAssignedBTTActions() {
        self.delegate?.executeAssignedBTTActions(self);
    }
    
    
    func widgetImages() -> [NSImage]? {
        return image
    }
    
    
    func toMB(_ value: Double) -> Double {
        if value < 1.0 { return value; }
        else           { return value * 1000.0; }
    }
}
