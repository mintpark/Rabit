//
//  HistoryViewController.swift
//  Rabit
//
//  Created by Hayoung Park on 16/07/2019.
//  Copyright © 2019 hy. All rights reserved.
//

import UIKit

final class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private lazy var tableView = UITableView(frame: .zero)
    
    var habits: [Habit]?

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: HistoryTableViewCell.className())
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        habits = HabitsDataManager.shared.habits
        tableView.reloadData()
    }
    
    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.className(), for: indexPath) as? HistoryTableViewCell,
            let habit = habits?[safe: indexPath.row] else { return UITableViewCell() }
        cell.configure(habit)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habits?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return HistoryTableViewCell.HEIGHT
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let editVC = AddViewController(nibName: AddViewController.className(), mode: .edit, habitIndex: indexPath.row)
        
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.pushViewController(editVC, animated: true)
    }
}

final class HistoryTableViewCell: UITableViewCell {
    private var titleLabel = UILabel(frame: .zero)
    private var ratioLabel = UILabel(frame: .zero)
    private var arrowImageView = UIImageView(frame: .zero)
    
    static let HEIGHT: CGFloat = 50
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(16)
            make.height.equalTo(30)
            make.centerY.equalToSuperview()
        }
        
        addSubview(ratioLabel)
        ratioLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(titleLabel.snp.trailing)
            make.width.equalTo(40)
            make.centerY.equalToSuperview()
        }
        
        addSubview(arrowImageView)
        arrowImageView.snp.makeConstraints { (make) in
            make.leading.equalTo(ratioLabel.snp.trailing)
            make.trailing.equalToSuperview()
            make.height.width.equalTo(30)
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ data: Habit) {
        titleLabel.text = data.title
        
        ratioLabel.text = String(format: "%d", 12)
        ratioLabel.textAlignment = .right
        ratioLabel.backgroundColor = .red
        
        arrowImageView.backgroundColor = .gray
    }
}
