
//
//  HabitsTable.swift
//  MyHabits
//
//  Created by Toha Shilin on 11.08.25.
//
import UIKit

class HabitsCollectionDataSorceDelegate: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private var store = HabitsStore.shared
    weak var navigationController: UINavigationController?
    
    func updateStore() {
        store = HabitsStore.shared
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        store.habits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "HabitCollectionViewCell_ReuseID",
            for: indexPath
        ) as! HabitCollectionViewCell
        let habit = store.habits[indexPath.row]
        cell.update(habit)
        cell.onToggle = { [weak collectionView, weak self] in
            self?.updateStore()
            collectionView?.reloadData()
        }
        return cell
    }
    
    private func itemWidth(for width: CGFloat, spacing: CGFloat) -> CGFloat {
        let itemsInRow: CGFloat = 1
        let totalSpacing = 2 * spacing + (itemsInRow - 1) * spacing
        let availableWidth = width - totalSpacing
        return availableWidth / itemsInRow
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let spacing: CGFloat = 16.0
        let width = itemWidth(for: collectionView.frame.width, spacing: spacing)
        return CGSize(width: width, height: 130)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        UIEdgeInsets(
            top: 22.0,
            left: 0.0,
            bottom: 22.0,
            right: 0.0
        )
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        12.0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let view = HabitDetailsViewController(habit: store.habits[indexPath.row])
        navigationController?.pushViewController(view, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
            
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HabitCollectionHeader_ReuseID", for: indexPath) as! HabitCollectionHeader
            header.updateParam(progress: store.todayProgress)
            return header
        default:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 82.0)
    }

}
