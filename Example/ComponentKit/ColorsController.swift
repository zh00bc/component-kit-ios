import UIKit
import ThemeKit
import SnapKit

class ColorsController: ThemeViewController {

    private let colors: [Color] = [
        Color(name: "mainColor", value: .mainColor),
        Color(name: "newRedColor", value: .newRedColor),
        Color(name: "newGrayColor", value: .newGrayColor),
        Color(name: "newGreenColor", value: .newGreenColor),
        Color(name: "newBlackColor", value: .newBlackColor),
        Color(name: "newYellowColor", value: .newYellowColor),
        Color(name: "mainBgColor", value: .mainBgColor),
        Color(name: "allBgColor", value: .allBgColor),
        Color(name: "newGrayColor_80 Pressed", value: .newGrayColor_80),
        Color(name: "newGrayColor_50", value: .newGrayColor_50),
        Color(name: "newGrayColor_8", value: .newGrayColor_8),
        Color(name: "newBlackColor_80", value: .newBlackColor_80),
        Color(name: "newBlackColor_10", value: .newBlackColor_10),
        Color(name: "innerBorderColor", value: .innerBorderColor),
        Color(name: "maskColor", value: .maskColor),
    ]

    private let tableView = UITableView()

    private var themeModeIterator = 0
    private var themeBarButtonItem: UIBarButtonItem?

    override func viewDidLoad() {
        super.viewDidLoad()

        themeBarButtonItem = UIBarButtonItem(title: ThemeManager.shared.themeMode.rawValue, style: .plain, target: self, action: #selector(onToggleLightMode))
        navigationItem.rightBarButtonItem = themeBarButtonItem

        view.addSubview(tableView)
        tableView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ColorCell.self, forCellReuseIdentifier: String(describing: ColorCell.self))

        tableView.backgroundColor = .clear
        tableView.separatorInset = .zero
        tableView.separatorColor = .themeSteel20
        tableView.allowsSelection = false
        tableView.tableFooterView = UIView()
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

}

extension ColorsController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        colors.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ColorCell.self)) {
            return cell
        }

        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? ColorCell else {
            return
        }

        cell.bind(color: colors[indexPath.row])
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }

}

extension ColorsController {

    struct Color {
        let name: String
        let value: UIColor
    }

}
