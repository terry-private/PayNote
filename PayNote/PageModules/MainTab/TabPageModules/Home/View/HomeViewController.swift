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

    private let monthList: [YearMonth] = PayNote.monthlyNotes.keys.sorted { $0.value < $1.value }
    private var currentMonthIndex: Int = 0
    private var targetViewControllerLists: [UIViewController] = []
    private var monthlyTabViewController: MonthlyTabViewController?
    // ContainerViewにEmbedしたUIPageViewControllerのインスタンスを保持する
    private lazy var pageViewController: UIPageViewController? = {
        for childVC in children {
            if let targetVC = childVC as? UIPageViewController {
                return targetVC
            }
        }
        return nil
    }()

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
            monthlyTabViewController = segue.destination as? MonthlyTabViewController
            monthlyTabViewController?.delegate = self
        default:
            break
        }
    }

    private func setupPageViewController() {
        // 一番古いYearMonthから今月までのViewを作成
        for yearMonthKey in PayNote.firstYearMonth.value ... YearMonth(Date()).value {
            let yearMonth = YearMonth(value: yearMonthKey)
            let vc = R.storyboard.home.monthlyContentViewController()!
            vc.view.tag = yearMonthKey - PayNote.firstYearMonth.value
            vc.setMonthlyNote(monthlyNote: PayNote.monthlyNotes[yearMonth] ?? .init(yearMonth: yearMonth))
            targetViewControllerLists.append(vc)
        }
        // UIPageViewControllerDelegate & UIPageViewControllerDataSourceの宣言
        pageViewController!.delegate = self
        pageViewController!.dataSource = self

        // 最初に表示する画面として配列の最後のViewControllerを設定する
        pageViewController!.setViewControllers([targetViewControllerLists.last!], direction: .forward, animated: false, completion: nil)
    }
}

// MARK: - YearMonthScrollTabDelegate
extension HomeViewController: MonthlyTabDelegate {
    func moveToDateScrollContents(selectedCollectionViewIndex: Int, targetDirection: UIPageViewController.NavigationDirection, withAnimated: Bool) {
        currentMonthIndex = selectedCollectionViewIndex

        // 表示対象インデックス値に該当する画面を表示する
        // MEMO: メインスレッドで実行するようにしてクラッシュを防止する対策を施している
        DispatchQueue.main.async {
            self.pageViewController?.setViewControllers([self.targetViewControllerLists[self.currentMonthIndex]], direction: targetDirection, animated: withAnimated, completion: nil)
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
        // 残っているviewControllersの中の最後が遷移先のViewController
        if let targetViewController = pageViewController.viewControllers?.last {
            let nextIndex = targetViewController.view.tag
            monthlyTabViewController?.moveToCategoryScrollTab(to: nextIndex)
            // 受け取ったインデックス値を元にコンテンツ表示を更新する
            currentMonthIndex = nextIndex
        }
    }
}

// MARK: - UIPageViewControllerDataSource
extension HomeViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentYearMonth = (viewController as? MonthlyContentViewController)?.monthlyNote?.yearMonth else {
            return nil
        }
        let index = currentYearMonth.value - PayNote.firstYearMonth.value
        return index > 0 ? targetViewControllerLists[index - 1] : nil
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentYearMonth = (viewController as? MonthlyContentViewController)?.monthlyNote?.yearMonth else {
            return nil
        }
        let index = currentYearMonth.value - PayNote.firstYearMonth.value
        return index < monthList.count - 1 ? targetViewControllerLists[index + 1] : nil
    }

}
