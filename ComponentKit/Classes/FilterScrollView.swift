//
//  FilterScrollView.swift
//  ComponentKit.swift
//
//  Created by 林炳淋 on 2021/6/28.
//

import UIKit

public class FilterScrollView: UIScrollView {
    public let screenWith = UIScreen.main.bounds.width
    
    public var titleArr : [String]{
        didSet{
            if titleArr.count > 0 {
                var contentSizeW:Float = 16
                for i in 0..<titleArr.count {
                    let button = ThemeButton()
                    let btnStr = titleArr[i]
                    let btnWidth = countTextSize(textStr: btnStr).width
                    contentSizeWArr.append(contentSizeW)
                    button.frame = CGRect(x: CGFloat(contentSizeW), y: 0, width: btnWidth, height: 40)
                    contentSizeW = contentSizeW + Float(btnWidth) + 30
                    button.setTitle(btnStr, for: .normal)
                    button.setTitleColor(.newGrayColor, for: .normal)
                    button.titleLabel?.font = .textFont_14_regular
                    button.tag = i+100
                    button.addTarget(self, action: #selector(touchFilterBtn(button:)), for: .touchUpInside)
                    self.addSubview(button)
                    self.buttonArr.append(button)
                    if i == 0 {
                        button.setTitleColor(.mainColor, for: .normal)
                        self.indicatorLine.frame = CGRect(x: 16, y: 39, width: btnWidth, height: 1)
                        self.indicatorLine.backgroundColor = .mainColor
                        self.addSubview(indicatorLine)
                    }
                }
                if CGFloat(contentSizeW) > self.screenWith {
                    self.contentSize = CGSize(width: CGFloat(contentSizeW - 14), height: 40)
                }else{
                    self.contentSize = CGSize(width: screenWith, height: 40)
                }
                self.layoutIfNeeded()
            }
            
        }
    }
    
    @objc func touchFilterBtn(button:UIButton) {
        self.buttonArr.forEach { btn in
            if btn.tag == button.tag{
                btn .setTitleColor(.mainColor, for: .normal)
                let  contentSizeW = contentSizeWArr[button.tag - 100]
                let btnWidth = countTextSize(textStr: btn.titleLabel?.text ?? "").width
                UIView.animate(withDuration: 0.1) {
                    self.indicatorLine.frame = CGRect(x: CGFloat(contentSizeW), y: 39, width: btnWidth, height: 1)
                    self.layoutIfNeeded()
                }
                
            }else{
                btn.setTitleColor(.newGrayColor, for: .normal)
            }
        }
        onSelect?(button.tag - 100)
    }
    
    public var indicatorLine = UIView()
    public var buttonArr = [ThemeButton()]
    public var contentSizeWArr = [Float]()
    public var onSelect: ((Int) -> ())?
    
    public init() {
        self.titleArr = []
        super.init(frame: CGRect(x: 0, y: 0, width: self.screenWith, height: 40))

        self.bounces = false
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        
        isOpaque = false
        backgroundColor = .clear
        borderColor = .clear
        
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func countTextSize(textStr:String) -> CGRect{
        let string:String = textStr
        let font:UIFont! = .textFont_14_regular
        let attributes = [NSAttributedString.Key.font:font]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let rect:CGRect = string.boundingRect(with: CGSize(width: 375, height: 40), options: option, attributes: attributes as [NSAttributedString.Key : Any], context: nil)
        return rect
    }
    
}
