//
//  WalkThroughCollectionViewCell.swift
//  Opayn Merchant
//
//  Created by OPAYN on 31/08/21.
//

import UIKit

class WalkThroughCollectionViewCell: UICollectionViewCell {
    
    //------------------------------------ WalkThrough --------------------------------------------
    
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    //MARK:- Varaibles
    var isLayoutChanged = false
    
    
    //------------------------------------ Home Bnanner --------------------------------------------
    
    @IBOutlet weak var bannerImage: SetImage!
    
}
