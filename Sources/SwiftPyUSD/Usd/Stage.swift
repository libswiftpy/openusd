//
//  Stage.swift
//  openusd
//
//  Created by Tibor Felföldy on 2025-10-28.
//

import SwiftPy
import OpenUSD

@Scriptable
public class Usd {}

@Scriptable
public class Stage {
    internal let stage: pxr.UsdStageRefPtr
    
    internal init(stage: pxr.UsdStageRefPtr) {
        self.stage = stage
    }

    func DefinePrim(path: String, typeName: String) {
        let stageRef = Overlay.Dereference(stage)
        let path = pxr.SdfPath(path)
        let typeName = pxr.TfToken(typeName)
        stageRef.DefinePrim(path, typeName)
    }

    func ExportToString() -> String? {
        let stageRef = Overlay.Dereference(stage)
        return stageRef.ExportToString()
    }

    func GetRootLayer() -> SdfLayer {
        let stageRef = Overlay.Dereference(stage)
        return SdfLayer(layer: stageRef.GetRootLayer())
    }
    
    static func CreateNew(name: String) -> Stage {
        Stage(stage: pxr.UsdStage.CreateNew(std.__1.string(name)))
    }

    static func CreateInMemory() -> Stage {
        Stage(stage: pxr.UsdStage.CreateInMemory())
    }
    
    static func Open(name: String) -> Stage? {
        Stage(stage: pxr.UsdStage.Open(std.__1.string(name)))
    }
}

@Scriptable
public class SdfLayer {
    internal let layer: pxr.SdfLayerHandle

    var realPath: String {
        let layerRef = Overlay.Dereference(layer)
        return String(layerRef.GetRealPath())
    }
    
    internal init(layer: pxr.SdfLayerHandle) {
        self.layer = layer
    }

    func Save() {
        let layerRef = Overlay.Dereference(layer)
        layerRef.Save()
    }
}
