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
    static var viewModel = DateViewModel(Date())
    
    private var stackView: UIStackView = {
        let labels: [UILabel] = (0..<DateViewModel.DATE_COUNT).map { (i) -> UILabel in
            var label = UILabel(frame: .zero)
            label.textAlignment = .center
            label.text = String(viewModel.days[safe: i]?.day ?? 0)
            return label
        }
        
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = UIStackViewDistribution.fillEqually
        stack.spacing = 0
        stack.alignment = .center
        (0..<DateViewModel.DATE_COUNT).forEach({ (i) in
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

extension MainTableHeaderView {
    struct HeaderDate {
        var dateOfWeek: String = "Sun"
        var day: Int = 1
        var isSelected: Bool = false
    }

    struct DateViewModel {
        static let DATE_COUNT = 5
        
        var year: Int = 0
        var month: Int = 0
        var days: Array<HeaderDate> = []
        
        init(_ date: Date) {
            let calendar = Calendar.current
            let todayComponents = calendar.dateComponents([.month, .year], from: date)
            year = todayComponents.year ?? 0
            month = todayComponents.month ?? 0

            var dateArray = Array<HeaderDate>()
            (0..<DateViewModel.DATE_COUNT).forEach { (index) in
                let dayOfWeekString = ["", "Sun", "Mon", "Tue", "Wed", "Thur", "Fri", "Sat"]
                let date = Date(timeIntervalSinceNow: TimeInterval(60*60*24*(index-2)))
                let components = calendar.dateComponents([.weekday, .day], from: date)
                let dayOfWeek = dayOfWeekString[components.weekday ?? 0]
                dateArray.append(.init(dateOfWeek: dayOfWeek, day: components.day ?? 1, isSelected: false))
            }
            days = dateArray
        }
    }
}
