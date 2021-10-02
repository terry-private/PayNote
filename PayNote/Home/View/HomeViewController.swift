//
//  HomeViewController.swift
//  PayNote
//
//  Created by 若江照仁 on 2021/06/26.
//

import UIKit

protocol HomeViewProtocol: Transitioner {
    var presenter: HomePresenterProtocol? { get set }
}

class HomeViewController: UIViewController, HomeViewProtocol {
    // MARK: - IBOutlet
    @IBOutlet private weak var monthlyHeaderCollectionView: UICollectionView!
    @IBOutlet private weak var mainCategoryTableView: UITableView!

    var presenter: HomePresenterProtocol?
    lazy var flowLayout = FlowLayout()
    
    // MARK: - LifeCircle
    override func viewDidLoad() {
        super.viewDidLoad()
        mainCategoryTableView.dataSource = self
        mainCategoryTableView.delegate = self
        mainCategoryTableView.register(R.nib.mainCategoryTableViewCell)

        monthlyHeaderCollectionView.dataSource = self
        monthlyHeaderCollectionView.delegate = self
        monthlyHeaderCollectionView.register(R.nib.monthlyHeaderCollectionViewCell)
        flowLayout.scrollDirection = .horizontal
        let space = monthlyHeaderCollectionView.bounds.width * 0.15
        flowLayout.minimumLineSpacing = 0
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: space, bottom: 0, right: space)
        monthlyHeaderCollectionView.collectionViewLayout = flowLayout
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        monthlyHeaderCollectionView.scrollToItem(at: IndexPath(row: 9, section: 0), at: .centeredHorizontally, animated: true)
    }

    private func transformScale(cell: UICollectionViewCell) {
        let cellCenter: CGPoint = monthlyHeaderCollectionView.convert(cell.center, to: nil)
        let screenCenterX: CGFloat = UIScreen.main.bounds.width / 2
        let reductionRatio: CGFloat = -0.0005
        let maxScale: CGFloat = 1
        let cellCenterDisX: CGFloat = abs(screenCenterX - cellCenter.x)
        let newScale = reductionRatio * cellCenterDisX + maxScale
        cell.transform = CGAffineTransform(scaleX: newScale, y: newScale)
    }
    
}

// MARK: - monthlyHeaderCollectionView
extension HomeViewController: UICollectionViewDelegate {

}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.monthlyHeaderCollectionViewCell, for: indexPath)!
        return cell
    }

}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: collectionView.bounds.width * 0.7,
            height: collectionView.bounds.height * 0.9
        )
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        flowLayout.prepareForPaging()
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        monthlyHeaderCollectionView.visibleCells.forEach { cell in
            transformScale(cell: cell)
        }
    }
}

// MARK: - mainCategoryTableView
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat(136)
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        20
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let mainCategoryTableViewCell = R.nib.mainCategoryTableViewCell(owner: nil)!
        return mainCategoryTableViewCell
    }
}
