//
//  SubOrdersViewController.swift
//  Opayn Merchant
//
//  Created by OPAYN on 02/09/21.
//

import UIKit

class SubOrdersViewController: UIViewController {

    //MARK:- IBOutlets
    
    @IBOutlet weak var subOrdersTableView: UITableView!
    
    //MARK:- Variables
    
    var viewModel = OrdersListViewModel()
    var forIndex = 0
    
    
    //MARK:- Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subOrdersTableView.delegate = self
        subOrdersTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationWithBack(navtTitle: "Sub Orders List", icon: #imageLiteral(resourceName: "back"), buttonType: .back)
    }
    
    //MARK:- Custom Methods
    
    //MARK:- Objc Methods
    
    @objc func didTapAccept(sender:UIButton){
        let model = self.viewModel.ordersListModel[forIndex]
        changeProductStatus(orderId: model.id ?? "", pId: model.products?[sender.tag].id ?? "", status: "1", atIndex: sender.tag)
    }
    
    @objc func didTapReject(sender:UIButton){
        let model = self.viewModel.ordersListModel[forIndex]
        changeProductStatus(orderId: model.id ?? "", pId: model.products?[sender.tag].id ?? "", status: "2", atIndex: sender.tag)
    }
    
    //MARK:- IBActions
    
   

}

//MARK:- TableView Delegates

extension SubOrdersViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.ordersListModel[forIndex].products?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = subOrdersTableView.dequeueReusableCell(withIdentifier: "ProductsListTableViewCell") as! ProductsListTableViewCell
        cell.productImage.changeLayout()
        let model = viewModel.ordersListModel[forIndex]
        cell.productNameLbl.text = model.products?[indexPath.row].name ?? ""
        cell.subProductName.text = "Price: $ \(model.products?[indexPath.row].price ?? "")"
        cell.productImage.sd_setImage(with: URL(string: model.products?[indexPath.row].images?.first ?? ""), placeholderImage: #imageLiteral(resourceName: "placeholder Image"), options: .highPriority, context: nil)
        let orderDate = Singleton.sharedInstance.UTCToLocal(date: model.created_at ?? "", fromFormat: "yyyy-MM-dd HH:mm:ss", toFormat: "yyyy-MM-dd")
        cell.dateLbl.text = orderDate
        cell.acceptBtn.tag = indexPath.row
        cell.acceptBtn.addTarget(self, action: #selector(didTapAccept), for: .touchUpInside)
        cell.rejectBtn.tag = indexPath.row
        cell.rejectBtn.addTarget(self, action: #selector(didTapReject), for: .touchUpInside)
        
        let status = model.products?[indexPath.row].status ?? ""
        
        switch status {
        
        case "0":
            cell.acceptBtn.isHidden = false
            cell.rejectBtn.isHidden = false
            cell.acceptBtn.isUserInteractionEnabled = true
            cell.rejectBtn.isUserInteractionEnabled = true
            cell.acceptBtn.setTitle(" Accept ", for: .normal)
            cell.rejectBtn.setTitle(" Reject ", for: .normal)
            break
       
        case "1":
            cell.acceptBtn.isHidden = false
            cell.rejectBtn.isHidden = true
            cell.acceptBtn.isUserInteractionEnabled = false
            cell.rejectBtn.isUserInteractionEnabled = false
            cell.acceptBtn.setTitle(" Accepted ", for: .normal)
            cell.rejectBtn.setTitle(" Reject ", for: .normal)
            break
            
        case "2":
            cell.acceptBtn.isHidden = true
            cell.rejectBtn.isHidden = false
            cell.acceptBtn.isUserInteractionEnabled = false
            cell.rejectBtn.isUserInteractionEnabled = false
            cell.acceptBtn.setTitle(" Accept ", for: .normal)
            cell.rejectBtn.setTitle(" Rejected ", for: .normal)
            break
            
        default:
            cell.acceptBtn.isHidden = false
            cell.rejectBtn.isHidden = false
            cell.acceptBtn.isUserInteractionEnabled = true
            cell.rejectBtn.isUserInteractionEnabled = true
            cell.acceptBtn.setTitle(" Accept ", for: .normal)
            cell.rejectBtn.setTitle(" Reject ", for: .normal)
            break
        }
        return cell
    }
    
}


//MARK:- API Calls

extension SubOrdersViewController{
    
    func changeProductStatus(orderId:String,pId:String,status:String,atIndex:Int){
        Indicator.shared.showProgressView(self.view)
        self.viewModel.changeOrderStatus(merchantOrderId: orderId, productId: pId, status: status) { [weak self] isSuccess, message in
            guard let self = self else{return}
            Indicator.shared.hideProgressView()
            
            if isSuccess{
                self.viewModel.ordersListModel[self.forIndex].products?[atIndex].status = status
                self.subOrdersTableView.reloadData()
            }
            else{
                self.showToast(message: message)
            }
        }
    }
    
}

