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

struct CommonSize {
    static let screenWidth: CGFloat = UIScreen.main.bounds.size.width
    static let screenHeight: CGFloat = UIScreen.main.bounds.size.height
    static var statusBarHeight: CGFloat {
        if Device.current.hasFaceId {
            return 44
        }
        return 20
    }
    static var topSpace: CGFloat {
        return statusBarHeight + 44
    }
    
    static var bottomSpace: CGFloat {
        if Device.current.hasFaceId {
            return 49 + bottomSafeSpace
        }
        return 49
    }
    
    static var bottomSafeSpace: CGFloat {
        if Device.current.hasFaceId {
            return 34
        }
        return 0
    }
    
    static var topSafeSpace: CGFloat {
        if Device.current.hasFaceId {
            return 44
        }
        return 0
    }
    
    static func autoFix(value: CGFloat) -> CGFloat {
        let result:CGFloat = value*screenWidth/375
        return result
    }
    
    
    static func widthSize() -> CGFloat {
        let result:CGFloat = screenWidth/375
        return result
    }
    
    static func heightSize() -> CGFloat {
        let result:CGFloat = screenHeight/667
        return result
    }

}
