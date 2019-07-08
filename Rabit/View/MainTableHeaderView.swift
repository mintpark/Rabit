//
//  MainTableHeaderView.swift
//  Rabit
//
//  Created by Hayoung Park on 04/07/2019.
//  Copyright © 2019 hy. All rights reserved.
//

import UIKit
import SnapKit

final class MainTableHeaderView: UITableViewHeaderFooterView {
    static let height: CGFloat = 44
    
    private var stackView: UIStackView = {
        let DATE_COUNT = 5
        
        let labels: [UILabel] = (0..<DATE_COUNT).map { (i) -> UILabel in
            var label = UILabel(frame: .zero)
            label.textAlignment = .center
            label.text = String(i)
            return label
        }
        
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = UIStackViewDistribution.fillEqually
        stack.spacing = 0
        stack.alignment = .center
        (0..<DATE_COUNT).forEach({ (i) in
            stack.addArrangedSubview(labels[safe: i] ?? UILabel(frame: .zero))
        })
        
        return stack
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(MainTableHeaderView.height)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
