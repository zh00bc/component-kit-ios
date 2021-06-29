import UIKit
import ThemeKit
import SnapKit

class FontsController: ThemeViewController {

    private let fonts: [Font] = [
        Font(name: "textFont_12_semibold", value: .textFont_12_semibold),
        Font(name: "textFont_12_regular", value: .textFont_12_regular),
        Font(name: "textFont_14_semibold", value: .textFont_14_semibold),
        Font(name: "textFont_14_regular", value: .textFont_14_regular),
        Font(name: "textFont_16_semibold", value: .textFont_16_semibold),
        Font(name: "textFont_16_regular", value: .textFont_16_regular),
        Font(name: "textFont_18_semibold", value: .textFont_18_semibold),
        Font(name: "textFont_18_regular", value: .textFont_18_regular),
        Font(name: "textFont_22_semibold", value: .textFont_22_semibold),
        Font(name: "textFont_22_regular", value: .textFont_22_regular),
        Font(name: "textFont_28_semibold", value: .textFont_28_semibold),
        Font(name: "textFont_28_regular", value: .textFont_28_regular),
    ]

    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        tableView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FontCell.self, forCellReuseIdentifier: String(describing: FontCell.self))

        tableView.backgroundColor = .clear
        tableView.separatorInset = .zero
        tableView.separatorColor = .themeSteel20
        tableView.allowsSelection = false
        tableView.tableFooterView = UIView()
    }

}

extension FontsController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fonts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FontCell.self)) {
            return cell
        }

        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? FontCell else {
            return
        }

        cell.bind(font: fonts[indexPath.row])
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }

}

extension FontsController {

    struct Font {
        let name: String
        let value: UIFont
    }

}
