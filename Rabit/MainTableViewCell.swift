//
//  MainTableViewCell.swift
//  Rabit
//
//  Created by hy on 2019. 3. 14..
//  Copyright © 2019년 hy. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var finishImageView: UIImageView!
    
    var viewModel: Habit? {
        didSet {
            titleLabel.text = viewModel?.title
            finishImageView.isHidden = viewModel?.isFinished ?? false
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
