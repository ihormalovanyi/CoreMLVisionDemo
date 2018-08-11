//
//  MLVisionViewController.swift
//  CoreMLVision
//
//  Created by Ihor Malovanyi on 8/11/18.
//  Copyright © 2018 justDev. All rights reserved.
//

import UIKit
import AVFoundation

class MLVisionViewController: UIViewController {

    private var resultLabel: UILabel!
    private var domainModel: MLVisionDomainModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        domainModel = MLVisionDomainModel(for: self)
        resultLabel = createInfoLabel()
        resultLabel.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                action: #selector(tap)))
        view.addSubview(resultLabel)
    }
    
    @objc private func tap() {
        domainModel.toggleCameraRunning()
    }
    
    private func createInfoLabel() -> UILabel {
        let label = UILabel()
        
        label.frame.size = CGSize(width: view.bounds.width - 30, height: view.bounds.height / 2 - 50)
        label.frame.origin = CGPoint(x: 15, y: view.bounds.height / 2)
        label.isUserInteractionEnabled = true
        label.numberOfLines = 3
        label.textAlignment = .left
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.text = "Tap to activate"
        
        return label
    }
    
}

extension MLVisionViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {}
    
}
