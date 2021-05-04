//
//  InitialViewController.swift
//  TotoRan
//  初期画面
//
//  Created by kosou.tei on 2021/05/05.
//

import UIKit
import RxSwift
import NVActivityIndicatorView

enum InitialViewAlertReason: String {
    case noHeld = "現在開催中のtotoはありません。"
    case dataGetFailed = "データの取得に失敗しました。"
    case dataSaveFailed = "データの保存に失敗しました。"
}

protocol InitialViewable: NSObjectProtocol {
    func setUpOnSuccess()
    func setUpOnFailed()
    func setHeldInfo(text: String)
    func showLoadingAnimation()
    func hideLoadingAnimation()
    func showAlert(reason: InitialViewAlertReason)
    func transitionRateChartVC()
    func transitionChoiceVC()
}

class InitialViewController: UIViewController, InitialViewable {
    
    @IBOutlet weak var heldInfoLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var multiChoiceButton: UIButton!
    @IBOutlet weak var rateVerificationButton: UIButton!
    
    var presenter: InitialViewPresentable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = PresenterBuilder().createInitialViewPresenter(view: self as InitialViewable)
        presenter?.didLoad()
    }
    
    func setUpOnSuccess() {
        if #available(iOS 14.0, *) { // DeploymentTarget14.4にしてるからあり得ないだろ、コンパイラ馬鹿じゃねえの？
            self.refreshButton.addAction(.init { _ in self.presenter?.refreshData() }, for: .touchUpInside)
            self.rateVerificationButton.addAction(.init { _ in self.presenter?.transitionRateChartVC() }, for: .touchUpInside)
            self.multiChoiceButton.addAction(.init { _ in self.presenter?.transitionChoiceVC() }, for: .touchUpInside)
        }
    }
    
    func setUpOnFailed() {
        if #available(iOS 14.0, *) {
            self.refreshButton.addAction(.init { _ in self.presenter?.refreshData() }, for: .touchUpInside)
            self.rateVerificationButton.isHidden = true // データ再取得アラートを表示させてあげた方が優しいかもね！！！！！！！！！！！！！！
            self.multiChoiceButton.isHidden = true // データ再取得アラートを表示させてあげた方が優しいかもね！！！！！！！！！！！！！！
        }
    }
    
    func setHeldInfo(text: String) {
        self.heldInfoLabel.text = text
    }
    
    func showLoadingAnimation() {
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(ActivityData())
    }
    
    func hideLoadingAnimation() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
    
    func showAlert(reason: InitialViewAlertReason) {
        let alert: UIAlertController = UIAlertController(title: nil, message:  reason.rawValue, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "閉じる", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func transitionRateChartVC() {
        let vc = RateChartViewControllerFactory.create()
        self.present(vc, animated: true, completion: nil)
    }
    
    func transitionChoiceVC() {
        let vc = ChoiceViewControllerFactory.create()
        self.present(vc, animated: true, completion: nil)
    }
}

