//
//  UITableView+Extention.swift
//  MyHabits
//
//  Created by Toha Shilin on 15.08.25.
//
import UIKit

extension UITableView {
    
    func setAndlayout(headerView: UIView) {
        tableHeaderView = headerView
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.widthAnchor.constraint(equalTo: widthAnchor)
        ])
        
        headerView.setNeedsLayout()
        headerView.layoutIfNeeded()
        headerView.frame.size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }
}
