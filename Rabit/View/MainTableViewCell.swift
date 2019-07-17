//
//  MainTableViewCell.swift
//  Rabit
//
//  Created by hy on 2019. 3. 14..
//  Copyright © 2019년 hy. All rights reserved.
//

import UIKit
import SnapKit

class MainTableViewCell: UITableViewCell {
    static let height: CGFloat = MainTableViewCell.margin + 40
    static let margin: CGFloat = 16
    
    private lazy var titleLabel = UILabel()
    private lazy var finishImageView = UIImageView(image: UIImage(named: "check"))
    
    var viewModel: Habit? {
        didSet {
            titleLabel.text = viewModel?.title
            finishImageView.isHidden = viewModel?.isFinished ?? false
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.width.lessThanOrEqualTo(UIScreen.main.bounds.width - 40 - MainTableViewCell.margin*2)
            make.leading.equalTo(MainTableViewCell.margin)
            make.centerY.equalToSuperview()
        }
        
        addSubview(finishImageView)
        finishImageView.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.width.equalTo(40)
            make.trailing.equalTo(-MainTableViewCell.margin)
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
