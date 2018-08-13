//
//  MLVisionViewController.swift
//  CoreMLVision
//
//  Created by Ihor Malovanyi on 8/11/18.
//  Copyright © 2018 justDev. All rights reserved.
//

import UIKit
import AVFoundation
//import Vision

class MLVisionViewController: UIViewController {

    private var resultLabel: UILabel!
    private var domainModel: MLVisionDomainModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                         action: #selector(tap)))
        
        domainModel = MLVisionDomainModel(for: self)
        domainModel.delegate = self
        
        resultLabel = createInfoLabel()
        view.addSubview(resultLabel)
    }
    
    @objc private func tap() {
        domainModel.toggleCameraRunning()
    }
    
    private func createInfoLabel() -> UILabel {
        let label = UILabel()
        
        label.frame.size = CGSize(width: view.bounds.width - 30, height: view.bounds.height / 2 - 50)
        label.frame.origin = CGPoint(x: 15, y: view.bounds.height / 2)
        
        label.numberOfLines = 3
        label.textAlignment = .left
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.text = "Tap to activate"
        
        return label
    }
    
}

extension MLVisionViewController: MLVisionDomainModelDelegate {
    
    func visionDomainModel(visionDomainModel: MLVisionDomainModel, sentNewInfoByTimer: String) {
        resultLabel.text = sentNewInfoByTimer
    }
    
}

extension MLVisionViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
//        if let buffer = CMSampleBufferGetImageBuffer(sampleBuffer) {
//            var requestOptions: [VNImageOption : Any] = [:]
//            if let cameraIntrinsicData = CMGetAttachment(buffer, key: kCMSampleBufferAttachmentKey_CameraIntrinsicMatrix, attachmentModeOut: nil) {
//                requestOptions = [.cameraIntrinsics : cameraIntrinsicData]
//            }
            
//            let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: buffer, options: requestOptions)
//            if let coreMLRequest = domainModel.coreMLRequests {
//                do {
//                    try imageRequestHandler.perform([coreMLRequest])
//                } catch {
//                    print(error)
//                }
//            }
//        }
    }
    
}
