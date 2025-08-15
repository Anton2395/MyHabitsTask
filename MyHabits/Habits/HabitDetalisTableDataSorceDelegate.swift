//
//  HabitDetalisTableDataSorceDelegate.swift
//  MyHabits
//
//  Created by Toha Shilin on 15.08.25.
//
import UIKit

class HabitDetalisTableDataSorceDelegate: NSObject, UITableViewDataSource, UITableViewDelegate {
    let store = HabitsStore.shared
    var habit: Habit
    var dateList: [String?] = []
        
    
    init(habit: Habit) {
        self.habit = habit
        super.init()
        self.dateList = makeDateList()
    }
    
    func makeDateList() -> [String?] {
        var dateList: [String?] = []
        for (index, _) in store.dates.enumerated() {
//            print(index, store.dates.count, date)
//            if index == store.dates.count-1 {
//                dateList.append("Вчера")
//            } else if index == store.dates.count-2 {
//                dateList.append("Позавчера")
//            } else {
            dateList.append(store.trackDateString(forIndex: index))
//            }
        }
        return dateList
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
        
        cell.setData(date: store.trackDateString(forIndex: indexPath.row), isDone: store.habit(habit, isTrackedIn: store.dates[indexPath.row]))
        
        return cell
    }
}
