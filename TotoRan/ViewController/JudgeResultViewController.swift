//
//  JudgeResultViewController.swift
//  TotoRan
//
//  Created by kosou.tei on 2021/06/01.
//
import UIKit
import Domain // Modelを画面間でやりとりに使用（本来はTransition専用DOを用意すべき）

class JudgeResultViewControllerFactory {
    static func create(choiceDataList: [ChoiceData]) -> JudgeResultViewController {
        let vc: JudgeResultViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "JudgeResultViewController")
        vc.presenter = PresenterBuilder().createJudgeResultViewPresenter(view: vc, choiceDataList: choiceDataList)
        return vc
    }
}

protocol JudgeResultViewable: NSObjectProtocol {
    func setUp()
    func dsiplayJedgeData(text: String)
}

class JudgeResultViewController: UIViewController, JudgeResultViewable {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var closeButton: UIButton!
    fileprivate var presenter: JudgeResultViewPresentable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.didLoad()
    }
    
    func setUp() {
        self.closeButton.setTitle("閉じる", for: .normal)
        
        if #available(iOS 14.0, *) {
            self.closeButton.addAction(.init { _ in self.dismiss(animated: true, completion: nil) }, for: .touchUpInside)
        }
    }
    
    func dsiplayJedgeData(text: String) {
        self.textView.text = text
    }
}
