//
//  HabitDetalisTableDataSorceDelegate.swift
//  MyHabits
//
//  Created by Toha Shilin on 15.08.25.
//
import UIKit

class HabitDetalisTableDataSorceDelegate: NSObject, UITableViewDataSource, UITableViewDelegate {
    var store = HabitsStore.shared
    var habit: Habit
        
    
    init(habit: Habit) {
        self.habit = habit
        super.init()
    }
    
    func updateStore() {
        store = HabitsStore.shared
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        store.dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "BaseTableViewCell_ReuseID",
            for: indexPath
        ) as? BaseTableViewCell else {
            fatalError("could not dequeueReusableCell")
        }
        
        let reversedIndex = store.dates.count - 1 - indexPath.row
        let date = store.dates[reversedIndex]
        cell.setData(date: store.trackDateString(forIndex: reversedIndex), isDone: store.habit(habit, isTrackedIn: date))
        
        return cell
    }
}
