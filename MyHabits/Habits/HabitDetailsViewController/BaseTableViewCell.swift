//
//  BaseTableViewCell.swift
//  MyHabits
//
//  Created by Toha Shilin on 15.08.25.
//
import UIKit

class BaseTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        tuneView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implimented")
    }
    
    func tuneView() {
        backgroundColor = .tertiarySystemBackground
        contentView.backgroundColor = .tertiarySystemBackground
        textLabel?.backgroundColor = .clear
        detailTextLabel?.backgroundColor = .clear
        imageView?.backgroundColor = .clear
        
        accessoryView = nil
        accessoryType = .none
    }
    
    func setData(date: String?, isDone: Bool) {
        accessoryType = isDone ? .checkmark : .none
        textLabel?.text = date
    }
    
}

