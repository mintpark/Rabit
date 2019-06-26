//
//  HabitsDataManager.swift
//  Rabit
//
//  Created by hy on 2019. 3. 18..
//  Copyright © 2019년 hy. All rights reserved.
//

import Foundation

class Habit: Codable {
    var title: String = ""
    var isFinished: Bool = false
    var startDate: Date = Date()
    var endDate: Date = Date()
    
    init(title: String, isFinished: Bool, startDate: Date, endDate: Date) {
        self.title = title
        self.isFinished = isFinished
        self.startDate = startDate
        self.endDate = endDate
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let title = aDecoder.decodeObject(forKey: "title") as! String
        let isFinished = aDecoder.decodeObject(forKey: "isFinished") as! Bool
        let startDate = aDecoder.decodeObject(forKey: "startDate") as! Date
        let endDate = aDecoder.decodeObject(forKey: "endDate") as! Date
        
        self.init(title: title, isFinished: isFinished, startDate: startDate, endDate: endDate)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "title")
        aCoder.encode(isFinished, forKey: "isFinished")
        aCoder.encode(startDate, forKey: "startDate")
        aCoder.encode(endDate, forKey: "endDate")
    }
    
    func changeIsFinished() {
        isFinished = !isFinished
    }
}

class HabitsDataManager: NSObject {
    static let KEY_HABITS = "KEY_HABITS"
    
    static let shared = HabitsDataManager()
    
    private(set) var habits: [Habit]? {
        get {
            guard let data = UserDefaults.standard.object(forKey: HabitsDataManager.KEY_HABITS) as? Data,
                let habits = try? JSONDecoder().decode([Habit].self, from: data) else { return nil }
            return habits
        }
        set {
            let data = try? JSONEncoder().encode(newValue)
            UserDefaults.standard.set(data, forKey: HabitsDataManager.KEY_HABITS)
            UserDefaults.standard.synchronize()
        }
    }
    
    func set(habit: Habit) {
        habits?.append(habit)
    }
}
