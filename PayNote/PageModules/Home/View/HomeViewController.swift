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
    var presenter: HomePresenterProtocol?

    private let monthList: [YearMonth] = PayNote.monthlyNotes.keys.sorted { $0.key < $1.key }
    private var currentMonthIndex: Int = 0
    private var targetViewControllerLists: [UIViewController] = []
    // ContainerViewにEmbedしたUIPageViewControllerのインスタンスを保持する
    private var pageViewController: UIPageViewController?

    // MARK: - IBOutlet

    // MARK: - LifeCircle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPageViewController()
        currentMonthIndex = monthList.count - 1
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case R.segue.homeViewController.dateScrollTabViewContainer.identifier:
            let vc = segue.destination as? MonthlyTabViewController
            vc?.delegate = self
        default:
            break
        }
    }

    private func setupPageViewController() {

        for yearMonthKey in PayNote.firstYearMonth.key ... YearMonth(Date()).key {
            let yearMonth = YearMonth(key: yearMonthKey)
            let vc = R.storyboard.home.monthlyContentViewController()!
            vc.view.tag = yearMonthKey - PayNote.firstYearMonth.key
            vc.setMonthlyNote(monthlyNote: PayNote.monthlyNotes[yearMonth])
            targetViewControllerLists.append(vc)
        }
        // UIPageViewControllerで表示させるViewControllerの一覧を配列へ格納する
//        _ = monthList.enumerated().map { index, yearMonth in
//            let vc = R.storyboard.home.monthlyContentViewController()!
//            vc.view.tag = index
//            vc.setMonthlyNote(monthlyNote: PayNote.monthlyNotes.values.first!)
//            vc.setMonthlyNote(monthlyNote: PayNote.monthlyNotes[yearMonth]!)
//            targetViewControllerLists.append(vc)
//        }

        // ContainerViewにEmbedしたUIPageViewControllerを取得する
        for childVC in children {
            if let targetVC = childVC as? UIPageViewController {
                pageViewController = targetVC
            }
        }

        // UIPageViewControllerDelegate & UIPageViewControllerDataSourceの宣言
        pageViewController!.delegate = self
        pageViewController!.dataSource = self

        // 最初に表示する画面として配列の最後のViewControllerを設定する
        pageViewController!.setViewControllers([targetViewControllerLists.last!], direction: .forward, animated: false, completion: nil)
    }

    private func updateMonthScrollTabPosition(to index: Int) {
        for childVC in children {
            if let targetVC = childVC as? MonthlyTabViewController {
                targetVC.moveToCategoryScrollTab(to: index)
            }
        }
    }
}

// MARK: - YearMonthScrollTabDelegate
extension HomeViewController: MonthlyTabDelegate {
    func moveToDateScrollContents(selectedCollectionViewIndex: Int, targetDirection: UIPageViewController.NavigationDirection, withAnimated: Bool) {
        // UIPageViewControllerに設定した画面の表示対象インデックス値を設定する
        // MEMO: タブ表示のUICollectionViewCellのインデックス値をカテゴリーの個数で割った剰余
        currentMonthIndex = selectedCollectionViewIndex

        // 表示対象インデックス値に該当する画面を表示する
        // MEMO: メインスレッドで実行するようにしてクラッシュを防止する対策を施している
        DispatchQueue.main.async {
            if let targetPageViewController = self.pageViewController {
                targetPageViewController.setViewControllers([self.targetViewControllerLists[self.currentMonthIndex]], direction: targetDirection, animated: withAnimated, completion: nil)
            }
        }
    }
}

// MARK: - UIPageViewControllerDelegate
extension HomeViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {

        // スワイプアニメーションが完了していない時には処理をさせなくする
        if !completed {
            return
        }
    
        // ここから先はUIPageViewControllerのスワイプアニメーション完了時に発動する
        if let targetViewControllers = pageViewController.viewControllers {
            if let targetViewController = targetViewControllers.last {
                let nextIndex = targetViewController.view.tag
                updateMonthScrollTabPosition(to: nextIndex)

                // 受け取ったインデックス値を元にコンテンツ表示を更新する
                currentMonthIndex = nextIndex
            }
        }
    }
}

// MARK: - UIPageViewControllerDataSource
extension HomeViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = targetViewControllerLists.firstIndex(of: viewController) else {
            return nil
        }

        return index > 0 ? targetViewControllerLists[index - 1] : nil
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = targetViewControllerLists.firstIndex(of: viewController) else {
            return nil
        }

        return index < monthList.count - 1 ? targetViewControllerLists[index + 1] : nil
    }

}
