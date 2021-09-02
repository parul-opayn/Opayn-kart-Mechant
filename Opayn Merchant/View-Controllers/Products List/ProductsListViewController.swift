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
    
    var viewModel = ProductsCategoryViewModel()
    let refershControl = UIRefreshControl()
    
    //MARK:- Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productsListTableView.delegate = self
        productsListTableView.dataSource = self
        self.productsListTableView.refreshControl = self.refershControl
        refershControl.addTarget(self, action: #selector(refreshView(refresh:)), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        productsListAPI()
        self.navigationWithBack(navtTitle: "Products List", icon: #imageLiteral(resourceName: "menu"), buttonType: .menu)
    }
    
    //MARK:- Custom Methods
    
    //MARK:- Objc Methods
    
    @objc func refreshView(refresh:UIRefreshControl){
        if !productsListTableView.isDragging {
            print("refer")
            self.refershControl.endRefreshing()
            self.productsListAPI()
        }
       
        refresh.endRefreshing()
    }
    
    //MARK:- IBActions
       
}


//MARK:- TableView Delegates

extension ProductsListViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.productsListModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = productsListTableView.dequeueReusableCell(withIdentifier: "ProductsListTableViewCell") as! ProductsListTableViewCell
        cell.productImage.changeLayout()
        let model = viewModel.productsListModel[indexPath.row]
        cell.productImage.sd_setImage(with: URL(string: model.images?.first ?? ""), placeholderImage: #imageLiteral(resourceName: "placeholder Image"), options: .highPriority, context: nil)
        cell.productNameLbl.text = model.name ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "", handler: {a,b,c in
            self.deleteProduct(for: self.viewModel.productsListModel[indexPath.row].id ?? "", at: indexPath.row)
        })
        
        let editAction = UIContextualAction(style: .normal, title: "", handler: {a,b,c in
            let vc = self.storyboard?.instantiateViewController(identifier: "AddProductViewController") as! AddProductViewController
            vc.editForIndex = indexPath.row
            vc.viewModel = self.viewModel
            vc.displayDataFor = .edit
            self.navigationController?.pushViewController(vc, animated: true)
        })

        deleteAction.image = UIImage(named: "delete")?.withTintColor(.black)
        editAction.image = UIImage(named: "edit-1")
        deleteAction.backgroundColor = UIColor(named: "Lighter gray")
        editAction.backgroundColor = UIColor(named: "Lighter gray")
        let swipeActionConfig = UISwipeActionsConfiguration(actions: [deleteAction,editAction])
        swipeActionConfig.performsFirstActionWithFullSwipe = false
        return swipeActionConfig
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if  let tableView = scrollView as? UITableView{
            if tableView == self.productsListTableView{
                if self.refershControl.isRefreshing == true {
                    print("refer")
                    self.refershControl.endRefreshing()
                    self.productsListAPI()
                }
            }
            
        }
     }
    
}


//MARK:- API Calls

extension ProductsListViewController{
    
    func productsListAPI(){
        Indicator.shared.showProgressView(self.view)
        self.viewModel.productsListAPI { isSuccess, message in
            Indicator.shared.hideProgressView()
            if isSuccess{
                self.productsListTableView.reloadData()
            }
            else{
                self.showToast(message: message)
            }
        }
    }
    
    func deleteProduct(for productId:String,at index:Int){
        Indicator.shared.showProgressView(self.view)
        viewModel.deleteProductAPI(productId: productId) { isSuccess, message in
            Indicator.shared.hideProgressView()
            if isSuccess{
                self.viewModel.productsListModel.remove(at: index)
                self.productsListTableView.reloadData()
            }
            else{
                self.showToast(message: message)
            }
        }
    }
}
