//
//  AddViewController.swift
//  Rabit
//
//  Created by hy on 2019. 3. 15..
//  Copyright © 2019년 hy. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    
    enum Mode {
        case add, edit, none
    }
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var startDateSelectButton: UIButton!
    @IBOutlet weak var endDateSelectButton: UIButton!
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    
    @IBOutlet weak var repeatDaySelectView: UIView!
    @IBOutlet weak var everydayLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    private var mode: Mode = .none
    private var habit: Habit?
    private var startDate: Date?
    private var endDate: Date?
    private var selectedRepeatDays = Set<String>()
    private var isEveryDayRepeat = true {
        didSet {
            everydayLabel.isHidden = !isEveryDayRepeat
        }
    }
    
    init(nibName: String, mode: Mode, habitIndex: Int = -1) {
        super.init(nibName: nibName, bundle: nil)
        
        self.mode = mode
        self.habit = HabitsDataManager.shared.habits[safe: habitIndex]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedRepeatDays = ["월", "화", "수", "목", "금", "토", "일"]
        
        let isEditable = mode == .edit
        closeButton.isHidden = isEditable
        repeatDaySelectView.isHidden = isEditable
        addButton.isHidden = isEditable
        titleTextField.isEnabled = !isEditable
        startDateSelectButton.isEnabled = !isEditable
        endDateSelectButton.isEnabled = !isEditable
        
        titleTextField.text = habit?.title
        titleTextField.delegate = self
        titleTextField.returnKeyType = .done
        
        startDatePicker.addTarget(self, action: #selector(startDateTapped), for: .touchUpInside)
        startDatePicker.isHidden = true
        endDatePicker.addTarget(self, action: #selector(endDateTapped), for: .touchUpInside)
        endDatePicker.isHidden = true
        
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    @objc private func addButtonTapped() {
        guard let title = self.titleTextField.text, let startDate = self.startDate, let endDate = self.endDate else { return }
        let habit = Habit(title: title, isFinished: false, startDate: startDate, endDate: endDate)
        HabitsDataManager.shared.set(habit: habit)
        
        dismiss(animated: true, completion: nil)
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
