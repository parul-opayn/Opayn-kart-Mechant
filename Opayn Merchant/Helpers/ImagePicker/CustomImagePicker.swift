//
//  CustomImagePicker.swift
//  OpaynKart
//
//  Created by OPAYN on 23/08/21.
//

import Foundation
import UIKit
import MobileCoreServices
import TOCropViewController
import OpalImagePicker

/** Below Protocol returns the media which user has choosen. */

public protocol ImagePickerDelegate: AnyObject {
    
    func didSelect(Mediadata: Data?,uploadType:whatToUpload?)
    
}

open class ImagePicker: NSObject {
    
    //MARK:- Variables
    
        private let pickerController: UIImagePickerController
        private weak var presentationController: UIViewController?
        private weak var delegate: ImagePickerDelegate?
        var upload:whatToUpload = .photo
        var cropStyle : TOCropViewCroppingStyle?
        var cropViewController = TOCropViewController()
        var media: mediaType = .none
        var displayActionSheet = true
        
        //MARK:- Initializer
        
        public init(presentationController: UIViewController, delegate: ImagePickerDelegate) { self.pickerController = UIImagePickerController()
            super.init()
            self.presentationController = presentationController
            self.delegate = delegate
            self.pickerController.delegate = self
            self.cropViewController.delegate = self
            
        }
        
        //MARK:- Alert Button Actions
        
        private func action(for type: UIImagePickerController.SourceType, title: String) -> UIAlertAction? {
            guard UIImagePickerController.isSourceTypeAvailable(type) else { return nil }
            return UIAlertAction(title: title, style: .default) { [unowned self] _ in self.pickerController.sourceType = type
                self.presentationController?.present(self.pickerController, animated: true)
                
            }
            
        }
        
        private func pickerController(_ controller: UIImagePickerController, didSelect image: Data?) { controller.dismiss(animated: true, completion: nil)
            
            self.delegate?.didSelect(Mediadata: image, uploadType: upload)
            
        }
        
