//
//  RateChartViewController.swift
//  TotoRan
//  支持率確認画面
//
//  Created by kosou.tei on 2021/05/18.
//

import UIKit

enum RateChartViewAlertReason: String {
    case dataGetFailed = "データの取得に失敗しました。"
    case notBookRate = "bookのデータはまだありません"
}

class RateChartViewControllerFactory {
    static func create() -> RateChartViewController {
        let vc: RateChartViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "RateChartViewController")
        vc.presenter = PresenterBuilder().createRateChartViewPresenter(view: vc)
        return vc
    }
}

protocol RateChartViewable: NSObjectProtocol {
    func setUp()
    func load(text: String)
    func showAlert(reason: RateChartViewAlertReason)
}

class RateChartViewController: UIViewController, RateChartViewable {
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var tmpLabel: UILabel!
    @IBOutlet weak var totoOrBookControl: UISegmentedControl!
    
    var presenter: RateChartViewPresentable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.didLoad()
    }
    
    func setUp() {
        if #available(iOS 14.0, *) { 
            self.closeButton.addAction(.init { _ in self.dismiss(animated: true, completion: nil) }, for: .touchUpInside)
        }
        self.totoOrBookControl.addTarget(self, action: #selector(onTapSegmentedControll), for: .valueChanged)
    }
    
    func load(text: String) {
        self.tmpLabel.text = text
    }
    
    func showAlert(reason: RateChartViewAlertReason) {
        let alert: UIAlertController = UIAlertController(title: nil, message:  reason.rawValue, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "閉じる", style: .default, handler: { [weak self] _ in self?.dismiss(animated: true, completion: nil) }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc private func onTapSegmentedControll(controll: UISegmentedControl) {
        self.presenter?.onTapSegmentedControll(index: controll.selectedSegmentIndex)
    }
}
