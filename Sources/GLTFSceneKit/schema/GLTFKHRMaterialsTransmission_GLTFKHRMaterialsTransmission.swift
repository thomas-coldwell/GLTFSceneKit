//
//  GLTFKHRMaterialsTransmission_GLTFKHRMaterialsTransmission.swift
//  GLTFSceneKit
//
//  Created by Thomas Coldwell on 21/06/2022.
//

import Foundation
import SceneKit

struct GLTFKHRMaterialsTransmission_GLTFKHRMaterialsTransmissionExtension: GLTFCodable {
    struct GLTFKHRMaterialsTransmission_GLTFKHRMaterialsTransmission: Codable {
          
        let _transmissionFactor: Float?
        var transmissionFactor: Float {
            get { return self._transmissionFactor ?? 1 }
        }
        private enum CodingKeys: String, CodingKey {
            case _transmissionFactor = "transmissionFactor"
        }
    
    }
  
    let data: GLTFKHRMaterialsTransmission_GLTFKHRMaterialsTransmission?
    
    enum CodingKeys: String, CodingKey {
        case data = "KHR_materials_transmission"
    }
    
    func didLoad(by object: Any, unarchiver: GLTFUnarchiver) {
        guard let data = self.data else { return }
        guard let material = object as? SCNMaterial else { return }
      
      // Transmission relies on PBR
      material.lightingModel = .physicallyBased
      
      // Shader uniforms
      material.setValue(data.transmissionFactor, forKeyPath: "transmissionFactor")
      material.setValue(
        material.blendMode == .alpha ? 1 : 0,
        forKeyPath: "alphaBlend"
      )
      
      let fragShaderFile = Bundle.main.path(forResource: "GLTFShaderModifierFragment_transmission", ofType: "shader")
      let fragShader = try! String(contentsOfFile: fragShaderFile!, encoding: .utf8)
      
      material.shaderModifiers = [
        .fragment: fragShader
      ]
      
    }
}



