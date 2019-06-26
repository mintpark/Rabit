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
    
    var habits: [Habit]? // = HabitsDataManager.shared.habits    // 값을 참조하기만 할 뿐, 함수를 실행하지는 않는구나.

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.className())
    
        let addBarItem = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(addHabit))
        self.navigationItem.setRightBarButton(addBarItem, animated: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        habits = HabitsDataManager.shared.habits
        tableView.reloadData()
    }
    
    @objc private func addHabit() {
        
        self.navigationController?.present(AddViewController.init(nibName: AddViewController.className(), bundle: nil), animated: true, completion: nil)
    }
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let habit = habits?[safe: indexPath.row],
            let cell = tableView.cellForRow(at: indexPath) as? MainTableViewCell else { return }
        habit.changeIsFinished()
        cell.viewModel = habit
        cell.reloadInputViews()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habits?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MainTableViewCell.height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let habit = habits?[safe: indexPath.row],
            let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.className(), for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        cell.viewModel = habit
        
        return cell
    }
}

////
extension Array {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

////
protocol Nameable {
    static func className() -> String
}

extension Nameable {
    static func className() -> String {
        return String(describing: self)
    }
}

extension NSObject: Nameable {}
