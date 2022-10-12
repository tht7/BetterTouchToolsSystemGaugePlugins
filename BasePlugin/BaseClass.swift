//
//  BaseClass.swift
//  BTT
//
//  Created by tht7 on 12/10/2022.
//

import Foundation


@objc class BasePlugin: NSObject, BTTStreamDeckPluginInterface {
    override init() {
        super.init()
    }
    func widgetTitleStrings() -> [String]? {
        return ["poo"]
    }
    
    func didReceiveNewConfigurationValues(_ configurationValues: [AnyHashable : Any]) {
        //let widgetName = configurationValues["plugin_var_widgetName"]
        //let checkboxValue = configurationValues["plugin_var_someCheckboxValue"]
    }
    
    
    func buttonUp(_ identifier: Int) -> Bool {
        return false
    }
    
    func buttonDown(_ identifier: String?) -> Bool {
        return false
    }
}
