//
//  MonthlyContentViewController.swift
//  PayNote
//
//  Created by 若江照仁 on 2021/10/16.
//

import UIKit

class MonthlyContentViewController: UIViewController, Transitioner {
    // IBOutlet
    @IBOutlet weak private var mainCategoryCollectionViewController: UICollectionView!
    private var monthlyNote: MonthlyNote! {
        didSet {
            mainCategoryCollectionViewController.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        mainCategoryCollectionViewController.register(MonthlyContentHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: R.reuseIdentifier.monthlyHeaderCollectionReusableView.identifier)
    }
    func setMonthlyNote(monthlyNote: MonthlyNote) {
        self.monthlyNote = monthlyNote
    }
}

extension MonthlyContentViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: R.reuseIdentifier.monthlyHeaderCollectionReusableView.identifier, for: indexPath) as? MonthlyContentHeaderCollectionReusableView else {
            fatalError("ヘッダーがありません")
          }
        
        return header
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        switch indexPath.row {
//        case 0:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.mainCategoryHeaderCollectionViewCell, for: indexPath)!
//            return cell
//        default:
//            let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.mainCategoryCollectionViewCell, for: indexPath)!
//            return cell
//        }
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.mainCategoryCollectionViewCell, for: indexPath)!
        return cell
    }
}

extension MonthlyContentViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: 300, height: 300)
    }
}
