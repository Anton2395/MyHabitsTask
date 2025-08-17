//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Toha Shilin on 9.08.25.
//
import UIKit

class HabitViewController: UIViewController {
    let habit: Habit?
    private let store = HabitsStore.shared
    
    init(habit: Habit) {
        self.habit = habit
        super.init(nibName: nil, bundle: nil)
    }
    
    init() {
        habit = nil
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        textField.keyboardType = .default
        textField.returnKeyType = .done
        return textField
    }()
    
    private lazy var labelColor: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "ЦВЕТ"
        label.font = UIFont(name: "SFProText-Semibold", size: 13)
        return label
    }()
    
    private lazy var colorPicker: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.random
        button.layer.cornerRadius = 15
        
        button.addTarget(self, action: #selector(showColorPicker), for: .touchUpInside)
        return button
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
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Удалить привычку", for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProText-Regular", size: 17)
        button.setTitleColor(UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 1.0), for: .normal)
        
        button.addTarget(self, action: #selector(tapDeleteButton), for: .touchUpInside)
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addSubview()
        setConstraints()
        
        setupNavigationBarAppearance()
    }
    
    func setupView() {
        if let habit = self.habit {
            nameTextField.text = habit.name
            colorPicker.backgroundColor = habit.color
            timePicker.date = habit.date
            self.title = "Править"
        } else {
            self.title = "Создать"
        }
    }
    
    func addSubview() {
        view.addSubview(labelName)
        view.addSubview(nameTextField)
        view.addSubview(labelColor)
        view.addSubview(colorPicker)
        view.addSubview(labelTime)
        view.addSubview(timeLine)
        view.addSubview(timePicker)
        if habit != nil {
            view.addSubview(deleteButton)
        }
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
            timePicker.heightAnchor.constraint(equalToConstant: 216),
        ])
        
        if habit != nil {
            NSLayoutConstraint.activate([
                deleteButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
                deleteButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
                deleteButton.widthAnchor.constraint(equalTo: safeArea.widthAnchor),
                deleteButton.heightAnchor.constraint(equalToConstant: 44)
            ])
        }
    }
    
    
    func setupNavigationBarAppearance() {
        let navigationBarAppearance = UINavigationBarAppearance()
        
        navigationBarAppearance.configureWithDefaultBackground()
        navigationBarAppearance.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 0.94)
        
        navigationBarAppearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]
        navigationBarAppearance.buttonAppearance.normal.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.systemPurple
        ]
        
        navigationBarAppearance.shadowColor = .lightGray
        
        navigationItem.standardAppearance = navigationBarAppearance
        navigationItem.compactAppearance = navigationBarAppearance
        navigationItem.scrollEdgeAppearance = navigationBarAppearance
        
        let saveButton = UIBarButtonItem(
            title: "Сохранить",
            style: .plain,
            target: self,
            action: #selector(tapSave)
        )
        saveButton.setTitleTextAttributes([
            .font: UIFont.systemFont(ofSize: 17, weight: .semibold),
            .foregroundColor: UIColor.systemPurple
        ], for: .normal)
        navigationItem.rightBarButtonItem = saveButton
        
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
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func getTimeString(from: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: from)
    }
    
    @objc func showColorPicker() {
        let picker = UIColorPickerViewController()
        picker.delegate = self
        picker.selectedColor = colorPicker.backgroundColor ?? UIColor.random
        present(picker, animated: true)
    }
    
    @objc func tapSave() {
        if let habit = self.habit {
            print("edit")
            if let name = nameTextField.text, let color = colorPicker.backgroundColor {
                habit.name = name
                habit.color = color
                habit.date = timePicker.date
                store.save()
                navigationController?.popViewController(animated:true)
            }
            
        } else {
            print("save")
            if let name = nameTextField.text, let color = colorPicker.backgroundColor {
                let habit = Habit(name: name, date: timePicker.date, color: color)
                store.habits.append(habit)
                navigationController?.popViewController(animated:true)
            } else {
                print("You should fill all fields")
            }
        }
        
        
    }
    
    @objc func tapCancel() {
        navigationController?.popViewController(animated:true)
    }
    
    @objc func setDateToTextLine() {
        timeLine.text = "Каждый день в \(getTimeString(from: timePicker.date))"
    }
    
    @objc func tapDeleteButton() {
        print("tap delete")
        if let habit = self.habit {
            let alert = UIAlertController(
                title: "Удалить привычку",
                message: "Вы хотите удалить привычку \"\(habit.name)\"?",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Удалить", style: .destructive, handler: { _ in
                self.store.remove(habit)
                self.navigationController?.popToRootViewController(animated: true)
            }))
            present(alert, animated: true)
        }
    }
    
}


extension HabitViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        colorPicker.backgroundColor = viewController.selectedColor
    }
}
