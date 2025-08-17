//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Toha Shilin on 15.08.25.
//
import UIKit

class HabitDetailsViewController: UIViewController {
    let habit: Habit
    private let dataSorceDelegate: HabitDetalisTableDataSorceDelegate
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1)
        return tableView
    }()
    
    init(habit: Habit) {
        self.habit = habit
        self.dataSorceDelegate = HabitDetalisTableDataSorceDelegate(habit: habit)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private enum CellReuseID: String {
        case base = "BaseTableViewCell_ReuseID"
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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Править",
            style: .plain,
            target: self,
            action: #selector(tapEdit)
        )
        let leftButton = UIBarButtonItem(
            image: UIImage(systemName: "chevron.backward"),
            style: .plain,
            target: self,
            action: #selector(tapToday)
        )
        let textButton = UIBarButtonItem(
            title: "Сегодня",
            style: .plain,
            target: self,
            action: #selector(tapToday)
        )
        navigationItem.leftBarButtonItems = [leftButton, textButton]
        navigationItem.titleView?.tintColor = .black
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        dataSorceDelegate.updateStore()
        tableView.reloadData()
        setupView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setSubviews()
        setConstrains()
        
        tuneTable()
        setupNavigationBarAppearance()
    }
    
    public func setupView() {
        title = habit.name
        view.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1)
    }
    
    func setSubviews() {
        view.addSubview(tableView)
    }
    
    func setConstrains() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
    }
    
    func tuneTable() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50.0
        
        let headerView = makeHeaderViewForTable()
        tableView.setAndlayout(headerView: headerView)
        tableView.tableFooterView = UIView()
        
        tableView.register(BaseTableViewCell.self, forCellReuseIdentifier: CellReuseID.base.rawValue)
        
        tableView.dataSource = dataSorceDelegate
        tableView.delegate = dataSorceDelegate
    }
    
    func makeHeaderViewForTable() -> UIView {
        let headerView = UIView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
//        headerView.backgroundColor = .white
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "АКТИВНОСТЬ"
        label.textColor = UIColor(red: 60/255, green: 60/255, blue: 67/255, alpha: 0.6)
        label.font = UIFont(name: "SFProText-Regular", size: 13)
        
        headerView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -11),
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            label.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 22),
            label.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16)
        ])
        
        return headerView
    }
    
    @objc func tapToday() {
        navigationController?.popViewController(animated:true)
    }
    
    @objc func tapEdit() {
        let editeView = HabitViewController(habit: habit)
        
        navigationController?.pushViewController(editeView, animated: true)
    }
}
