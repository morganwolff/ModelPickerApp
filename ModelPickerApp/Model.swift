//
//  Model.swift
//  ModelPickerApp
//
//  Created by Morgan Wolff on 05/04/2023.
//

import UIKit
import RealityKit
import Combine

class Model {
    var modelName: String
    var image: UIImage
    var modelEntity: ModelEntity?
    private var cancellable: AnyCancellable? = nil
    
    init(modelName: String) {
        self.modelName = modelName
        self.image = UIImage(named: modelName)!
        let filename = modelName + ".usdz"
        self.cancellable = ModelEntity.loadModelAsync(named: filename)
            .sink(receiveCompletion: { loadCompletion in
                // Handle the errors
                print("DEBUG: Unable to load modelEntity for modelName: \(self.modelName)")
            }, receiveValue: { modelEntity in
                // Get the model entity
                self.modelEntity = modelEntity
                print("DEBUG: successfully loaded modelEntity for modelName: \(self.modelName)")
            })
    }
}
