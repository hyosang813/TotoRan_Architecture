//
//  MultiChoiceSettingViewController.swift
//  TotoRan
//
//  Created by kosou.tei on 2021/05/27.
//

import UIKit

class MultiChoiceSettingViewControllerFactory {
    static func create(choiceDataModel: ChoiceDataModel) -> MultiChoiceSettingViewController {
        let vc: MultiChoiceSettingViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MultiChoiceSettingViewController")
        vc.choiceDataModel = choiceDataModel
        return vc
    }
}

class MultiChoiceSettingViewController: UIViewController {
    
    @IBOutlet weak var doubleTextField: UITextField!
    @IBOutlet weak var tripleTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    var choiceDataModel: ChoiceDataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
        self.setUpPicker()
    }
    
    private func setUp() {
        // ボタン
        self.nextButton.setTitle("次へ", for: .normal)
        self.closeButton.setTitle("閉じる", for: .normal)
        self.nextButton.addTarget(self, action: #selector(onTapNextButton), for: .touchUpInside)
        self.closeButton.addTarget(self, action: #selector(onTapCloseButton), for: .touchUpInside)
        
        // テキスト
        self.doubleTextField.text = self.choiceDataModel?.doubleCount.description
        self.tripleTextField.text = self.choiceDataModel?.tripleCount.description
    }
    
    private func setUpPicker() {
        let toolbar = UIToolbar()
        toolbar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44)
        let doneButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePicker))
        toolbar.setItems([doneButtonItem], animated: true)
        
        [self.doubleTextField, self.tripleTextField].forEach { textField in
            let picker = UIPickerView()
            picker.delegate = self
            picker.dataSource = self
            picker.tag = textField?.tag ?? 0 // xibで設定してるから絶対とれる前提
            textField?.inputView = picker
            textField?.inputAccessoryView = toolbar
        }
    }
    
    @objc private func donePicker() {
        [self.doubleTextField, self.tripleTextField].forEach { textField in
            textField.endEditing(true)
        }
    }
    
    @objc private func onTapNextButton() {
        if let doubleCount = Int(self.doubleTextField.text ?? ""),
           let tripleCount = Int(self.tripleTextField.text ?? ""),
           var model = self.choiceDataModel,
           model.possibleTransitionForPickerSelected(doubleCount: doubleCount, tripleCount: tripleCount) {
            model.setPickerSelectedCount(doubleCount: doubleCount, tripleCount: tripleCount)
            let vc = ResultViewControllerFactory.create(choiceDataModel: model)
            self.present(vc, animated: true, completion: nil)
        } else {
            self.showAlert()
        }
    }
    
    @objc private func onTapCloseButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func showAlert() {
        let combinationOver = "合計486口を超える組み合わせは選択できません。"
        let alert: UIAlertController = UIAlertController(title: nil, message: combinationOver, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "閉じる", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension MultiChoiceSettingViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case self.doubleTextField.tag:
            return self.choiceDataModel?.doublePickerList.count ?? 0
        case self.tripleTextField.tag:
            return self.choiceDataModel?.triplePickerList.count ?? 0
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case self.doubleTextField.tag:
            return self.choiceDataModel?.doublePickerList[row].description
        case self.tripleTextField.tag:
            return self.choiceDataModel?.triplePickerList[row].description
        default:
            return "?"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case self.doubleTextField.tag:
            self.doubleTextField.text = self.choiceDataModel?.doublePickerList[row].description
        case self.tripleTextField.tag:
            self.tripleTextField.text = self.choiceDataModel?.triplePickerList[row].description
        default:
            break
        }
    }
}
