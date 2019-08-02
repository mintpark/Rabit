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
    
    private var stackView: UIStackView! // = UIStackView(arrangedSubviews: dateViews)
    private var dateViews: [DateView]! // = [DateView]()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        dateViews = (0..<MainTableHeaderView.DateViewModel.DATE_COUNT).map ({ (i) in
            let date = MainTableHeaderView.viewModel.days[safe: i]
            return DateView(dayOfWeek: date?.dayOfWeek ?? "", day: date?.day ?? 0)
        })
        
        stackView = UIStackView(arrangedSubviews: dateViews)
        stackView.axis = .horizontal
        stackView.distribution = UIStackView.Distribution.fillEqually
        stackView.spacing = 0
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(MainTableHeaderView.height)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
    #warning("DateViewModel 구조 바꿔서 date 하나로 업데이트 칠 수 있어야함")
    func update(_ date: Date) {
        (0..<DateViewModel.DATE_COUNT).forEach { (i) in
            let date = MainTableHeaderView.viewModel.days[i]
            let dateView = dateViews[i]
        }
    }
     */
}

extension MainTableHeaderView {
    struct HeaderDate {
        var dayOfWeek: String = "Sun"
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
                days.append(.init(dayOfWeek: dayOfWeek, day: components.day ?? 1, isSelected: false))
            }
        }
    }
    
    private class DateView: UIView {
        private let HEIGHT_DAYOFWEEK: CGFloat = 30
        private let HEIGHT_DATE: CGFloat = 60
        
        private var dayLabel: UILabel!
        private var dateButton: UIButton!
        
        init(dayOfWeek: String, day: Int) {
            super.init(frame: .zero)
            
            dayLabel = UILabel()
            dayLabel.text = dayOfWeek
            dayLabel.textAlignment = .center
            
            dateButton = UIButton()
            dateButton.setTitle("\(day)", for: .normal)
            dateButton.setTitleColor(.black, for: .normal)
            dateButton.addTarget(self, action: #selector(dateButtonTapped), for: .touchUpInside)
            
            addSubview(dayLabel)
            dayLabel.snp.makeConstraints { (make) in
                make.top.leading.trailing.equalToSuperview()
                make.height.equalTo(HEIGHT_DAYOFWEEK)
            }
            
            addSubview(dateButton)
            dateButton.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(HEIGHT_DAYOFWEEK)
                make.leading.trailing.equalToSuperview()
                make.height.equalTo(HEIGHT_DATE)
            }
        }
        
        override var intrinsicContentSize: CGSize {
            return CGSize(width: 0, height: HEIGHT_DAYOFWEEK + HEIGHT_DATE)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        @objc func dateButtonTapped() {
            dateButton.backgroundColor = .green
        }
    }
}
