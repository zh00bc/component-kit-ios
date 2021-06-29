//
//  CustomTwoButton.swift
//  ComponentKit.swift
//
//  Created by 林炳淋 on 2021/6/29.
//

import UIKit

public enum TwoButtonStyle {
    case horizontal
    case vertical
    
}

public class CustomTwoButton: UIView {

    public let screenWith = UIScreen.main.bounds.width
    public var firstButton = ThemeButton()
    public var secondButton = ThemeButton()
    public var insetMargin:Float = 16
    private var style: TwoButtonStyle?
    public var onSelect: ((Int) -> ())?
    
    public init(){
        super.init(frame: CGRect(x: 0, y: 0, width: screenWith, height: 80))
        self.firstButton.apply(style: .mainSureBtn)
        self.firstButton.tag = 1001
        self.firstButton.addTarget(self, action: #selector(touchBtn(button:)), for: .touchUpInside)
        self.addSubview(self.firstButton)
        
        self.secondButton.apply(style: .newGray)
        self.secondButton.tag = 1002
        self.secondButton.addTarget(self, action: #selector(touchBtn(button:)), for: .touchUpInside)
        self.addSubview(self.secondButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func touchBtn(button:UIButton) {
        
        onSelect?(button.tag)
    }
    
}

extension CustomTwoButton{
    @discardableResult public func apply(style:TwoButtonStyle?) -> Self{
        self.style = style
        switch style {
        case .horizontal:
            self.firstButton.apply(style: .newGray)
            self.secondButton.apply(style: .mainSureBtn)
            let buttonWidth = (screenWith - CGFloat(insetMargin)*3)/2
            
            self.firstButton.snp.makeConstraints { maker in
                maker.leading.equalToSuperview().inset(insetMargin)
                maker.top.bottom.equalToSuperview()
                maker.width.equalTo(buttonWidth)
            }
            
            self.secondButton.snp.makeConstraints { maker in
                maker.trailing.equalToSuperview().inset(insetMargin)
                maker.top.bottom.equalToSuperview()
                maker.width.equalTo(buttonWidth)
            }
        case .vertical:
            self.firstButton.apply(style: .mainSureBtn)
            self.secondButton.apply(style: .newGray)
            self.firstButton.snp.makeConstraints { maker in
                maker.leading.equalToSuperview().inset(insetMargin)
                maker.trailing.equalToSuperview().inset(insetMargin)
                maker.top.equalToSuperview()
                maker.height.equalTo(44)
            }
            
            self.secondButton.snp.makeConstraints { maker in
                maker.leading.equalToSuperview().inset(insetMargin)
                maker.trailing.equalToSuperview().inset(insetMargin)
                maker.bottom.equalToSuperview()
                maker.height.equalTo(44)
            }
        case .none: break
            
        }
        return self
    }

}
