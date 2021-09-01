//
//  CollectionViewHeightAdjuster.swift
//  OpaynKart
//
//  Created by OPAYN on 20/08/21.
//
import Foundation
import UIKit

class SelfSizedCollectionView: UICollectionView {
    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
    }

    override var intrinsicContentSize: CGSize {
        let s = self.collectionViewLayout.collectionViewContentSize
        return CGSize(width: max(s.width, 1), height: max(s.height,1))
    }

}
