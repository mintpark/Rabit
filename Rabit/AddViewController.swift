//
//  AddViewController.swift
//  Rabit
//
//  Created by hy on 2019. 3. 15..
//  Copyright © 2019년 hy. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var startDateSelectButton: UIButton!
    @IBOutlet weak var endDateSelectButton: UIButton!
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    
    @IBOutlet weak var everydayLabel: UILabel!
    
    private var startDate: Date?
    private var endDate: Date?
    private var selectedRepeatDays = Set<String>()
    private var isEveryDayRepeat = true {
        didSet {
            everydayLabel.isHidden = !isEveryDayRepeat
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedRepeatDays = ["월", "화", "수", "목", "금", "토", "일"]
        
        titleTextField.delegate = self
        titleTextField.returnKeyType = .done
        
        startDatePicker.addTarget(self, action: #selector(startDateTapped), for: .touchUpInside)
        startDatePicker.isHidden = true
        endDatePicker.addTarget(self, action: #selector(endDateTapped), for: .touchUpInside)
        endDatePicker.isHidden = true
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func startDateTapped(_ sender: UIButton) {
        startDatePicker.isHidden = sender.isSelected
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func setStartDate(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        startDateSelectButton.setTitle(formatter.string(from: sender.date), for: .normal)
        startDateSelectButton.setTitle(formatter.string(from: sender.date), for: .selected)
        startDate = sender.date
    }
    
    @IBAction func endDateTapped(_ sender: UIButton) {
        endDatePicker.isHidden = sender.isSelected
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func setEndDate(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        endDateSelectButton.setTitle(formatter.string(from: sender.date), for: .normal)
        endDateSelectButton.setTitle(formatter.string(from: sender.date), for: .selected)
        endDate = sender.date
    }
    
    @IBAction func repeatDayTapped(_ sender: UIButton) {
        guard let selectedDay = sender.titleLabel?.text else { return }
        
        if sender.isSelected {
            selectedRepeatDays.insert(selectedDay)
        } else {
            selectedRepeatDays.remove(selectedDay)
        }
        
        isEveryDayRepeat = selectedRepeatDays.count == 7 ? true : false
    }
    
    @IBAction func addHabitButtonTapped(_ sender: UIButton) {
        guard let title = self.titleTextField.text, let startDate = self.startDate, let endDate = self.endDate else { return }
        let habit = Habit(title: title, isFinished: false, startDate: startDate, endDate: endDate)
        
        HabitsDataManager.shared.set(habit: habit)
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AddViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
