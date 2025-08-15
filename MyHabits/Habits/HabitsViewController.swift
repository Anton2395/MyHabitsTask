//
//  ViewController.swift
//  MyHabits
//
//  Created by Toha Shilin on 8.08.25.
//

import UIKit

class HabitsViewController: UIViewController {
//    private let store = HabitsStore.shared
    private let dataSorceDelegate = HabitsCollectionDataSorceDelegate()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Сегодня"
        label.font = UIFont(name: "SF Pro Display Semibold", size: 25.0)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1.0)
        collectionView.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: CellReuseID.base.rawValue)
        return collectionView
    }()
    
    private enum CellReuseID: String {
        case base = "HabitCollectionViewCell_ReuseID"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSorceDelegate.navigationController = navigationController
        
        setupView()
        setSubview()
        setConstraints()
        
        setupNavigationBarAppearance()
        setupCollectionView()
    }
    
    
    func setupView() {
//        self.title = "Привычки"
    }
    
    func setSubview() {
        view.addSubview(collectionView)
    }
    
    func setConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    
    func setupCollectionView() {
        collectionView.dataSource = dataSorceDelegate
        collectionView.delegate = dataSorceDelegate
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        dataSorceDelegate.updateStore()
        collectionView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func setupNavigationBarAppearance() {
        let navigationBarAppearance = UINavigationBarAppearance()
        
        navigationBarAppearance.configureWithDefaultBackground()
        navigationBarAppearance.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 0.94)
        navigationBarAppearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.systemBlue
        ]
//        na
        navigationBarAppearance.shadowColor = .lightGray
        
        navigationItem.standardAppearance = navigationBarAppearance
        navigationItem.compactAppearance = navigationBarAppearance
        navigationItem.scrollEdgeAppearance = navigationBarAppearance
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain,
            target: self,
            action: #selector(plusTapped)
        )
        navigationItem.rightBarButtonItem?.tintColor = .systemPurple
        
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor)
        ])
        navigationItem.titleView = container
    }
    
    
    @objc func plusTapped() {
        let viewController = HabitViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    

}

