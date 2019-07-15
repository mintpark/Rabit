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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(StatisticTableViewCell.self, forCellReuseIdentifier: StatisticTableViewCell.className())
        tableView.register(StatisticTableFooterView.self, forHeaderFooterViewReuseIdentifier: StatisticTableFooterView.className())
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StatisticTableViewCell.className(), for: indexPath) as? StatisticTableViewCell else { return UITableViewCell() }
        
        let viewModel = StatisticViewController.StatisticViewModel()
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
        var title: String = "test habit 1"
        var completeRatio: Int = 19
    }
}

final class StatisticTableViewCell: UITableViewCell {
    private lazy var titleLabel = UILabel(frame: .zero)
    private lazy var ratioLabel = UILabel(frame: .zero)
    
    func configure(_ viewModel: StatisticViewController.StatisticViewModel) {
        titleLabel.text = viewModel.title
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(16)
            make.leading.trailing.equalTo(20)
            make.height.equalTo(20)
        }
        
        ratioLabel.text = String(format: "%d%", viewModel.completeRatio)
        addSubview(ratioLabel)
        ratioLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(20)
            make.height.equalTo(20)
        }
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
