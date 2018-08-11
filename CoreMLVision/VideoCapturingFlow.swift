//
//  VideoCapturingFlow.swift
//  CoreMLVision
//
//  Created by Ihor Malovanyi on 8/11/18.
//  Copyright © 2018 justDev. All rights reserved.
//
import UIKit
import AVFoundation

final class VideoCapturingFlow {
 
    private let captureSession = AVCaptureSession()
    private let captureQueue = DispatchQueue(label: "captureQueue")
    private var capturePreviewLayer: AVCaptureVideoPreviewLayer?
    
    var isRunning: Bool {
        return captureSession.isRunning
    }
    
    @discardableResult
    init(on view: UIView, delegate: AVCaptureVideoDataOutputSampleBufferDelegate? = nil) {
        if let camera = AVCaptureDevice.default(for: .video) {
            capturePreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            if let previewLayer = capturePreviewLayer {
                capturePreviewLayer?.frame = view.bounds
                view.layer.addSublayer(previewLayer)
            } else {
                fatalError("Can't create preview layer")
            }
            
            guard let cameraIn = try? AVCaptureDeviceInput(device: camera) else {
                fatalError("Can't create device camera input")
            }
            
            let videoOut = AVCaptureVideoDataOutput()
            
            videoOut.setSampleBufferDelegate(delegate, queue: captureQueue)
            videoOut.alwaysDiscardsLateVideoFrames = true
            videoOut.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String : kCVPixelFormatType_32BGRA]
            
            captureSession.sessionPreset = .high
            captureSession.addInput(cameraIn)
            captureSession.addOutput(videoOut)
            
            let connection = videoOut.connection(with: .video)
            connection?.videoOrientation = .portrait
        }
    }
    
    func toggleRunning() {
        captureSession.isRunning ? captureSession.stopRunning() : captureSession.startRunning()
    }
    
}
