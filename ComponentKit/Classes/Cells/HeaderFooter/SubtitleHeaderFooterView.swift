import UIKit
import SnapKit

open class SubtitleHeaderFooterView: UITableViewHeaderFooterView {
    public let wrapperView = UIView()
    public let label = UILabel()

    override public init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addSubview(wrapperView)
        wrapperView.addSubview(label)
        wrapperView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        label.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview().inset(CGFloat.margin4x)
            maker.bottom.equalToSuperview().inset(CGFloat.margin2x)
        }

        label.font = .subhead1
        label.textColor = .themeGray
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open func bind(text: String?) {
        label.text = text
    }

}

extension SubtitleHeaderFooterView {
    public static let height: CGFloat = 32
}
