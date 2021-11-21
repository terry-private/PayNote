//
//  YearMonthScrollTabViewController.swift
//  PayNote
//
//  Created by 若江照仁 on 2021/10/06.
//

import UIKit

protocol MonthlyTabDelegate: AnyObject {
    // UIPageViewControllerで表示しているインデックスの画面へ遷移する
    func moveToDateScrollContents(selectedCollectionViewIndex: Int, targetDirection: UIPageViewController.NavigationDirection, withAnimated: Bool)
}

class MonthlyTabViewController: UIViewController, Transitioner {
    // CategoryScrollTabDelegateプロトコル
    weak var delegate: MonthlyTabDelegate?
    lazy var flowLayout = CategoryScrollTabViewFlowLayout()

    private var yearMonthList: [YearMonth] = PayNote.monthlyNotes.keys.sorted { $0.value < $1.value }
    // ボタン押下時の軽微な振動を追加する
    private let buttonFeedbackGenerator: UIImpactFeedbackGenerator = {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.prepare()
        return generator
    }()

    // MEMO: UICollectionViewの一番最初のセル表示位置に関する設定
    private lazy var setInitialMonthlyTabPosition: (() -> Void)? = {

        // 押下した場所のインデックス値を持っておくために、実際のタブ個数の2倍の値を設定する
        currentSelectIndex = self.yearMonthList.count - 1
        // 変数(currentSelectIndex)を基準にして位置情報を更新する
        updateMonthlyTabCollectionViewPosition(withAnimated: false)
        return nil
    }()

    // 配置したセル幅の合計値
    private var allTabViewTotalWidth: CGFloat = 0.0

    // 現在選択中のインデックス値を格納する変数(このクラスに配置しているUICollectionViewのIndex番号)
    private var currentSelectIndex = 0

    // MARK: - IBOutlet
    @IBOutlet private weak var monthlyTabCollectionView: UICollectionView!
    @IBOutlet private weak var selectedMonthUnderlineWidth: NSLayoutConstraint!

    // MARK: - Computed Properties
    private var targetContentsMaxIndex: Int {
        yearMonthList.count - 1
    }

    // 実際に配置したUICollectionViewCellが取り得るインデックスの最大値
    // 例. カテゴリーが6個の場合は19となる
    private var targetCollectionViewCellMaxIndex: Int {
        yearMonthList.count
    }

    // 実際に配置したUICollectionViewCellが取り得るインデックスの最小値
    // 例. カテゴリーが6個の場合は6となる
    private var targetCollectionViewCellMinIndex: Int {
        0 // yearMonthList.count
    }

    // MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMonthlyTabCollectionView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setInitialMonthlyTabPosition?()
    }

    // MARK: - Function

    // 親(ArticleViewController)のUIPageViewControllerのスクロール方向を元にUICollectionViewの位置を設定する
    // MEMO: このメソッドはUIPageViewControllerを配置している親(ArticleViewController)から実行される
    func moveToCategoryScrollTab(to index: Int) {

        // UIPageViewControllerのスワイプ方向を元に、更新するインデックスの値を設定する
        currentSelectIndex = index

        // MEMO: タブがスクロールされている状態でUIPageViewControllerがスワイプされた場合の考慮
        // → スクロール中である場合には強制的に慣性スクロールを停止させる
        let isScrolling = (monthlyTabCollectionView.isDragging || monthlyTabCollectionView.isDecelerating)
        if isScrolling {
            monthlyTabCollectionView.setContentOffset(monthlyTabCollectionView.contentOffset, animated: true)
        }
        // 変数(currentSelectIndex)を基準にして位置情報を更新する
        updateMonthlyTabCollectionViewPosition(withAnimated: true)

        // 「コツッ」とした感じの端末フィードバックを発火する
        buttonFeedbackGenerator.impactOccurred()
    }

    // MARK: - Private Function

    // UICollectionViewに関する設定
    private func setupMonthlyTabCollectionView() {
        monthlyTabCollectionView.delegate = self
        monthlyTabCollectionView.dataSource = self
        monthlyTabCollectionView.register(R.nib.monthlyTabCollectionViewCell)
        monthlyTabCollectionView.showsHorizontalScrollIndicator = false

        flowLayout.scrollDirection = .horizontal
        let space = monthlyTabCollectionView.bounds.width * 0.5
        flowLayout.minimumLineSpacing = 0
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: space, bottom: 0, right: space)
        monthlyTabCollectionView.collectionViewLayout = flowLayout
        // MEMO: タブ内のスクロール移動を許可する場合はtrueにし、許可しない場合はfalseとする
        monthlyTabCollectionView.isScrollEnabled = true
    }

    // 選択もしくはスクロールが止まるであろう位置にあるセルのインデックス値を元にUICollectionViewの位置を更新する
    private func updateMonthlyTabCollectionViewPosition(withAnimated: Bool = false) {

        // インデックス値に相当するタブを真ん中に表示させる
        let targetIndexPath = IndexPath(row: currentSelectIndex, section: 0)
        monthlyTabCollectionView.scrollToItem(at: targetIndexPath, at: .centeredHorizontally, animated: withAnimated)

        // UICollectionViewの下線の長さを設定する
        let categoryListIndex = currentSelectIndex % yearMonthList.count
        setUnderlineWidthFrom(yearMonthTitle: yearMonthList[categoryListIndex].description)

        // 現在選択されている位置に色を付けるためにCollectionViewをリロードする
        monthlyTabCollectionView.reloadData()
    }

    // スクロールするタブの下にある下線の幅を文字の長さに合わせて設定する
    private func setUnderlineWidthFrom(yearMonthTitle: String) {

        // 下線用のViewに付与したAutoLayoutの幅に関する制約値を更新する
        let targetWidth = MonthlyTabCollectionViewCell.calculateCategoryUnderBarWidthBy(title: yearMonthTitle)
        selectedMonthUnderlineWidth.constant = targetWidth
        UIView.animate(withDuration: 0.36) {
            self.view.layoutIfNeeded()
        }
    }

    private func transformScale(cell: UICollectionViewCell) {
        let cellCenter: CGPoint = monthlyTabCollectionView.convert(cell.center, to: nil)
        let screenCenterX: CGFloat = UIScreen.main.bounds.width / 2
        let reductionRatio: CGFloat = -0.0025
        let maxScale: CGFloat = 1
        let cellCenterDisX: CGFloat = abs(screenCenterX - cellCenter.x)
        let newScale = reductionRatio * cellCenterDisX + maxScale
        cell.transform = CGAffineTransform(scaleX: newScale, y: newScale)
    }
}

