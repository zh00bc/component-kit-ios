import UIKit
import SnapKit
import SkeletonView

open class BaseThemeCell: UITableViewCell {
    public static let leftInset: CGFloat = .margin16
    public static let rightInset: CGFloat = .margin16
    public static let middleInset: CGFloat = .margin16

    public let wrapperView = UIView()

    public let topSeparatorView = UIView()
    public let bottomSeparatorView = UIView()

    public var isVisible = true

    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        isSkeletonable = true

        backgroundColor = .clear
        contentView.backgroundColor = .clear
        separatorInset.left = 0
        selectionStyle = .none
        clipsToBounds = true

        contentView.addSubview(wrapperView)
        wrapperView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }

        wrapperView.clipsToBounds = true
        wrapperView.isSkeletonable = true

        wrapperView.addSubview(topSeparatorView)
        topSeparatorView.snp.makeConstraints { maker in
            maker.top.trailing.equalToSuperview()
            maker.leading.equalToSuperview().offset(CGFloat.margin12)
            maker.height.equalTo(0)
        }

        topSeparatorView.backgroundColor = .themeSteel10

        wrapperView.addSubview(bottomSeparatorView)
        bottomSeparatorView.snp.makeConstraints { maker in
            maker.bottom.trailing.equalToSuperview()
            maker.leading.equalToSuperview().offset(CGFloat.margin12)
            maker.height.equalTo(0)
        }

        bottomSeparatorView.backgroundColor = .themeSteel10
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open var cellHeight: CGFloat {
        isVisible ? .heightSingleLineCell : 0
    }

    open func set(backgroundStyle: BackgroundStyle, isFirst: Bool = false, isLast: Bool = false) {
        let topSeparator: Bool
        let bottomSeparator: Bool
        var maskedCorners: CACornerMask = []
        var cornerRadius: CGFloat = 0

        switch backgroundStyle {
        case .lawrence:
            wrapperView.backgroundColor = .white
            topSeparator = !isFirst
            bottomSeparator = false

            if isFirst || isLast {
                cornerRadius = .cornerRadius12
            }
            if isFirst {
                maskedCorners.insert(.layerMinXMinYCorner)
                maskedCorners.insert(.layerMaxXMinYCorner)
            }
            if isLast {
                maskedCorners.insert(.layerMinXMaxYCorner)
                maskedCorners.insert(.layerMaxXMaxYCorner)
            }
        case .claude:
            wrapperView.backgroundColor = .themeClaude
            topSeparator = !isFirst
            bottomSeparator = isLast
        case .transparent:
            wrapperView.backgroundColor = .clear
            topSeparator = !isFirst
            bottomSeparator = isLast
        }

        wrapperView.snp.remakeConstraints { maker in
            maker.edges.equalToSuperview().inset(Self.margin(backgroundStyle: backgroundStyle))
        }
        wrapperView.layer.cornerRadius = cornerRadius
        wrapperView.layer.maskedCorners = maskedCorners

        topSeparatorView.snp.updateConstraints { maker in
            maker.height.equalTo(topSeparator ? 0.5 : 0)
        }

        bottomSeparatorView.snp.updateConstraints { maker in
            maker.height.equalTo(bottomSeparator ? 0.5 : 0)
        }
    }

    public func layout(leftView: UIView, leftInset: CGFloat = BaseThemeCell.leftInset, rightView: UIView, rightInset: CGFloat = BaseThemeCell.rightInset, middleInset: CGFloat = BaseThemeCell.middleInset) {
        wrapperView.addSubview(leftView)
        leftView.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().inset(leftInset)
            maker.top.bottom.equalToSuperview()
        }

        wrapperView.addSubview(rightView)
        rightView.snp.makeConstraints { maker in
            maker.leading.equalTo(leftView.snp.trailing).offset(middleInset)
            maker.trailing.equalToSuperview().inset(rightInset)
            maker.top.bottom.equalToSuperview()
        }
    }

    public func layout(singleView: UIView) {
        wrapperView.addSubview(singleView)
        singleView.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().inset(Self.leftInset)
            maker.trailing.equalToSuperview().inset(Self.rightInset)
            maker.top.bottom.equalToSuperview()
        }
    }

    public static func margin(backgroundStyle: BackgroundStyle) -> UIEdgeInsets {
        switch backgroundStyle {
        case .lawrence:
            return UIEdgeInsets(top: 0, left: .margin16, bottom: 0, right: .margin16)
        case .claude, .transparent:
            return UIEdgeInsets.zero
        }
    }

    public enum BackgroundStyle {
        case lawrence
        case claude
        case transparent
    }

}
