//
//  MonthlyTabViewFlowLayout.swift
//  PayNote
//
//  Created by 若江照仁 on 2021/10/31.
//

import UIKit

final class CategoryScrollTabViewFlowLayout: UICollectionViewFlowLayout {
    private var layoutAttributesForPaging: [UICollectionViewLayoutAttributes]?

    // 参考1: 下記のリンクで紹介されていたTIPSを元に実装しました
    // https://uruly.xyz/carousel-infinite-scroll-3/

    // 参考2: UICollectionViewのlayoutAttributeの変更タイミングに関する記事
    // https://qiita.com/kazuhiro4949/items/03bc3d17d3826aa197c0

    // 参考3: UICollectionViewFlowLayoutのサブクラスを利用したスクロールの停止位置算出に関する記事
    // https://dev.classmethod.jp/smartphone/iphone/collection-view-layout-cell-snap/

    // 該当のセルのオフセット値を計算するための値（スクリーンの幅 - UICollectionViewに配置しているセルの幅）
    private let horizontalTargetOffsetWidth: CGFloat = UIScreen.main.bounds.width - Const.MonthlyTag.cellWidth

    // UICollectionViewをスクロールした後の停止位置を返すためのメソッド
    // MEMO: UICollectionViewのLayoutAttributeを調整して、中央に表示されるように調整している
//    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
//
//        // 配置されているUICollectionViewを取得する
//        guard let collectionView = self.collectionView else {
//            assertionFailure("UICollectionViewが配置されていません。")
//            return CGPoint.zero
//        }
//        // UICollectionViewのオフセット値を元に該当のセルの情報を取得する
//        var offsetAdjustment = CGFloat(MAXFLOAT)
//        let horizontalOffset: CGFloat = proposedContentOffset.x + horizontalTargetOffsetWidth / 2
//        let targetRect = CGRect(
//            x: proposedContentOffset.x,
//            y: 0,
//            width: collectionView.bounds.size.width,
//            height: collectionView.bounds.size.height
//        )
//
//        // 配置されているUICollectionViewのlayoutAttributesを元にして停止させたい位置を算出する
//        guard let layoutAttributes = super.layoutAttributesForElements(in: targetRect) else {
//            assertionFailure("配置したUICollectionViewにおいて該当セルにおけるlayoutAttributesを取得できません。")
//            return CGPoint.zero
//        }
//        for layoutAttribute in layoutAttributes {
//            let itemOffset = layoutAttribute.frame.origin.x
//            if abs(itemOffset - horizontalOffset) < abs(offsetAdjustment) {
//                offsetAdjustment = itemOffset - horizontalOffset
//            }
//        }
//
//        return CGPoint(
//            x: proposedContentOffset.x + offsetAdjustment,
//            y: proposedContentOffset.y
//        )
//    }
    
    private func layoutAttributesForNearbyCenterX(in attributes: [UICollectionViewLayoutAttributes], collectionView: UICollectionView) -> UICollectionViewLayoutAttributes? {
        let screenCenterX = collectionView.contentOffset.x + collectionView.bounds.width * 0.5
        let result = attributes.reduce((attributes: nil as UICollectionViewLayoutAttributes?, distance: CGFloat.infinity)) { result, attributes in
            let distance = attributes.frame.midX - screenCenterX
            return abs(distance) < abs(result.distance) ? (attributes, distance) : result
        }
        return result.attributes
    }
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else { return proposedContentOffset }
        guard let targetAttributes = layoutAttributesForPaging else { return proposedContentOffset }
        
        let nextAttributes: UICollectionViewLayoutAttributes?
        if velocity.x == 0 {
            nextAttributes = layoutAttributesForNearbyCenterX(in: targetAttributes, collectionView: collectionView)
        } else if velocity.x > 0 {
            nextAttributes = targetAttributes.last
        } else {
            nextAttributes = targetAttributes.first
        }
        guard let attributes = nextAttributes else { return proposedContentOffset }
        
        if attributes.representedElementKind == UICollectionView.elementKindSectionHeader {
            return CGPoint(x: 0, y: collectionView.contentOffset.y)
        } else {
            let cellLeftMargin = (collectionView.bounds.width - attributes.bounds.width) * 0.5
            return CGPoint(x: attributes.frame.minX - cellLeftMargin, y: collectionView.contentOffset.y)
        }
    }
    
    func prepareForPaging() {
        guard let collectionView = collectionView else { return }
        let expansionMargin = sectionInset.left + sectionInset.right
        let expandedVisibleRect = CGRect(x: collectionView.contentOffset.x - expansionMargin,
                                         y: 0,
                                         width: collectionView.bounds.width + (expansionMargin * 2),
                                         height: collectionView.bounds.height)
        layoutAttributesForPaging = layoutAttributesForElements(in: expandedVisibleRect)?.sorted { $0.frame.minX < $1.frame.minX }
    }
}
