import UIKit
import ThemeKit
import SnapKit
import PinKit
import StorageKit
import RxSwift
import ComponentKit

class PinController: ThemeViewController {
    private let disposeBag = DisposeBag()

    private let pinLabel = UILabel()

    private let clearPinButton = ThemeButton().apply(style: .primaryRed)
    private let setPinButton = ThemeButton()
    private let editPinButton = ThemeButton()

    private var themeModeIterator = 0
    private var themeBarButtonItem: UIBarButtonItem?
    private var mainButton = ThemeButton().apply(style: .mainSureBtn)

    override func viewDidLoad() {
        super.viewDidLoad()

        themeBarButtonItem = UIBarButtonItem(title: ThemeManager.shared.themeMode.rawValue, style: .plain, target: self, action: #selector(onToggleLightMode))
        navigationItem.rightBarButtonItem = themeBarButtonItem

        view.addSubview(pinLabel)
        pinLabel.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview().inset(CGFloat.margin4x)
            maker.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(CGFloat.margin4x)
        }
        pinLabel.font = .headline2
        pinLabel.textColor = .themeJacob
        pinLabel.textAlignment = .center

        App.shared.pinKit.isPinSetObservable
                .subscribe { isPinSet in
                    self.updateUI()
                }
                .disposed(by: disposeBag)

        view.addSubview(clearPinButton)
        view.addSubview(setPinButton)
        view.addSubview(editPinButton)

        clearPinButton.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().inset(CGFloat.margin4x)
            maker.top.equalTo(pinLabel.snp.bottom).offset(CGFloat.margin4x)
            maker.height.equalTo(CGFloat.heightButton)
        }
        setPinButton.snp.makeConstraints { maker in
            maker.leading.equalTo(clearPinButton.snp.trailing).offset(CGFloat.margin4x)
            maker.top.equalTo(pinLabel.snp.bottom).offset(CGFloat.margin4x)
            maker.width.equalTo(clearPinButton.snp.width)
            maker.height.equalTo(CGFloat.heightButton)

        }
        editPinButton.snp.makeConstraints { maker in
            maker.leading.equalTo(setPinButton.snp.trailing).offset(CGFloat.margin4x)
            maker.trailing.equalToSuperview().inset(CGFloat.margin4x)
            maker.top.equalTo(pinLabel.snp.bottom).offset(CGFloat.margin4x)
            maker.width.equalTo(clearPinButton.snp.width)
            maker.height.equalTo(CGFloat.heightButton)
        }

        clearPinButton.setTitle("Clear Pin", for: .normal)
        setPinButton.setTitle("Set Pin", for: .normal)
        setPinButton.apply(style: .primaryGreen)
        editPinButton.setTitle("Edit Pin", for: .normal)
        editPinButton.apply(style: .primaryYellow)

        clearPinButton.addTarget(self, action: #selector(onClearPin), for: .touchUpInside)
        setPinButton.addTarget(self, action: #selector(onSetPin), for: .touchUpInside)
        editPinButton.addTarget(self, action: #selector(onEditPin), for: .touchUpInside)

        updateUI()

        App.shared.pinKit.lock()

        let stabView = UIView()

        let fixedSizeView = UIView()
        stabView.addSubview(fixedSizeView)
        fixedSizeView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
            maker.width.height.equalTo(50)
        }

        let testButton = ThemeButton()

        stabView.addSubview(testButton)
        testButton.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }

        testButton.setImageTintColor(.red, for: .normal)
        testButton.setImageTintColor(.green, for: .highlighted)
        testButton.setImage(UIImage(named: "Cell Icon"), for: .normal)

        view.addSubview(stabView)
        stabView.snp.makeConstraints { maker in
            maker.leading.equalToSuperview()
            maker.top.equalTo(clearPinButton.snp.bottom).offset(CGFloat.margin32)
        }

        let primaryTestButton = ThemeButton()

        view.addSubview(primaryTestButton)
        primaryTestButton.snp.makeConstraints { maker in
            maker.top.equalTo(stabView)
            maker.leading.equalTo(stabView.snp.trailing).offset(16)
            maker.width.equalTo(100)
            maker.height.equalTo(50)
        }

        primaryTestButton.apply(style: .primaryGreen)
        primaryTestButton.setImage(UIImage(named: "arrow_swap_2_24"), for: .normal)
        
        let titleArr = ["asdafdsfdsfdfdsf","dfsgfgfd","dsad","grthrthyhrht","hjhfgjfghfg","gfdgsqeer"]
        
        let filterView = FilterScrollView.init()
        filterView.titleArr = titleArr
        view.addSubview(filterView)
        filterView.snp.makeConstraints { maker in
            maker.top.equalTo(primaryTestButton).offset(100)
            maker.leading.equalToSuperview()
            maker.trailing.equalToSuperview()
            maker.height.equalTo(40)
        }
        
        view.addSubview(mainButton)
        mainButton.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().inset(16)
            maker.top.equalTo(filterView).offset(50)
            maker.trailing.equalToSuperview().inset(16)
            maker.height.equalTo(44)
        }
        mainButton.setTitle("确认", for: .normal)
        
        let twoButton = CustomTwoButton.init()
        twoButton.apply(style: .horizontal)
        twoButton.firstButton.setTitle("取消", for: .normal)
        twoButton.secondButton.setTitle("确认", for: .normal)
        view.addSubview(twoButton)
        twoButton.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview()
            maker.top.equalTo(mainButton).offset(60)
            maker.height.equalTo(44)
        }
        
        let twoButton2 = CustomTwoButton.init()
        twoButton2.apply(style: .vertical)
        twoButton2.firstButton.setTitle("取消", for: .normal)
        twoButton2.secondButton.setTitle("确认", for: .normal)
        view.addSubview(twoButton2)
        twoButton2.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview()
            maker.top.equalTo(twoButton).offset(60)
            maker.height.equalTo(104)
        }
    }

    private func updateUI() {
        let isPinSet = App.shared.pinKit.isPinSet

        pinLabel.text = "Pin \(isPinSet ? "was set" : "not set!")"

        clearPinButton.isEnabled = isPinSet
        setPinButton.isEnabled = !isPinSet
        editPinButton.isEnabled = isPinSet
        mainButton.isEnabled = isPinSet
    }

    @objc func onToggleLightMode() {
        themeModeIterator += 1
        if themeModeIterator > 2 {
            themeModeIterator = 0
        }

        if themeModeIterator == 0 {
            ThemeManager.shared.themeMode = .system
            UIApplication.shared.windows.first(where: \.isKeyWindow)?.overrideUserInterfaceStyle = .unspecified
        }
        if themeModeIterator == 1 {
            ThemeManager.shared.themeMode = .dark
            UIApplication.shared.windows.first(where: \.isKeyWindow)?.overrideUserInterfaceStyle = .dark
        }
        if themeModeIterator == 2 {
            ThemeManager.shared.themeMode = .light
            UIApplication.shared.windows.first(where: \.isKeyWindow)?.overrideUserInterfaceStyle = .light
        }

        themeBarButtonItem?.title = ThemeManager.shared.themeMode.rawValue
    }

    @objc func onClearPin() {
        do {
            try App.shared.pinKit.clear()

            updateUI()
        } catch {
            print("Can't clear pin \(error)")
        }
    }

    @objc func onSetPin() {
        present(App.shared.pinKit.setPinModule(delegate: self), animated: true)
    }

    @objc func onEditPin() {
        present(App.shared.pinKit.editPinModule, animated: true)
    }

}

extension PinController: ISetPinDelegate {

    public func didCancelSetPin() {
        print("Cancel Set Pin!")
    }

}
