//
//  CloseButtonViewCell.swift
//  TotoRan
//
//  Created by kosou.tei on 2021/05/25.
//

import UIKit

protocol CloseButtonViewCellDelegate: NSObjectProtocol {
    func close()
}

class CloseButtonViewCell: UITableViewCell {
    @IBOutlet weak var closeButton: UIButton!
    private weak var delegate: CloseButtonViewCellDelegate?

    func setUp(delegate: CloseButtonViewCellDelegate?) {
        self.delegate = delegate
        self.setUpButton()
    }
    
    private func setUpButton() {
        self.closeButton.setTitle("戻る", for: .normal)
        self.closeButton.addTarget(self, action: #selector(closeButtonAction), for: .touchUpInside)
    }
    
    @objc private func closeButtonAction() {
        self.delegate?.close()
    }
}
