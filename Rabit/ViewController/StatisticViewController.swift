//
//  StatisticViewController.swift
//  Rabit
//
//  Created by Hayoung Park on 15/07/2019.
//  Copyright © 2019 hy. All rights reserved.
//

import UIKit
import SnapKit

final class StatisticViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private var tableView = UITableView(frame: .zero)
    
    var habits: [Habit]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(StatisticTableViewCell.self, forCellReuseIdentifier: StatisticTableViewCell.className())
        tableView.register(StatisticTableFooterView.self, forHeaderFooterViewReuseIdentifier: StatisticTableFooterView.className())
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    #warning("habits 참조하는 더 좋은 방법?")
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        habits = HabitsDataManager.shared.habits
        tableView.reloadData()
    }

    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habits?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StatisticTableViewCell.className(), for: indexPath) as? StatisticTableViewCell,
            let habit = habits?[safe: indexPath.row] else { return UITableViewCell() }
        
        let viewModel = StatisticViewController.StatisticViewModel(habit)
        cell.configure(viewModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: StatisticTableFooterView.className()) as? StatisticTableFooterView else { return UIView() }
        
        return footer
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }

}

extension StatisticViewController {
    final class StatisticViewModel {
        var title: String = ""
        var completeRatio: Int = 0
        
        init(_ habit: Habit) {
            self.title = habit.title
            self.completeRatio = {
                let dateTotal: Float = 1
                let dateComplete: Float = 1
                
                return Int(ceilf(dateTotal/dateComplete))
            }()
        }
    }
}

final class StatisticTableViewCell: UITableViewCell {
    private lazy var titleLabel = UILabel(frame: .zero)
    private lazy var ratioLabel = UILabel(frame: .zero)
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(16)
            make.leading.trailing.equalTo(20)
            make.height.equalTo(20)
        }
        
        addSubview(ratioLabel)
        ratioLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(20)
            make.height.equalTo(20)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ viewModel: StatisticViewController.StatisticViewModel) {
        titleLabel.text = viewModel.title
        ratioLabel.text = String(format: "%d%", viewModel.completeRatio)
    }
}

final class StatisticTableFooterView: UITableViewHeaderFooterView {
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        let messageLabel = UILabel(frame: .zero)
        messageLabel.text = "오늘까지의 진행도를 확인하실 수 있습니다."
        messageLabel.textAlignment = .center
        addSubview(messageLabel)
        messageLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(20)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
