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
    static let height: CGFloat = 90
    static var viewModel = DateViewModel(Date())
    
    private var stackView: UIStackView = {
        let dateViews: [DateView] = (0..<DateViewModel.DATE_COUNT).map { (i) -> DateView in
            let date = viewModel.days[safe: i]
            let view = DateView(day: String(date?.day ?? 1), date: date?.dateOfWeek ?? "")
            return view
        }
        
        let stack = UIStackView(arrangedSubviews: dateViews)
        stack.axis = .horizontal
        stack.distribution = UIStackViewDistribution.fillEqually
        stack.spacing = 0
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        
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
            
            (0..<DateViewModel.DATE_COUNT).forEach { (index) in
                let dayOfWeekString = ["", "Sun", "Mon", "Tue", "Wed", "Thur", "Fri", "Sat"]
                let date = Date(timeIntervalSinceNow: TimeInterval(60*60*24*(index-2)))
                let components = calendar.dateComponents([.weekday, .day], from: date)
                let dayOfWeek = dayOfWeekString[components.weekday ?? 0]
                days.append(.init(dateOfWeek: dayOfWeek, day: components.day ?? 1, isSelected: false))
            }
        }
    }
    
    private class DateView: UIView {
        private let HEIGHT_DAY: CGFloat = 30
        private let HEIGHT_DATE: CGFloat = 60
        
        private var dayLabel: UILabel!
        private var dateButton: UIButton!
        
        init(day: String, date: String) {
            super.init(frame: .zero)
            
            dayLabel = UILabel()
            dayLabel.text = day
            dayLabel.textAlignment = .center
            
            dateButton = UIButton()
            dateButton.setTitle(date, for: .normal)
            dateButton.setTitleColor(.black, for: .normal)
            dateButton.addTarget(self, action: #selector(dateButtonTapped), for: .touchUpInside)
            
            addSubview(dayLabel)
            dayLabel.snp.makeConstraints { (make) in
                make.top.leading.trailing.equalToSuperview()
                make.height.equalTo(HEIGHT_DAY)
            }
            
            addSubview(dateButton)
            dateButton.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(HEIGHT_DAY)
                make.leading.trailing.equalToSuperview()
                make.height.equalTo(HEIGHT_DATE)
            }
        }
        
        override var intrinsicContentSize: CGSize {
            return CGSize(width: 0, height: HEIGHT_DAY+HEIGHT_DATE)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        @objc func dateButtonTapped() {
            dateButton.backgroundColor = .green
        }
    }
}
