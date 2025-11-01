//
//  Usd.swift
//  openusd
//
//  Created by Tibor Felföldy on 2025-10-31.
//

import SwiftPy
import OpenUSD

@MainActor
@Scriptable(convertsToSnakeCase: false)
public class Usd {
    static let Stage: object? = UsdStage.pyType.object
}

@Scriptable("Usd.Stage", convertsToSnakeCase: false)
public class UsdStage {
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
    
    static func CreateNew(name: String) -> UsdStage {
        UsdStage(stage: pxr.UsdStage.CreateNew(std.string(name)))
    }

    static func CreateInMemory() -> UsdStage {
        UsdStage(stage: pxr.UsdStage.CreateInMemory())
    }
    
    static func Open(name: String) -> UsdStage? {
        UsdStage(stage: pxr.UsdStage.Open(std.string(name)))
    }
}
