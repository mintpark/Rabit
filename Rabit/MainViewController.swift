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
    
    var habits: [Habit]? = [
        Habit(title: "출석체크", isFinished: false),
        Habit(title: "출석체크2", isFinished: false),
        Habit(title: "출석체크3", isFinished: false),
        Habit(title: "출석체크4", isFinished: false),
        Habit(title: "출석체크5", isFinished: false),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: MainTableViewCell.className(), bundle: nil), forCellReuseIdentifier: MainTableViewCell.className())
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
        return 96
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let habit = habits?[safe: indexPath.row],
            let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.className(), for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        cell.viewModel = habit
        
        return cell
    }
}

class Habit {
    var title: String = ""
    var isFinished: Bool = false
    
    init(title: String, isFinished: Bool) {
        self.title = title
        self.isFinished = isFinished
    }
    
    func changeIsFinished() {
        isFinished = !isFinished
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
