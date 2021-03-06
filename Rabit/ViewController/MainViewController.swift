//
//  ViewController.swift
//  Rabit
//
//  Created by hy on 2019. 3. 14..
//  Copyright © 2019년 hy. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private var habits: [Habit]? = HabitsDataManager.shared.habits

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.className())
        tableView.register(MainTableHeaderView.self, forHeaderFooterViewReuseIdentifier: MainTableHeaderView.className())

        let image = UIImage(named: "plus")?.withRenderingMode(.alwaysOriginal)
        let addBarItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(addHabit))
        self.navigationItem.setRightBarButton(addBarItem, animated: true)
        
        let yearLabelItem = UIBarButtonItem(title: String(format: "%d", MainTableHeaderView.viewModel.year), style: .plain, target: self, action: nil)
        yearLabelItem.tintColor = .black
        self.navigationItem.setLeftBarButton(yearLabelItem, animated: true)
        
        self.navigationItem.title = String(format: "%d", MainTableHeaderView.viewModel.month)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @objc private func addHabit() {
        self.navigationController?.present(AddViewController.init(nibName: AddViewController.className(), mode: .add), animated: true, completion: nil)
    }
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habits?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let habit = habits?[safe: indexPath.row],
            let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.className(), for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        cell.viewModel = habit
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MainTableHeaderView.className()) as? MainTableHeaderView else { return nil }
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return MainTableHeaderView.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let habit = habits?[safe: indexPath.row],
            let cell = tableView.cellForRow(at: indexPath) as? MainTableViewCell else { return }
        habit.changeIsFinished()
        cell.viewModel = habit
        cell.reloadInputViews()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            HabitsDataManager.shared.remove(at: indexPath)
            habits = HabitsDataManager.shared.habits    // MARK: refactor
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        default:
            ()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MainTableViewCell.height
    }
}
