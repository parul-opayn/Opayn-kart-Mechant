//
//  AddProductViewController.swift
//  Opayn Merchant
//
//  Created by OPAYN on 31/08/21.
//

import UIKit
import GrowingTextView
import  OpalImagePicker
import Photos
import DropDown
import SDWebImage

class AddProductViewController: UIViewController {
    
    //MARK:- IBOutlets
    
    @IBOutlet weak var titleTxtFld: UITextField!
    @IBOutlet weak var descriptionTxtView: GrowingTextView!
    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var subcategoryLbl: UILabel!
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    @IBOutlet weak var collectionHeight: NSLayoutConstraint!
    @IBOutlet weak var salePriceTxtFld: UITextField!
    @IBOutlet weak var regularPriceTxtFld: UITextField!
    @IBOutlet weak var addProductBtn: SetButton!
    
    //MARK:- Variables
    
    var images = [UIImage]()
    let imagePicker = OpalImagePickerController()
    var viewModel = ProductsCategoryViewModel()
    var categoriesData = [String]()
    var subCategoriesData = [String]()
    var subCatIds = [String]()
    var selectedCatId = ""
    var selectedSubCatId = ""
    let dropdown = DropDown()
    var displayDataFor:AddProductFor = .add
    var editForIndex = -1
    
