//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Toha Shilin on 9.08.25.
//
import UIKit

class HabitViewController: UIViewController {
    
    private let store = HabitsStore.shared
    
    private lazy var labelName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "НАЗВАНИЕ"
        label.font = UIFont(name: "SFProText-Semibold", size: 13)
        return label
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        textField.font = UIFont(name: "SFProText-Regular", size: 17)
        
        return textField
    }()
    
    private lazy var labelColor: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "ЦВЕТ"
        label.font = UIFont(name: "SFProText-Semibold", size: 13)
        return label
    }()
    
    private lazy var colorPicker: UIColorWell = {
        let colorPicker = UIColorWell()
        colorPicker.translatesAutoresizingMaskIntoConstraints = false
        colorPicker.selectedColor = .red
        colorPicker.layer.borderWidth = 0
        
        return colorPicker
    }()
    
    private lazy var labelTime: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "ВРЕМЯ"
        label.font = UIFont(name: "SFProText-Semibold", size: 13)
        return label
    }()
    
    
    private lazy var timePicker: UIDatePicker = {
        let timePicker = UIDatePicker()
        timePicker.translatesAutoresizingMaskIntoConstraints = false
        timePicker.datePickerMode = UIDatePicker.Mode.time
        timePicker.minuteInterval = 1
        timePicker.preferredDatePickerStyle = .wheels
        timePicker.locale = Locale(identifier: "en-US")
        timePicker.timeZone = TimeZone(identifier: "Europe/Minsk")
        timePicker.roundsToMinuteInterval = true
        timePicker.addTarget(self, action: #selector(setDateToTextLine), for: .allEvents)
        return timePicker
    }()
    
    
    private lazy var timeLine: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Каждый день в \(getTimeString(from: timePicker.date))"
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        return label
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addSubview()
        setConstraints()
        
        setupNavigationBarAppearance()
    }
    
    func setupView() {
        self.title = "Создать"
        
    }
    
    func addSubview() {
        view.addSubview(labelName)
        view.addSubview(nameTextField)
        view.addSubview(labelColor)
        view.addSubview(colorPicker)
        view.addSubview(labelTime)
        view.addSubview(timeLine)
        view.addSubview(timePicker)
    }
    
    func setConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            labelName.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            labelName.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 21),
            
            nameTextField.leadingAnchor.constraint(equalTo: labelName.leadingAnchor),
            nameTextField.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 7),
            nameTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            
            labelColor.leadingAnchor.constraint(equalTo: labelName.leadingAnchor),
            labelColor.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 15),
            
            colorPicker.topAnchor.constraint(equalTo: labelColor.bottomAnchor, constant: 7),
            colorPicker.leadingAnchor.constraint(equalTo: labelName.leadingAnchor),
            colorPicker.widthAnchor.constraint(equalToConstant: 30),
            colorPicker.heightAnchor.constraint(equalToConstant: 30),
            
            labelTime.leadingAnchor.constraint(equalTo: labelName.leadingAnchor),
            labelTime.topAnchor.constraint(equalTo: colorPicker.bottomAnchor, constant: 15),
            
            timeLine.leadingAnchor.constraint(equalTo: labelName.leadingAnchor),
            timeLine.topAnchor.constraint(equalTo: labelTime.bottomAnchor, constant: 7),
            
            timePicker.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 7),
            timePicker.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -7),
            timePicker.topAnchor.constraint(equalTo: timeLine.bottomAnchor, constant: 7),
            timePicker.heightAnchor.constraint(equalToConstant: 100),
            
            
            
            
        ])
    }
    
    
    func setupNavigationBarAppearance() {
        let navigationBarAppearance = UINavigationBarAppearance()
        
        navigationBarAppearance.configureWithDefaultBackground()
        navigationBarAppearance.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 0.94)
        navigationBarAppearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.systemBlue
        ]
        navigationBarAppearance.shadowColor = .lightGray
        
        navigationItem.standardAppearance = navigationBarAppearance
        navigationItem.compactAppearance = navigationBarAppearance
        navigationItem.scrollEdgeAppearance = navigationBarAppearance
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Сохранить",
            style: .plain,
            target: self,
            action: #selector(tapSave)
        )
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Отменить",
            style: .plain,
            target: self,
            action: #selector(tapCancel)
        )
        navigationItem.titleView?.tintColor = .black
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func getTimeString(from: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: from)
    }
    
    @objc func tapSave() {
        print("save")
        if let name = nameTextField.text, let color = colorPicker.selectedColor {
            let habit = Habit(name: name, date: timePicker.date, color: color)
            store.habits.append(habit)
            navigationController?.popViewController(animated:true)
        } else {
            print("You should fill all fields")
        }
        
        
    }
    
    @objc func tapCancel() {
        navigationController?.popViewController(animated:true)
    }
    
    @objc func setDateToTextLine() {
        timeLine.text = "Каждый день в \(getTimeString(from: timePicker.date))"
    }
    
    
}