        public func showPickerAlert(view:UIView) {
            let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
            
            actionSheet.view.tintColor = UIColor.black
            
            if media == .photoCamera{
                if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)
                {
                    if displayActionSheet{
                        actionSheet.addAction(UIAlertAction(title: "Camera", style: UIAlertAction.Style.default, handler: { (alert:UIAlertAction!) -> Void in self.camera() }))
                        
                    }
                    else{
                        self.camera()
                        
                    }
                    
                }
                
            }
            else if media == .photoGallery{
                
                if displayActionSheet{
                    
                    actionSheet.addAction(UIAlertAction(title: "Gallery", style: UIAlertAction.Style.default, handler: {(alert:UIAlertAction) -> Void in self.openVideoGallery() }))
                    
                }
                else{
                    self.openVideoGallery()
                    
                }
                
            }
            else if media == .bothCameraGallery{
                if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
                    actionSheet.addAction(UIAlertAction(title: "Photo", style: UIAlertAction.Style.default, handler: { (alert:UIAlertAction!) -> Void in self.upload = .photo
                        self.media = .photoCamera
                        self.camera()
                        }))
                    
                    actionSheet.addAction(UIAlertAction(title: "Video", style: UIAlertAction.Style.default, handler: { (alert:UIAlertAction!) -> Void in
                                                            self.upload = .video
                                                            self.media = .photoCamera
                                                            self.camera() }))
                    
                }
                
            }
            else if media == .bothGallery{
                actionSheet.addAction(UIAlertAction(title: "Photo Album", style: UIAlertAction.Style.default, handler: { (alert:UIAlertAction!) -> Void in
                                                        
                                                        self.upload = .photo
                                                        self.media = .photoGallery
                                                        self.openVideoGallery() }))
                
                actionSheet.addAction(UIAlertAction(title: "Video Album", style: UIAlertAction.Style.default, handler: {(alert:UIAlertAction) -> Void in
                                                        self.upload = .video
                                                        self.media = .photoGallery
                                                        self.openVideoGallery()
                    
                }))
                
            }
            else if media == .photosGalleryAndCamera{
                if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
                    actionSheet.addAction(UIAlertAction(title: "Photo Camera", style: UIAlertAction.Style.default, handler: { (alert:UIAlertAction!) -> Void in self.upload = .photo
                        self.media = .photosGalleryAndCamera
                        self.camera()
                    }))
                }
                else{
                    actionSheet.addAction(UIAlertAction(title: "Photo Album", style: UIAlertAction.Style.default, handler: { (alert:UIAlertAction!) -> Void in
                        
                        self.upload = .photo
                        self.media = .photosGalleryAndCamera
                        self.openVideoGallery()
                        
                    }))
                }
            }
            else if media == .videosGalleryAndCamera{
                if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
                    
                    actionSheet.addAction(UIAlertAction(title: "Video Camera", style: UIAlertAction.Style.default, handler: { (alert:UIAlertAction!) -> Void in
                                                            self.upload = .video
                                                            self.media = .videosGalleryAndCamera
                                                            self.camera() }))
                    
                }
                else{
                    actionSheet.addAction(UIAlertAction(title: "Video Album", style: UIAlertAction.Style.default, handler: {(alert:UIAlertAction) -> Void in
                        self.upload = .video
                        self.media = .videosGalleryAndCamera
                        self.openVideoGallery()
                        
                    }))
                }
            }
            else{
                if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)
                {
                    actionSheet.addAction(UIAlertAction(title: "Photo Camera", style: UIAlertAction.Style.default, handler: { (alert:UIAlertAction!) -> Void in self.upload = .photo
                        self.media = .photoCamera
                        self.camera()
                        
                    }))
                    actionSheet.addAction(UIAlertAction(title: "Video Camera", style: UIAlertAction.Style.default, handler: { (alert:UIAlertAction!) -> Void in self.upload = .video
                        self.media = .photoCamera
                        self.camera()
                        
                    }))
                    actionSheet.addAction(UIAlertAction(title: "Photo Album", style: UIAlertAction.Style.default, handler: { (alert:UIAlertAction!) -> Void in
                        
                        self.upload = .photo
                        
                        self.media = .photoGallery
                        
                        self.openVideoGallery()
                        
                    }))
                    
                    actionSheet.addAction(UIAlertAction(title: "Video Album", style: UIAlertAction.Style.default, handler: {(alert:UIAlertAction) -> Void in
                        self.upload = .video
                        self.media = .photoGallery
                        self.openVideoGallery()
                        
                    }))
                    
                }
                else{
                    actionSheet.addAction(UIAlertAction(title: "Photo Album", style: UIAlertAction.Style.default, handler: { (alert:UIAlertAction!) -> Void in
                        self.upload = .photo
                        self.media = .photoGallery
                        self.openVideoGallery()
                        
                    }))
                    
                    actionSheet.addAction(UIAlertAction(title: "Video Album", style: UIAlertAction.Style.default, handler: {(alert:UIAlertAction) -> Void in
                                                            self.upload = .video
                                                            self.media = .photoGallery
                                                            self.openVideoGallery() }))
                    
                }
                
            }
            
            actionSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
            
            if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad {
                
                let popUp = UIPopoverController(contentViewController: actionSheet)
                
                popUp.present(from: CGRect(x: 15, y: view.frame.height - 150, width: 0, height: 0),
                              in: view, permittedArrowDirections: UIPopoverArrowDirection.any, animated: true)
                }
            else {
                    presentationController?.present(actionSheet, animated: true, completion: nil)
                    
                }
            
        }
        //MARK:- Custom Functions
        
        func camera()
        {
            if upload == .video{
                self.pickerController.delegate = self
                self.pickerController.sourceType = .camera
                self.pickerController.allowsEditing = true
                self.pickerController.mediaTypes = [kUTTypeMovie as String]
                pickerController.cameraCaptureMode = .video
                pickerController.videoQuality = .typeHigh
                presentationController?.present(pickerController, animated: true, completion: nil)
                
            }
            else if upload == .photo{
                pickerController.sourceType = .camera
                presentationController?.present(pickerController, animated: true, completion: nil)
                
            }
            else{
                self.pickerController.delegate = self
                self.pickerController.sourceType = .camera
                self.pickerController.allowsEditing = true
                pickerController.cameraCaptureMode = .video
                pickerController.videoQuality = .typeHigh
                presentationController?.present(pickerController, animated: true, completion: nil)
                pickerController.sourceType = .camera
                presentationController?.present(pickerController, animated: true, completion: nil) }
            
        }
        
        func openVideoGallery() {
            
            if upload == .video{
                
                pickerController.sourceType = .savedPhotosAlbum
                pickerController.mediaTypes = UIImagePickerController.availableMediaTypes(for: .savedPhotosAlbum)!
                pickerController.mediaTypes = ["public.movie"]
                pickerController.allowsEditing = false
                pickerController.videoExportPreset = "AVAssetExportPresetPassthrough"
                presentationController?.present(pickerController, animated: true, completion: nil)
                
            }
            else if upload == .photo{
                pickerController.sourceType = .photoLibrary
                pickerController.mediaTypes = ["public.image"]
                presentationController?.present(pickerController, animated: true, completion: nil)
                
            }
            
            else{
                pickerController.sourceType = .savedPhotosAlbum
                pickerController.mediaTypes = UIImagePickerController.availableMediaTypes(for: .savedPhotosAlbum)!
                pickerController.mediaTypes = ["public.movie"]
                pickerController.allowsEditing = false
                pickerController.videoExportPreset = "AVAssetExportPresetPassthrough"
                presentationController?.present(pickerController, animated: true, completion: nil) }
            
        }
    
}

