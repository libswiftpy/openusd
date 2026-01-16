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
    static let Sphere: object? = UsdGeomSphere.pyType.object
}

@Scriptable("UsdGeom.Xform", convertsToSnakeCase: false)
final class UsdGeomXform {
    internal let base: pxr.UsdGeomXform
    
    internal init(base: pxr.UsdGeomXform) {
        self.base = base
    }
    
    static func Define(stage: UsdStage, path: String) -> UsdGeomXform {
        let base = pxr.UsdGeomXform.Define(Overlay.TfWeakPtr(stage.stage), pxr.SdfPath(path))
        return UsdGeomXform(base: base)
    }
}

@Scriptable("UsdGeom.Sphere", convertsToSnakeCase: false)
final class UsdGeomSphere {
    internal let base: pxr.UsdGeomSphere
    
    internal init(base: pxr.UsdGeomSphere) {
        self.base = base
    }
    
    static func Define(stage: UsdStage, path: String) -> UsdGeomSphere {
        let base = pxr.UsdGeomSphere.Define(Overlay.TfWeakPtr(stage.stage), pxr.SdfPath(path))
        return UsdGeomSphere(base: base)
    }
}
