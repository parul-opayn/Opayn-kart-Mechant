//
//  WalkThroughViewController.swift
//  Opayn Merchant
//
//  Created by OPAYN on 31/08/21.
//


import UIKit

class WalkThroughViewController: UIViewController {
    
    //MARK:- IBOutlets
    
    @IBOutlet weak var walkThroughCollectionView: UICollectionView!
    
    //MARK:- Variables
    
    
    //MARK:- Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        walkThroughCollectionView.delegate = self
        walkThroughCollectionView.dataSource = self
        hideNavigation()
    }
    
    //MARK:- Custom Methods
    
    func hideNavigation(){
        self.navigationController?.isNavigationBarHidden = true
    }
    
    //MARK:- Objc Methods
    
    @objc func didTapNextBtn(sender:UIButton){
        if sender.tag == 1 || sender.tag == 2{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else{
            self.walkThroughCollectionView.scrollToItem(at: IndexPath(row: sender.tag + 1, section: 0), at: .right, animated: true)
        }
        self.walkThroughCollectionView.reloadData()
     }
    
    //MARK:- IBActions
    
    @IBAction func tappedSigninBtn(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

//MARK:- CollectionView Delegates

extension WalkThroughViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.walkThroughCollectionView.dequeueReusableCell(withReuseIdentifier: "WalkThroughCollectionViewCell", for: indexPath) as! WalkThroughCollectionViewCell
        if indexPath.row == 1{
            cell.nextBtn.setTitle("Get Started", for: .normal)
        }
        else{
            cell.nextBtn.setTitle("Next", for: .normal)
        }
        
        if !cell.isLayoutChanged{
            cell.nextBtn.changeButtonLayout()
            cell.nextBtn.changeFontSize()
            cell.descriptionLabel.changeFontSize()
            cell.isLayoutChanged = true
        }
        
        
        cell.nextBtn.tag = indexPath.row
        cell.nextBtn.addTarget(self, action: #selector(didTapNextBtn), for: .touchUpInside)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: walkThroughCollectionView.bounds.width, height: walkThroughCollectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