//MARK:- ImagePicker and CropView Delegates

extension ImagePicker: UIImagePickerControllerDelegate,UINavigationControllerDelegate,TOCropViewControllerDelegate {
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        self.pickerController(picker, didSelect: nil)
        self.presentationController?.dismiss(animated: true, completion: nil)
        
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        if upload == .video{
            let videoURL = info[UIImagePickerController.InfoKey.mediaURL] as? NSURL
            if let videoData = NSData(contentsOf: videoURL! as URL){
                self.pickerController(picker, didSelect: videoData as Data)
                
            }
            else{
                
            }
            
            pickerController.dismiss(animated: true, completion: nil)
            
        }
        else{
            guard let image = info[.originalImage] as? UIImage else { return
                
            }
            
            cropStyle = TOCropViewCroppingStyle.default
            cropViewController = TOCropViewController(croppingStyle: cropStyle!, image: image)
            cropViewController.toolbar.clampButtonHidden = true
            cropViewController.toolbar.rotateClockwiseButtonHidden = true
            
            cropViewController.cropView.aspectRatioLockEnabled = true
            cropViewController.toolbar.rotateButton.isHidden = true
            cropViewController.toolbar.resetButton.isHidden = true
            
            cropViewController.delegate = self
            
            pickerController.dismiss(animated: true, completion: nil)
            self.presentationController?.present(cropViewController, animated: true, completion: nil) }
        
    }
    
    public func cropViewController(_ cropViewController: TOCropViewController, didCropTo image: UIImage, with cropRect: CGRect, angle: Int)
    
    {
        if upload == .photo{
            cropViewController.dismiss(animated: true, completion: nil)
            delegate?.didSelect(Mediadata: image.jpegData(compressionQuality: 1.0), uploadType: upload)
            
        } else{
            
        }
        
    }
    
}

//MARK:- Enums

/** The below enums helps user to choose different kind of media. If you want to upload photo or video then choose from whatToUpload enum and also choose from where to choose media(whether to click from camera or to choose from gallery.) */

public enum whatToUpload{
    case photo
    case video
    case bothPhotoVideo
    case audio
    
}

enum mediaType {
    case photoCamera
    case photoGallery
    case bothCameraGallery
    case bothGallery
    case photosGalleryAndCamera
    case videosGalleryAndCamera
    case none
}

enum uploadStatus{
    case inProgress
    case success
    case failure
    
}
