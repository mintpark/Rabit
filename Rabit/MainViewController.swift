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
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: MainTableViewCell.className(), bundle: nil), forCellReuseIdentifier: MainTableViewCell.className())
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
        
        print(habit.title)
        return cell
    }
}

struct Habit {
    var title: String
    var isFinished: Bool
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
