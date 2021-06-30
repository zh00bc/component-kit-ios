//
//  CommonSize.swift
//  ComponentKit.swift
//
//  Created by 林炳淋 on 2021/6/30.
//

import UIKit
import DeviceKit

extension Device {
    var hasFaceId: Bool {
        return isFaceIDCapable || Device.current == .simulator(.iPhoneX) || Device.current == Device.simulator(.iPhoneXR) || Device.current == .simulator(.iPhoneXS) || Device.current == .simulator(.iPhoneXSMax)
    }
    
    static func language() -> String {
        return Bundle.main.preferredLocalizations.first!
    }
    
    static func languageId() -> Int {
        if language().contains("zh") {
            return 1
        }
        return 2
    }
}

class DeviceBridge: NSObject {
    @objc static func hasFaceId() -> Bool {
        return Device.current.hasFaceId
    }
}
