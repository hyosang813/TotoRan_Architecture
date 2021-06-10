//
//  ResultViewController.swift
//  TotoRan
//
//  Created by kosou.tei on 2021/05/29.
//

import UIKit
import Domain // Modelを画面間でやりとりに使用（本来はTransition専用DOを用意すべき）

class ResultViewControllerFactory {
    static func create(choiceDataModel: ChoiceDataModel) -> ResultViewController {
        let vc: ResultViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ResultViewController")
        vc.presenter = PresenterBuilder().createResultViewPresenter(view: vc, choiceDataModel: choiceDataModel)
        return vc
    }
}

protocol ResultViewable: NSObjectProtocol {
    func setUp()
    func resultDisplay(text: String)
    func transitionJudgeResultVC(choiceDataList: [ChoiceData])
}

class ResultViewController: UIViewController, ResultViewable {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var judgeButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    fileprivate var presenter: ResultViewPresentable?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.didLoad()
    }
    
    func setUp() {
        self.judgeButton.setTitle("判定", for: .normal)
        self.closeButton.setTitle("閉じる", for: .normal)
        
        if #available(iOS 14.0, *) {
            self.judgeButton.addAction(.init { _ in  self.presenter?.onTapJudgeButton() }, for: .touchUpInside)
            self.closeButton.addAction(.init { _ in self.dismiss(animated: true, completion: nil) }, for: .touchUpInside)
        }
    }
    
    func resultDisplay(text: String) {
        self.textView.text = text
    }
    
    func transitionJudgeResultVC(choiceDataList: [ChoiceData]) {
        let vc = JudgeResultViewControllerFactory.create(choiceDataList: choiceDataList)
        self.present(vc, animated: true, completion: nil)
    }
}
