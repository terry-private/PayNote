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
    
    private var categoryList: [YearMonth] = []
    // ボタン押下時の軽微な振動を追加する
    private let buttonFeedbackGenerator: UIImpactFeedbackGenerator = {
        let generator: UIImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)
        generator.prepare()
        return generator
    }()
    
    // MEMO: UICollectionViewの一番最初のセル表示位置に関する設定
    // 参考: https://www.101010.fun/entry/swift-once-exec
    private lazy var setInitialCategoryScrollTabPosition: (() -> ())? = {
        
        // 押下した場所のインデックス値を持っておくために、実際のタブ個数の2倍の値を設定する
        currentSelectIndex = self.categoryList.count * 2
        //print("初期表示時の中央インデックス値:", currentSelectIndex)
        
        // 変数(currentSelectIndex)を基準にして位置情報を更新する
        updateYearMonthScrollTabCollectionViewPosition(withAnimated: false)
        return nil
    }()
    
    // 配置したセル幅の合計値
    private var allTabViewTotalWidth: CGFloat = 0.0
    
    // 現在選択中のインデックス値を格納する変数(このクラスに配置しているUICollectionViewのIndex番号)
    private var currentSelectIndex = 0
    
    // MARK: - IBOutlet
    @IBOutlet weak private var monthlyTabCollectionView: UICollectionView!
    @IBOutlet weak private var selectedMonthUnderlineWidth: NSLayoutConstraint!
    
    
    // MARK: - Computed Properties
    
    // MEMO:
    // ここでは無限スクロールができるように予め、(実際の個数 × 4)のセルを配置している
    // またscrollViewDidScroll内の処理で所定の位置で調整をかけるので実際のUICollectionViewCellのインデックス値の範囲は下記のようになる
    // Ex. タブを6個設定する場合 → 6 ... 19が取り得る範囲となる
    
    // 表示するカテゴリーの個数を元にしたインデックスの最大値
    // 例. カテゴリーが6個の場合は5となる
    private var targetContentsMaxIndex: Int {
        return categoryList.count - 1
    }
    
    // 実際に配置したUICollectionViewCellが取り得るインデックスの最大値
    // 例. カテゴリーが6個の場合は19となる
    private var targetCollectionViewCellMaxIndex: Int {
        return categoryList.count * 4 - targetContentsMaxIndex
    }
    
    // 実際に配置したUICollectionViewCellが取り得るインデックスの最小値
    // 例. カテゴリーが6個の場合は6となる
    private var targetCollectionViewCellMinIndex: Int {
        return categoryList.count
    }
    
    // MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    // MARK: - Function

    // 親(ArticleViewController)のUIPageViewControllerのスクロール方向を元にUICollectionViewの位置を設定する
    // MEMO: このメソッドはUIPageViewControllerを配置している親(ArticleViewController)から実行される
    func moveToCategoryScrollTab(isIncrement: Bool = true) {

        // UIPageViewControllerのスワイプ方向を元に、更新するインデックスの値を設定する
        var targetIndex = isIncrement ? currentSelectIndex + 1 : currentSelectIndex - 1
        
        // 取りうるべきインデックスの値が閾値(targetCollectionViewCellMaxIndex)を超えた場合は補正をする
        if targetIndex > targetCollectionViewCellMaxIndex {
            targetIndex = targetCollectionViewCellMaxIndex - targetContentsMaxIndex
            currentSelectIndex = targetCollectionViewCellMaxIndex
        }
        
        // 取りうるべきインデックスの値が閾値(targetCollectionViewCellMinIndex)を下回った場合は補正をする
        if targetIndex < targetCollectionViewCellMinIndex {
            targetIndex = targetCollectionViewCellMinIndex + targetContentsMaxIndex
            currentSelectIndex = targetCollectionViewCellMinIndex
        }
        
        // MEMO: タブがスクロールされている状態でUIPageViewControllerがスワイプされた場合の考慮
        // → スクロール中である場合には強制的に慣性スクロールを停止させる
        let isScrolling = (monthlyTabCollectionView.isDragging || monthlyTabCollectionView.isDecelerating)
        if isScrolling {
            monthlyTabCollectionView.setContentOffset(monthlyTabCollectionView.contentOffset, animated: true)
        }
        
        // 押下した場所のインデックス値を持っておく
        currentSelectIndex = targetIndex
        //print("コンテンツ表示側のインデックスを元にした現在のインデックス値:", currentSelectIndex)
        
        // 変数(currentSelectIndex)を基準にして位置情報を更新する
        updateYearMonthScrollTabCollectionViewPosition(withAnimated: true)
        
        // 「コツッ」とした感じの端末フィードバックを発火する
        buttonFeedbackGenerator.impactOccurred()
    }
    
    // MARK: - Private Function

    // UICollectionViewに関する設定
    private func setupCategoryScrollTabCollectionView() {
        monthlyTabCollectionView.delegate = self
        monthlyTabCollectionView.dataSource = self
        monthlyTabCollectionView.register(R.nib.monthlyTabCollectionViewCell)
        monthlyTabCollectionView.showsHorizontalScrollIndicator = false

        // MEMO: タブ内のスクロール移動を許可する場合はtrueにし、許可しない場合はfalseとする
        monthlyTabCollectionView.isScrollEnabled = true
    }
    

    // 選択もしくはスクロールが止まるであろう位置にあるセルのインデックス値を元にUICollectionViewの位置を更新する
    private func updateYearMonthScrollTabCollectionViewPosition(withAnimated: Bool = false) {

        // インデックス値に相当するタブを真ん中に表示させる
        let targetIndexPath = IndexPath(row: currentSelectIndex, section: 0)
        monthlyTabCollectionView.scrollToItem(at: targetIndexPath, at: .centeredHorizontally, animated: withAnimated)

        // UICollectionViewの下線の長さを設定する
        let categoryListIndex = currentSelectIndex % categoryList.count
        setUnderlineWidthFrom(yearMonthTitle: categoryList[categoryListIndex].description)

        // 現在選択されている位置に色を付けるためにCollectionViewをリロードする
        monthlyTabCollectionView.reloadData()
    }
    
    // スクロールするタブの下にある下線の幅を文字の長さに合わせて設定する
    private func setUnderlineWidthFrom(yearMonthTitle: String) {

        // 下線用のViewに付与したAutoLayoutの幅に関する制約値を更新する
        let targetWidth = MonthlyTabCollectionViewCell.calculateCategoryUnderBarWidthBy(title: yearMonthTitle)
        selectedMonthUnderlineWidth.constant = targetWidth
        UIView.animate(withDuration: 0.36, animations: {
            self.view.layoutIfNeeded()
        })
    }
}


extension MonthlyTabViewController: UICollectionViewDelegate {}

extension MonthlyTabViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // MEMO: 無限スクロールの対象とする場合はタブ表示要素の4倍余分に要素を表示する
        return categoryList.count * 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    
}