extension MonthlyTabViewController: UICollectionViewDelegate {}

extension MonthlyTabViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // MEMO: 無限スクロールの対象とする場合はタブ表示要素の4倍余分に要素を表示する
        return yearMonthList.count // * 4
    }

    // 配置するセルの表示内容を設定する
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.monthlyTabCollectionViewCell.identifier, for: indexPath) as? MonthlyTabCollectionViewCell ?? MonthlyTabCollectionViewCell()
        let targetIndex = indexPath.row // % yearMonthList.count
        let isSelectedTab = indexPath.row == currentSelectIndex
        cell.setYearMonth(yearMonth: yearMonthList[targetIndex], isSelected: isSelectedTab)
        transformScale(cell: cell)
        return cell
    }
}

extension MonthlyTabViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return MonthlyTabCollectionViewCell.cellSize
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        flowLayout.prepareForPaging()
    }
}

extension MonthlyTabViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        monthlyTabCollectionView.visibleCells.forEach { cell in
            transformScale(cell: cell)
        }
    }
    // 配置したUICollectionViewをスクロールが止まった際に実行される処理
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var targetIndexPath: IndexPath?
        for cell in monthlyTabCollectionView.visibleCells {
            let cellCenter: CGFloat = monthlyTabCollectionView.convert(cell.center, to: nil).x
            let screenCenterX: CGFloat = UIScreen.main.bounds.width / 2
            if screenCenterX - 1 < cellCenter && cellCenter < screenCenterX + 1 {
                targetIndexPath = monthlyTabCollectionView.indexPath(for: cell)
                break
            }
        }
        guard let targetIndexPath = targetIndexPath else {
            return
        }

        // ※この部分は厳密には不要ではあるがdelegeteで引き渡す必要があるので設定している
        let targetDirection: UIPageViewController.NavigationDirection = currentSelectIndex - targetIndexPath.row > 0 ? .reverse : .forward

        // 押下した場所のインデックス値を現在のインデックス値を格納している変数(currentSelectIndex)にセットする
        currentSelectIndex = targetIndexPath.row
        //print("スクロールが慣性で停止した時の中央インデックス値:", currentSelectIndex)

        // 変数(currentSelectIndex)を基準にして位置情報を更新する
        updateMonthlyTabCollectionViewPosition(withAnimated: true)

        // 算出した現在のインデックス値・動かす方向の値を元に、UIPageViewControllerで表示しているインデックスの画面へ遷移する
        delegate?.moveToDateScrollContents(
            selectedCollectionViewIndex: currentSelectIndex,
            targetDirection: targetDirection,
            withAnimated: false
        )

        // 「コツッ」とした感じの端末フィードバックを発火する
        buttonFeedbackGenerator.impactOccurred()
    }
}
