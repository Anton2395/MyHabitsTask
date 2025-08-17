//
//  ViewController.swift
//  MyHabits
//
//  Created by Toha Shilin on 8.08.25.
//

import UIKit

class HabitsViewController: UIViewController {
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
        collectionView.register(HabitCollectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CellReuseID.header.rawValue)
        return collectionView
    }()
    
    private enum CellReuseID: String {
        case base = "HabitCollectionViewCell_ReuseID"
        case header = "HabitCollectionHeader_ReuseID"
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
        navigationItem.largeTitleDisplayMode = .always
        dataSorceDelegate.updateStore()
        collectionView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func setupNavigationBarAppearance() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Сегодня"
        let navigationBarAppearance = UINavigationBarAppearance()
        
        navigationBarAppearance.configureWithDefaultBackground()
        navigationBarAppearance.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 0.94)
        navigationBarAppearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.systemPurple
        ]
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
    }
    
    
    @objc func plusTapped() {
        let viewController = HabitViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    

}

