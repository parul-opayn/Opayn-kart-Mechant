//
//  ProductsListTableViewCell.swift
//  Opayn Merchant
//
//  Created by OPAYN on 31/08/21.
//

import UIKit

class ProductsListTableViewCell: UITableViewCell {

    //---------------Products List----------------
    
    //MARK:- IBOutlets
    
    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    //MARK:- Varaibles
    
    
    //---------------Orders List----------------
    @IBOutlet weak var quantityLbl: UILabel!
    
    //---------------SubOrders------------
    
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var subProductName: UILabel!
    @IBOutlet weak var acceptBtn: UIButton!
    @IBOutlet weak var rejectBtn: UIButton!
    
 
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
