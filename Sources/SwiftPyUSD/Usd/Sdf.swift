//
//  Sdf.swift
//  openusd
//
//  Created by Tibor Felföldy on 2025-10-31.
//

import SwiftPy
import OpenUSD

extension PythonBindable {
    typealias object = PyAPI.Reference
}

@MainActor
@Scriptable(convertsToSnakeCase: false)
final class Sdf: PythonBindable {
    static let AssetPath: object? = SdfAssetPath.pyType.object
    static let Layer: object? = SdfLayer.pyType.object
}

@Scriptable("Sdf.AssetPath", convertsToSnakeCase: false)
final class SdfAssetPath {
    internal let base: pxr.SdfAssetPath
    
    init(path: String) {
        self.base = pxr.SdfAssetPath(std.string(path))
    }
}

@Scriptable("Sdf.Layer", convertsToSnakeCase: false)
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
