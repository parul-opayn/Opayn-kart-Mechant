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

class AddProductViewController: UIViewController {
    
    //MARK:- IBOutlets
    
    @IBOutlet weak var titleTxtFld: UITextField!
    @IBOutlet weak var descriptionTxtView: GrowingTextView!
    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var subcategoryLbl: UILabel!
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    @IBOutlet weak var collectionHeight: NSLayoutConstraint!
    
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
    
    //MARK:- Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = self
        self.navigationController?.isNavigationBarHidden = false
        self.navigationWithBack(navtTitle: "Add Product", icon: #imageLiteral(resourceName: "menu"), buttonType: .menu)
        categoriesAPI()
        self.imagesCollectionView.reloadData()
        self.updateCollectionHeight(collectionName: self.imagesCollectionView, collectionHeight: self.collectionHeight)
    }
    
    //MARK:- Custom Methods
    
    //MARK:- Objc Methods
    
    @objc func didTapDelete(sender:UIButton){
        self.images.remove(at: sender.tag)
        self.imagesCollectionView.reloadData()
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
    
}

//MARK:- CollectionView Delegates

extension AddProductViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImagesCollectionViewCell", for: indexPath) as! ImagesCollectionViewCell
        cell.productImageView.image = self.images[indexPath.row]
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
        self.images = self.getAssetThumbnail(assets: assets)
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
            }
            else{
                self.showToast(message: message)
            }
        }
    }
    
}
