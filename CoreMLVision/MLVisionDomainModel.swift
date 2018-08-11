//
//  MLVisionDomainModel.swift
//  CoreMLVision
//
//  Created by Ihor Malovanyi on 8/11/18.
//  Copyright © 2018 justDev. All rights reserved.
//

import UIKit
import AVFoundation

final class MLVisionDomainModel {
    
    private var videoCapturingFlow: VideoCapturingFlow!

    private weak var viewController: MLVisionViewController?
    
    init(for viewController: MLVisionViewController, responseFrequencyPerSecond: Int = 1) {
        videoCapturingFlow = VideoCapturingFlow(on: viewController.view,
                                                delegate: viewController)
    }

    func toggleCameraRunning() {
        videoCapturingFlow.toggleRunning()
    }
    
}
