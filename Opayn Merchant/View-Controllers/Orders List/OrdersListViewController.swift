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
    
    
    //MARK:- Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ordersListTableView.delegate = self
        ordersListTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationWithBack(navtTitle: "Orders List", icon: #imageLiteral(resourceName: "menu"), buttonType: .menu)
    }

}

//MARK:- TableView Delegates

extension OrdersListViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ordersListTableView.dequeueReusableCell(withIdentifier: "ProductsListTableViewCell") as! ProductsListTableViewCell
        cell.productImage.changeLayout()
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
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
    
}
