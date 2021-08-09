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
    @IBOutlet private weak var monthlyBalanceCollectionView: UICollectionView!
    @IBOutlet private weak var mainCategoryTableView: UITableView!

    var presenter: HomePresenterProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        mainCategoryTableView.dataSource = self
        mainCategoryTableView.delegate = self
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat(136)
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let mainCategoryTableViewCell = R.nib.mainCategoryTableViewCell(owner: nil)!
        return mainCategoryTableViewCell
    }
}
