//
//  CameraViewController.swift
//  InstagramSampleApp
//
//  Created by Mohammad Farhoudi on 11/05/2018.
//  Copyright © 2018 Mohammad Farhoudi. All rights reserved.
//

import UIKit
import AVFoundation


class CameraViewController: UIViewController, AVCapturePhotoCaptureDelegate, UIViewControllerTransitioningDelegate {
    
    
    let dismissButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "right_arrow_shadow"), for: .normal)
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    let capturePhotoButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "capture_photo"), for: .normal)
        button.addTarget(self, action: #selector(handleCapturePhoto), for: .touchUpInside)
        return button
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCaptureSession()
        
        setupHUD()
        
        transitioningDelegate = self

    
    }
    
    
    let customAnimationPresenter = CustomAnimationPresenter()
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        return customAnimationPresenter
        
    }
    
    
    let customDestructiveAnimationPresenter = CustomDestructiveAnimationPresenter()

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return customDestructiveAnimationPresenter
        
    }
    
    
    override var prefersStatusBarHidden: Bool {
        return true
        
    }
    
    fileprivate func setupHUD() {
        view.addSubview(capturePhotoButton)
        capturePhotoButton.anchor(top: nil, left: nil, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 24, paddingRight: 0, width: 80, height: 80)
        capturePhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(dismissButton)
        dismissButton.anchor(top: view.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 9, width: 50, height: 50)
    }
    
    @objc fileprivate func handleDismiss(){
    dismiss(animated: true, completion: nil)
    }
    
    
    @objc fileprivate func handleCapturePhoto(){
        
        
        
        let settings = AVCapturePhotoSettings()
        guard let previewFormatType = settings.availablePreviewPhotoPixelFormatTypes.first else {return}
        settings.previewPhotoFormat = [kCVPixelBufferPixelFormatTypeKey: previewFormatType] as [String : Any]
        output.capturePhoto(with: settings, delegate: self)
        
        
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?, previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        
        let imageData = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: photoSampleBuffer!, previewPhotoSampleBuffer: previewPhotoSampleBuffer!)
        
        let previewPhoto = UIImage(data: imageData!)
        let previewCameraPhotoView = PreviewCameraPhotoView()
        previewCameraPhotoView.previewImage.image = previewPhoto
        view.addSubview(previewCameraPhotoView)
        previewCameraPhotoView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
//        let previewPhotoImageView = UIImageView(image: previewPhoto)
//
//        view.addSubview(previewPhotoImageView)
//
//        previewPhotoImageView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
    
        
    }
    
    
    
    let output = AVCapturePhotoOutput()

    fileprivate func setupCaptureSession(){
        
        let captureSession = AVCaptureSession()
        
        // 1. Set up the inputs
        
        
        guard let captureDevice = AVCaptureDevice.default(for: AVMediaType.video) else {return}
        do {
        let input = try AVCaptureDeviceInput(device: captureDevice)
            if captureSession.canAddInput(input) {
                captureSession.addInput(input)
            }
        } catch let err {
            print("Error in Handling", err)
        }
        
        
        // 2. Set up the Outputs
        
        if captureSession.canAddOutput(output){
            captureSession.addOutput(output)

            
        }
        
        
        // 3. Set up Output preview
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.frame
        
        view.layer.addSublayer(previewLayer)
        
        captureSession.startRunning()
    
    }
    
    
}
