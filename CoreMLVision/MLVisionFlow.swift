//
//  MLVisionFlow.swift
//  CoreMLVision
//
//  Created by Ihor Malovanyi on 8/11/18.
//  Copyright © 2018 justDev. All rights reserved.
//

import Vision

final class MLVisionFlow {
    
    private(set) var coreMLRequest: VNCoreMLRequest!
    private(set) var foundCategories: [VNClassificationObservation]?
    
    init?(for model: MLModel, accuracy: Float? = nil) {
        guard let model = try? VNCoreMLModel(for: model) else { return nil }
        
        self.coreMLRequest = VNCoreMLRequest(model: model) { request, error in
            if let results = request.results as? [VNClassificationObservation] {
                self.foundCategories = results.filter {
                    return $0.confidence > accuracy ?? 0
                }
            }
        }
        
        coreMLRequest.imageCropAndScaleOption = .centerCrop
    }
    
}
