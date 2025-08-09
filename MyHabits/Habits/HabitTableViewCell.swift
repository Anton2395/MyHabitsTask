//
//  HabitTableViewCell.swift
//  MyHabits
//
//  Created by Toha Shilin on 9.08.25.
//
import UIKit

class HabitTableViewCell: UITableViewCell {
    
    private lazy var habitName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "SFProText-Semibold", size: 17)
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var repeatTime: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "SFProText-Regular", size: 12)
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var counter: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var imageIndicatorView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "circle")
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        tuneView()
        addSubview()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error")
    }
    
    func tuneView() {
        backgroundColor = .white
    }
    
    func addSubview() {
        contentView.addSubview(habitName)
        contentView.addSubview(repeatTime)
        contentView.addSubview(counter)
        contentView.addSubview(imageIndicatorView)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            habitName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            habitName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            habitName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -103),
            
            repeatTime.topAnchor.constraint(equalTo: habitName.bottomAnchor, constant: 4),
            repeatTime.leadingAnchor.constraint(equalTo: habitName.leadingAnchor),
            repeatTime.trailingAnchor.constraint(equalTo: habitName.trailingAnchor),
            
            counter.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 92),
            counter.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 20),
            counter.leadingAnchor.constraint(equalTo: repeatTime.leadingAnchor),
            
            imageIndicatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            imageIndicatorView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 46),
            imageIndicatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 46),
            imageIndicatorView.heightAnchor.constraint(equalToConstant: 38),
            imageIndicatorView.widthAnchor.constraint(equalToConstant: 38)
        ])
    }
    
    func update(_ habit: Habit) {
        habitName.text = habit.name
        repeatTime.text = habit.dateString
        imageIndicatorView.image = habit.isAlreadyTakenToday ? UIImage(named: "checkmark.circle.fill") : UIImage(systemName: "circle")
        counter.text = "Счётчик: \(habit.trackDates.count)"
    }
}
