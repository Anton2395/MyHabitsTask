//
//  HabitCollectionHeader.swift
//  MyHabits
//
//  Created by Toha Shilin on 16.08.25.
//
import UIKit

class HabitCollectionHeader: UICollectionReusableView {
    
    private lazy var container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 8
        return view
    }()
    
    
    private lazy var progressView: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .default)
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.progressTintColor = UIColor(red: 161/155, green: 22/255, blue: 204/255, alpha: 1.0)
        progress.trackTintColor = UIColor(red: 216/155, green: 216/255, blue: 216/255, alpha: 1.0)
        progress.layer.cornerRadius = 5
        progress.clipsToBounds = true
        return progress
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Всё получится!"
        label.textColor = UIColor(red: 142/255, green: 142/255, blue: 147/255, alpha: 1)
        label.font = UIFont(name: "SFProText-Semibold", size: 13)
        return label
    }()
    
    private lazy var progresLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0%"
        label.textColor = UIColor(red: 142/255, green: 142/255, blue: 147/255, alpha: 1)
        label.font = UIFont(name: "SFProText-Semibold", size: 13)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setSubviews()
        setConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Dont use coder")
    }
    
    
    func setSubviews() {
        container.addSubview(textLabel)
        container.addSubview(progressView)
        container.addSubview(progresLabel)
        addSubview(container)
    }
    
    func setConstraints() {
        let safeArea = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            container.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            container.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 22),
            container.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            
            textLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12),
            textLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 10),
            
            progresLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -12),
            progresLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 10),
            
            progressView.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 10),
            progressView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12),
            progressView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -12),
            progressView.heightAnchor.constraint(equalToConstant: 7),
            progressView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -15),
        ])
    }
    
    func updateParam(progress: Float) {
        progressView.progress = progress
        progresLabel.text = "\(Int(progress*100))%"
    }
}