    //MARK:- Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = self
        self.navigationController?.isNavigationBarHidden = false
        if self.displayDataFor == .add{
            self.navigationWithBack(navtTitle: "Add Product", icon: #imageLiteral(resourceName: "menu"), buttonType: .menu)
        }
        else{
            self.navigationWithBack(navtTitle: "Edit Product", icon: #imageLiteral(resourceName: "back"), buttonType: .back)
        }
        categoriesAPI()
        self.updateCollectionHeight(collectionName: self.imagesCollectionView, collectionHeight: self.collectionHeight)
    }
    
    //MARK:- Custom Methods
    
    func displayDataForEdit(){
        let model = viewModel.productsListModel[editForIndex]
        self.titleTxtFld.text = model.name ?? ""
        self.descriptionTxtView.text = model.description ?? ""
        self.salePriceTxtFld.text = model.salePrice ?? ""
        self.regularPriceTxtFld.text = model.regularPrice ?? ""
        self.imagesCollectionView.reloadData()
        self.updateCollectionHeight(collectionName: self.imagesCollectionView, collectionHeight: self.collectionHeight)
        self.selectedCatId = model.cat_id ?? ""
        self.selectedSubCatId = model.sub_cat_id ?? ""
        let filterCategory = viewModel.home?.categories?.filter({$0.id == model.cat_id})
        let subCategory = viewModel.home?.categories?.map({$0.subCategories?.filter({$0.id == model.sub_cat_id}) ?? []}).reduce([],+)
        self.categoryLbl.text = filterCategory?.first?.name ?? ""
        self.subcategoryLbl.text = subCategory?.first?.name ?? ""
        self.addProductBtn.setTitle("Update Product", for: .normal)
    }
    
    //MARK:- Objc Methods
    
    @objc func didTapDelete(sender:UIButton){
        if displayDataFor == .add{
            self.images.remove(at: sender.tag)
        }
        else{
            if sender.tag <= (self.viewModel.productsListModel[editForIndex].images?.count ?? 0){
                self.viewModel.productsListModel[editForIndex].images?.remove(at: sender.tag)
            }
            else{
                let total = ((viewModel.productsListModel[editForIndex].images?.count ?? 0) + images.count)
                self.images.remove(at: (total - sender.tag) - 1)
            }
        }
        self.imagesCollectionView.reloadData()
        self.updateCollectionHeight(collectionName: self.imagesCollectionView, collectionHeight: self.collectionHeight)
    }
    
    //MARK:- IBActions
    
    @IBAction func tappedAddImagesBtn(_ sender: UIButton) {
        
        imagePicker.imagePickerDelegate = self
        imagePicker.maximumSelectionsAllowed = 5
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func tappedCategoryBtn(_ sender: UIButton) {
        dropdown.dataSource = self.categoriesData
        dropdown.anchorView = sender
        dropdown.direction = .any
        dropdown.bottomOffset = CGPoint(x: 0, y:sender.frame.size.height)
        dropdown.width = sender.frame.width
        dropdown.heightAnchor.constraint(equalToConstant: 40).isActive = true
        dropdown.show()
        dropdown.selectionAction = {
            [weak self] (index:Int,item:String) in
            guard let self = self else{return}
            self.categoryLbl.text  = item
            let subCat = self.viewModel.home?.categories?[index].subCategories?.map({$0.name ?? ""}) ?? []
            self.subCategoriesData = subCat
            self.subCatIds = self.viewModel.home?.categories?[index].subCategories?.map({$0.id ?? ""}) ?? []
            self.selectedCatId = self.viewModel.home?.categories?[index].id ?? ""
            
        }
    }
    
    @IBAction func tappedSubCategoryBtn(_ sender: UIButton) {
        dropdown.dataSource = self.subCategoriesData
        dropdown.anchorView = sender
        dropdown.direction = .any
        dropdown.bottomOffset = CGPoint(x: 0, y:sender.frame.size.height)
        dropdown.width = sender.frame.width
        dropdown.heightAnchor.constraint(equalToConstant: 40).isActive = true
        dropdown.show()
        dropdown.selectionAction = {
            [weak self] (index:Int,item:String) in
            guard let self = self else{return}
            self.subcategoryLbl.text  = item
            self.selectedSubCatId = self.subCatIds[index]
        }
        
        if self.subCategoriesData.count == 0{
            self.showToast(message: "No subcategories found")
        }
    }
    
    @IBAction func tappedAddProduct(_ sender: UIButton) {
        let validate = viewModel.addProductValidation(title: titleTxtFld.text ?? "", des: descriptionTxtView.text ?? "", salePrice: salePriceTxtFld.text ?? "", regularPrice: regularPriceTxtFld.text ?? "", category: self.categoryLbl.text ?? "")
        if validate.0{
            if displayDataFor == .add{
                addProductAPI(id: nil)
            }
            else{
                addProductAPI(id: viewModel.productsListModel[editForIndex].id ?? "")
            }
        }
        else{
            self.showToast(message: validate.1)
        }
    }
}

//MARK:- CollectionView Delegates

extension AddProductViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if viewModel.productsListModel.count > 0{
            return (viewModel.productsListModel[editForIndex].images?.count ?? 0) + images.count
        }
        else{
            return images.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImagesCollectionViewCell", for: indexPath) as! ImagesCollectionViewCell
        if indexPath.row <= ((viewModel.productsListModel[editForIndex].images?.count ?? 0) - 1){
            cell.productImageView.sd_setImage(with: URL(string: viewModel.productsListModel[editForIndex].images?[indexPath.row] ?? ""), placeholderImage: #imageLiteral(resourceName: "placeholder Image"),options: .highPriority, completed: nil)
        }
        else{
            let calculateIndex = ((viewModel.productsListModel[editForIndex].images?.count ?? 0) + images.count) - indexPath.row
            cell.productImageView.image = self.images[calculateIndex]
        }
        cell.deleteImageBtn.tag = indexPath.row
        cell.deleteImageBtn.addTarget(self, action: #selector(didTapDelete), for: .touchUpInside)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 3 - 24, height: collectionView.bounds.height / 2 - 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }
    
}

//MARK:- Multi ImagePicker Delegates

extension AddProductViewController:OpalImagePickerControllerDelegate{
    
    func imagePickerDidCancel(_ picker: OpalImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePicker(_ picker: OpalImagePickerController, didFinishPickingAssets assets: [PHAsset]) {
        picker.dismiss(animated: true, completion: nil)
        self.images.append(contentsOf:self.getAssetThumbnail(assets: assets))
        self.imagesCollectionView.reloadData()
        self.updateCollectionHeight(collectionName: self.imagesCollectionView, collectionHeight: self.collectionHeight)
    }
}

//MARK:-API Calls

extension AddProductViewController{
    
    func categoriesAPI(){
        Indicator.shared.showProgressView(self.view)
        self.viewModel.homeAPI { isSuccess, message in
            Indicator.shared.hideProgressView()
            if isSuccess{
                self.categoriesData = self.viewModel.home?.categories?.map({$0.name ?? ""}) ?? []
                if self.displayDataFor == .edit{
                    self.displayDataForEdit()
                }
            }
            else{
                self.showToast(message: message)
            }
        }
    }
    
    func deleteImage(productId:String,image:String){
        Indicator.shared.showProgressView(self.view)
        self.viewModel.deleteImagesAPI(productId: productId, image: image) { isSuccess, message in
            Indicator.shared.hideProgressView()
            if isSuccess{
                self.imagesCollectionView.reloadData()
            }
            else{
                self.showToast(message: message)
            }
        }
    }
    
    func addProductAPI(id:String?){
        
        /**
         Use id incase the user is editing the screen. It would be optional
         */
        
        Indicator.shared.showProgressView(self.view)
        
        var fileNames = [String]()
        var fileData = [Data]()
        var fileParams = [String]()
        var fileType  = [String]()
        
        for i in self.images{
            fileNames.append(generateUniqueName(withSuffix: ".png"))
            fileData.append(i.jpegData(compressionQuality: 0.1) ?? Data())
            fileParams.append("images[]")
            fileType.append("image/png")
        }
        
        viewModel.addProduct(productId:id,catId: self.selectedCatId, subCatId: self.selectedSubCatId, name: titleTxtFld.text ?? "", description: descriptionTxtView.text ?? "", regularPrice: self.regularPriceTxtFld.text ?? "", salePrice: self.salePriceTxtFld.text ?? "", fileName: fileNames, fileType: fileType, fileParam: fileParams, fileData: fileData) { isSuccess, message in
            Indicator.shared.hideProgressView()
            if isSuccess{
                
                if self.displayDataFor == .add{
                    let vc = self.storyboard?.instantiateViewController(identifier: "ProductsListViewController") as! ProductsListViewController
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                else{
                    self.navigationController?.popViewController(animated: true)
                }
            }
            else{
                self.showToast(message: message)
            }
        }
    }
    
}


