//
//  ProductsListViewController.swift
//  Opayn Merchant
//
//  Created by OPAYN on 31/08/21.
//

import UIKit

class ProductsListViewController: UIViewController {
    
    //MARK:- IBOutlets
    
    @IBOutlet weak var productsListTableView: UITableView!
    
    //MARK:- Variables
    
    //MARK:- Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productsListTableView.delegate = self
        productsListTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationWithBack(navtTitle: "Products List", icon: #imageLiteral(resourceName: "menu"), buttonType: .menu)
    }
    
    //MARK:- Custom Methods
    
    //MARK:- Objc Methods
    
    //MARK:- IBActions
       
}


//MARK:- TableView Delegates

extension ProductsListViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = productsListTableView.dequeueReusableCell(withIdentifier: "ProductsListTableViewCell") as! ProductsListTableViewCell
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
        
        let editAction = UIContextualAction(style: .normal, title: "", handler: {a,b,c in
            
        })
//
        deleteAction.image = UIImage(named: "delete")?.withTintColor(.black)
        editAction.image = UIImage(named: "edit-1")
        deleteAction.backgroundColor = .clear
        let swipeActionConfig = UISwipeActionsConfiguration(actions: [deleteAction,editAction])
        swipeActionConfig.performsFirstActionWithFullSwipe = false
        return swipeActionConfig
        
    }
    
}
