//
//  OrdersListViewController.swift
//  Opayn Merchant
//
//  Created by OPAYN on 31/08/21.
//

import UIKit

class OrdersListViewController: UIViewController {

    //MARK:- IBOutlets
    
    @IBOutlet weak var ordersListTableView: UITableView!
    
    //MARK:- Variables
    
    var viewModel = OrdersListViewModel()
    let refershControl = UIRefreshControl()
    
    //MARK:- Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ordersListTableView.delegate = self
        ordersListTableView.dataSource = self
        self.ordersListTableView.refreshControl = self.refershControl
        refershControl.addTarget(self, action: #selector(refreshView(refresh:)), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationWithBack(navtTitle: "Orders List", icon: #imageLiteral(resourceName: "menu"), buttonType: .menu)
        self.ordersAPI()
    }

    //MARK:- Objc Methods
    
    @objc func refreshView(refresh:UIRefreshControl){
        if !ordersListTableView.isDragging {
            print("refer")
            self.refershControl.endRefreshing()
            self.ordersAPI()
        }
       
        refresh.endRefreshing()
    }
    
}

//MARK:- TableView Delegates

extension OrdersListViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.ordersListModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ordersListTableView.dequeueReusableCell(withIdentifier: "ProductsListTableViewCell") as! ProductsListTableViewCell
        //cell.productImage.changeLayout()
        let model = viewModel.ordersListModel[indexPath.row]
        cell.productNameLbl.text = model.fullName ?? ""
        cell.quantityLbl.text = "Order Quantity : \(model.products?.count ?? 0)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "", handler: {a,b,c in
            
        })
        
        deleteAction.image = UIImage(named: "delete")?.withTintColor(.black)
        deleteAction.backgroundColor = .clear
        
        let swipeActionConfig = UISwipeActionsConfiguration(actions: [deleteAction])
        swipeActionConfig.performsFirstActionWithFullSwipe = false
        
        return swipeActionConfig
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(identifier: "SubOrdersViewController") as! SubOrdersViewController
        vc.viewModel = self.viewModel
        vc.forIndex = indexPath.row
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if  let tableView = scrollView as? UITableView{
            if tableView == self.ordersListTableView{
                if self.refershControl.isRefreshing == true {
                    print("refer")
                    self.refershControl.endRefreshing()
                    self.ordersAPI()
                }
            }
            
        }
     }
    
}


//MARK:- API Calls

extension OrdersListViewController{
    
    func ordersAPI(){
        Indicator.shared.showProgressView(self.view)
        self.viewModel.ordersListAPI { isSuccess, message in
            Indicator.shared.hideProgressView()
            if isSuccess{
                self.ordersListTableView.reloadData()
            }
            else{
                self.showToast(message: message)
            }
        }
    }
    
}
