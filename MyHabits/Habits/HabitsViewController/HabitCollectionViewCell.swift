//
//  HabitTableViewCell.swift
//  MyHabits
//
//  Created by Toha Shilin on 9.08.25.
//
import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    var onToggle: (() -> Void)?
    private var habit: Habit?
    
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
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var counter: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "SFProText-Regular", size: 13)
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var imageIndicatorView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "circle")
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapToSwitcher))
        imageView.addGestureRecognizer(tapGesture)
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        tuneView()
        addSubview()
        setConstraints()
    }
    
    func tuneView() {
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = .white
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
            counter.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            counter.leadingAnchor.constraint(equalTo: repeatTime.leadingAnchor),
            
            imageIndicatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            imageIndicatorView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageIndicatorView.heightAnchor.constraint(equalToConstant: 38),
            imageIndicatorView.widthAnchor.constraint(equalToConstant: 38)
        ])
    }
    
    func update(_ habit: Habit) {
        self.habit = habit
        habitName.text = habit.name
        habitName.textColor = habit.color
        repeatTime.text = habit.dateString
        imageIndicatorView.image = habit.isAlreadyTakenToday ? UIImage(systemName: "checkmark.circle.fill") : UIImage(systemName: "circle")
        imageIndicatorView.tintColor = habit.color
        counter.text = "Счётчик: \(habit.trackDates.count)"
    }
    
    @objc func tapToSwitcher() {
        guard let habit = habit else { return }
        
        if !habit.isAlreadyTakenToday {
            HabitsStore.shared.track(habit)
            update(habit)
            UIView.animate(withDuration: 0.2, animations: {
                self.imageIndicatorView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            }) { _ in
                UIView.animate(withDuration: 0.2) {
                    self.imageIndicatorView.transform = .identity
                }
            }
            
            onToggle?()
        }
    }
}
