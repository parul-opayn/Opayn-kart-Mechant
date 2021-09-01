//
//  AddressTableViewCell.swift
//  Opayn Merchant
//
//  Created by OPAYN on 31/08/21.
//

import UIKit

class AddressTableViewCell: UITableViewCell {

    @IBOutlet weak var menuImage: UIImageView!
    @IBOutlet weak var menuItemLabel: UILabel!
    
    // Outlets for address
    
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var userAdderessLbl: UILabel!
    @IBOutlet weak var userMobileLbl3: UILabel!
    @IBOutlet weak var selectionImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if self.selectionImage != nil{
        if isSelected{
            self.selectionImage.image = #imageLiteral(resourceName: "check")
        }
        else{
            self.selectionImage.image = #imageLiteral(resourceName: "address_unselect")
        }
    }
    }

}
