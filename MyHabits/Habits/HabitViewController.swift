//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Toha Shilin on 9.08.25.
//
import UIKit

class HabitViewController: UIViewController {
    
    private lazy var labelName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Название"
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
    }
    
    func setConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            labelName.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            labelName.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 21)
            
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
    
    @objc func tapSave() {
        print("save")
    }
    
    @objc func tapCancel() {
        print("cansel")
    }
    
    
}
