//
//  ChoiceViewController.swift
//  TotoRan
//
//  Created by kosou.tei on 2021/05/20.
//

import UIKit
import Domain // Modelを画面間でやりとりに使用（本来はTransition専用DOを用意すべき）

enum ChoiceViewAlertReason: String {
    case dataGetFailed = "データの取得に失敗しました。"
    case combinationOver = "合計486口を超える組み合わせは選択できません。"
}

class ChoiceViewControllerFactory {
    static func create() -> ChoiceViewController {
        let vc: ChoiceViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ChoiceViewController")
        vc.presenter = PresenterBuilder().createChoiceViewPresenter(view: vc)
        return vc
    }
}

protocol ChoiceViewable: NSObjectProtocol {
    func setTeamNames(tableViewData: ChoiceTableViewData)
    func setTableView()
    func transitionNextVC(choiceDataModel: ChoiceDataModel)
    func showAlert(reason: ChoiceViewAlertReason)
}

class ChoiceViewController: UIViewController, ChoiceViewable {

    @IBOutlet weak var tableView: UITableView!
    fileprivate var presenter: ChoiceViewPresentable?
    private var tableViewData: ChoiceTableViewData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.didLoad()
    }
    
    func setTeamNames(tableViewData: ChoiceTableViewData) {
        self.tableViewData = tableViewData
        self.tableView.reloadData()
    }
    
    func setTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 50
    }
    
    func transitionNextVC(choiceDataModel: ChoiceDataModel) {
        let vc = MultiChoiceSettingViewControllerFactory.create(choiceDataModel: choiceDataModel)
        self.present(vc, animated: true, completion: nil)
    }
    
    func showAlert(reason: ChoiceViewAlertReason) {
        let alert: UIAlertController = UIAlertController(title: nil, message: reason.rawValue, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "閉じる", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension ChoiceViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableViewData?.cellCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let viewData = self.tableViewData?.get(index: indexPath.row) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChoiceViewCell") as! ChoiceViewCell
            cell.setUp(viewData: viewData, delegate: self)
            return cell
        }
        
        if let count = self.tableViewData?.cellCount() {
            if indexPath.row == count - 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ClearChoiceViewCell") as! ClearChoiceViewCell
                cell.setUp(delegate: self)
                return cell
            }
            if indexPath.row == count - 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "TransitionButtonViewCell") as! TransitionButtonViewCell
                cell.setUp(delegate: self)
                return cell
            }
            if indexPath.row == count - 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "CloseButtonViewCell") as! CloseButtonViewCell
                cell.setUp(delegate: self)
                return cell
            }
        }
            
        return UITableViewCell()
    }
}

extension ChoiceViewController: ChoiceViewCellDelegate {
    func setSelectedHome(id: Int, selected: Bool) {
        self.tableViewData?.setSelectedHome(id: id, selected: selected)
        self.tableView.reloadData() // 該当のCellだけ更新したい！！！！！！！！！
    }
    
    func setSelectedAway(id: Int, selected: Bool) {
        self.tableViewData?.setSelectedAway(id: id, selected: selected)
        self.tableView.reloadData() // 該当のCellだけ更新したい！！！！！！！！！
    }
    
    func setSelectedDraw(id: Int, selected: Bool) {
        self.tableViewData?.setSelectedDraw(id: id, selected: selected)
        self.tableView.reloadData() // 該当のCellだけ更新したい！！！！！！！！！
    }
}

extension ChoiceViewController: ClearChoiceViewCellDelegate {
    func clear() {
        self.tableViewData?.clear()
        self.tableView.reloadData()
    }
}

extension ChoiceViewController: TransitionButtonViewCellDelegate {
    func next()  {
        self.presenter?.checkedSelectedData(tableViewData: self.tableViewData)
    }
}

extension ChoiceViewController: CloseButtonViewCellDelegate {
    func close()  {
        self.dismiss(animated: true, completion: nil)
    }
}
