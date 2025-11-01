//
//  UsdGeom.swift
//  openusd
//
//  Created by Tibor Felföldy on 2025-11-01.
//

import SwiftPy
import OpenUSD

@MainActor
@Scriptable(convertsToSnakeCase: false)
final class UsdGeom {
    static let Xform: object? = UsdGeomXform.pyType.object
}

@Scriptable(convertsToSnakeCase: false)
final class UsdGeomXform {
    static func Define(stage: UsdStage, path: String) {
        let stageRef = Overlay.Dereference(stage.stage)
        //pxr.UsdGeomXform.Define(stageRef, pxr.SdfPath(path))
    }
}
