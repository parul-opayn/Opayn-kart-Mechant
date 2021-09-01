//
//  CollectionViewHeightAdjuster.swift
//  OpaynKart
//
//  Created by OPAYN on 20/08/21.
//
import Foundation
import UIKit

class DynamicHeightCollectionView: UICollectionView {
    override func layoutSubviews() {
        super.layoutSubviews()
        if bounds.size != intrinsicContentSize {
            self.invalidateIntrinsicContentSize()
        }
    }
    override var intrinsicContentSize: CGSize {
        return collectionViewLayout.collectionViewContentSize
    }
}
