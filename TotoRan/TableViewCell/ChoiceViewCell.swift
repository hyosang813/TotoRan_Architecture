//
//  ChoiceViewCell.swift
//  TotoRan
//
//  Created by kosou.tei on 2021/05/22.
//

import UIKit

protocol ChoiceViewCellDelegate: NSObjectProtocol {
    func setSelectedHome(id: Int, selected: Bool)
    func setSelectedAway(id: Int, selected: Bool)
    func setSelectedDraw(id: Int, selected: Bool)
}

class ChoiceViewCell: UITableViewCell {
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var drawButton: UIButton!
    @IBOutlet weak var awayButton: UIButton!
    
    private var viewData: ChoiceViewData?
    private weak var delegate: ChoiceViewCellDelegate?

    func setUp(viewData: ChoiceViewData?, delegate: ChoiceViewCellDelegate?) {
        self.viewData = viewData
        self.delegate = delegate
        self.setUpButton()
    }
    
    private func setUpButton() {
        self.homeButton.isSelected = viewData?.homeSelected ?? false
        self.awayButton.isSelected = viewData?.awaySelected ?? false
        self.drawButton.isSelected = viewData?.drawSelected ?? false
        
        self.homeButton.setTitle(viewData?.homeTeamName, for: .normal)
        self.awayButton.setTitle(viewData?.awayTeamName, for: .normal)
        self.drawButton.setTitle("DRAW", for: .normal)
        
        self.homeButton.addTarget(self, action: #selector(homeButtonAction), for: .touchUpInside)
        self.awayButton.addTarget(self, action: #selector(awayButtonAction), for: .touchUpInside)
        self.drawButton.addTarget(self, action: #selector(drawButtonAction), for: .touchUpInside)
        
        [self.homeButton, self.awayButton, self.drawButton].forEach { button in
            if button!.isSelected {
                button!.setTitleColor(.black, for: .normal)
            } else {
                button!.setTitleColor(.red, for: .normal)
            }
        }
    }
    
    @objc private func homeButtonAction() {
        if let viewData = self.viewData {
            self.delegate?.setSelectedHome(id: viewData.id, selected: !viewData.homeSelected)
        }
    }
    
    @objc private func awayButtonAction() {
        if let viewData = self.viewData {
            self.delegate?.setSelectedAway(id: viewData.id, selected: !viewData.awaySelected)
        }
    }
    
    @objc private func drawButtonAction() {
        if let viewData = self.viewData {
            self.delegate?.setSelectedDraw(id: viewData.id, selected: !viewData.drawSelected)
        }
    }
}
