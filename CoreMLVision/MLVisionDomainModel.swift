//
//  MLVisionDomainModel.swift
//  CoreMLVision
//
//  Created by Ihor Malovanyi on 8/11/18.
//  Copyright © 2018 justDev. All rights reserved.
//

import UIKit
import Vision
import AVFoundation

protocol MLVisionDomainModelDelegate: class {
    
    func visionDomainModel(visionDomainModel: MLVisionDomainModel, sentNewInfoByTimer: String)
    
}

final class MLVisionDomainModel {
    
    private var model = ImageClassifierDemo().model
    private var videoCapturingFlow: VideoCapturingFlow!
    private var mlVisionFlow: MLVisionFlow?
    private var frequencyTimer: Timer!
    private var timeInterval: Double!
    
    private weak var viewController: MLVisionViewController?

    weak var delegate: MLVisionDomainModelDelegate?
    
    var coreMLRequests: VNCoreMLRequest? {
        return mlVisionFlow?.coreMLRequest
    }
    
    var foundCategories: [VNClassificationObservation]? {
        return mlVisionFlow?.foundCategories
    }
    
    var foundCategoriesTextRepresentation: String {
        var finalString = "Nothing founded"
        if let foundCategories = foundCategories {
            finalString = foundCategories.map { "\($0.identifier) - \(String(format: "%.2f", $0.confidence))%" }.joined(separator: "\n")
        }
        return finalString
    }
    
    init(for viewController: MLVisionViewController, responseFrequencyPerSecond: Int = 1) {
        videoCapturingFlow = VideoCapturingFlow(on: viewController.view,
                                                delegate: viewController)
        mlVisionFlow = MLVisionFlow(for: model)
        
        timeInterval = 1 / Double(responseFrequencyPerSecond)
    }
    
    private func startTimer() {
        frequencyTimer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true, block: { _ in
            self.delegate?.visionDomainModel(visionDomainModel: self, sentNewInfoByTimer: self.foundCategoriesTextRepresentation)
        })
    }
    
    private func stopTimer() {
        frequencyTimer.invalidate()
    }

    func toggleCameraRunning() {
        videoCapturingFlow.toggleRunning()
        videoCapturingFlow.isRunning ? startTimer() : stopTimer()
    }
    
}
