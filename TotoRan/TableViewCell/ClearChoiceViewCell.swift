//
//  ClearChoiceViewCell.swift
//  TotoRan
//
//  Created by kosou.tei on 2021/05/22.
//

import UIKit

protocol ClearChoiceViewCellDelegate: NSObjectProtocol {
    func clear()
}

class ClearChoiceViewCell: UITableViewCell {
    @IBOutlet weak var clearButton: UIButton!
    private weak var delegate: ClearChoiceViewCellDelegate?

    func setUp(delegate: ClearChoiceViewCellDelegate?) {
        self.delegate = delegate
        self.setUpButton()
    }
    
    private func setUpButton() {
        self.clearButton.setTitle("クリア", for: .normal)
        self.clearButton.addTarget(self, action: #selector(clearButtonAction), for: .touchUpInside)
    }
    
    @objc private func clearButtonAction() {
        self.delegate?.clear()
    }
}
