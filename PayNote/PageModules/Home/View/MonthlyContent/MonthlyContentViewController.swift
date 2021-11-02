//
//  MonthlyContentViewController.swift
//  PayNote
//
//  Created by 若江照仁 on 2021/10/16.
//

import UIKit

class MonthlyContentViewController: UIViewController, Transitioner {
    // IBOutlet
    @IBOutlet private weak var mainCategoryCollectionView: UICollectionView!
    private var monthlyNote: MonthlyNote! {
        didSet {
            mainCategoryCollectionView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainCategoryCollectionView()
    }
    func setMonthlyNote(monthlyNote: MonthlyNote) {
        self.monthlyNote = monthlyNote
    }

    private func setupMainCategoryCollectionView() {
        mainCategoryCollectionView.delegate = self
        mainCategoryCollectionView.dataSource = self
//        mainCategoryCollectionView.register(MainCategoryCollectionViewCell.self, forCellWithReuseIdentifier: R.reuseIdentifier.mainCategoryCollectionViewCell.identifier)
//        mainCategoryCollectionView.register(MonthlyContentHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: R.reuseIdentifier.monthlyHeaderCollectionReusableView.identifier)
        mainCategoryCollectionView.register(UINib(resource: R.nib.monthlyContentHeaderCollectionReusableView), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: R.reuseIdentifier.monthlyContentHeaderCollectionReusableView.identifier)
//        guard let fl = mainCategoryCollectionView?.collectionViewLayout as? UICollectionViewFlowLayout else {
//            return
//            
//        }
//        fl.headerReferenceSize = CGSize(width: view.bounds.width, height: 30)
    }
}

extension MonthlyContentViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: R.reuseIdentifier.monthlyContentHeaderCollectionReusableView, for: indexPath) else {
            fatalError("ヘッダーがありません")
          }
        header.monthlyNote = monthlyNote
        return header
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        monthlyNote.mainNotes.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.mainCategoryCollectionViewCell, for: indexPath)!
        cell.mainNote = Array(monthlyNote.mainNotes.values)[indexPath.row]
        return cell
    }
}

extension MonthlyContentViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: Const.MonthlyContent.headerWidth, height: Const.MonthlyContent.headerHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.bounds.width - Const.MonthlyContent.cellSidePads, height: Const.MonthlyContent.cellHeight)
    }

}
