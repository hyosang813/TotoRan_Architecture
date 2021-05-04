//
//  TransitionButtonViewCell.swift
//  TotoRan
//
//  Created by kosou.tei on 2021/05/22.
//
import UIKit

protocol TransitionButtonViewCellDelegate: NSObjectProtocol {
    func next()
}

class TransitionButtonViewCell: UITableViewCell {
    @IBOutlet weak var nextButton: UIButton!
    private weak var delegate: TransitionButtonViewCellDelegate?

    func setUp(delegate: TransitionButtonViewCellDelegate?) {
        self.delegate = delegate
        self.setUpButton()
    }
    
    private func setUpButton() {
        self.nextButton.setTitle("次へ", for: .normal)
        self.nextButton.addTarget(self, action: #selector(nextButtonAction), for: .touchUpInside)
    }
    
    @objc private func nextButtonAction() {
        self.delegate?.next()
    }
}
