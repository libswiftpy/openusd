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
    static let Prim: object? = UsdPrim.pyType.object
}

@Scriptable("Usd.Stage", convertsToSnakeCase: false)
public class UsdStage {
    internal let stage: pxr.UsdStage
    
    internal init(_ stage: pxr.UsdStageRefPtr) {
        self.stage = Overlay.Dereference(stage)
    }
    
    func DefinePrim(path: String, typeName: String) -> UsdPrim? {
        let path = pxr.SdfPath(path)
        let typeName = pxr.TfToken(typeName)
        let prim = stage.DefinePrim(path, typeName)
        return UsdPrim(prim)
    }
    
    func GetPrimAtPath(path: String) -> UsdPrim? {
        let path = pxr.SdfPath(path)
        let prim = stage.GetPrimAtPath(path)
        return UsdPrim(prim)
    }

    func ExportToString() -> String? {
        stage.ExportToString()
    }

    func GetRootLayer() -> SdfLayer {
        SdfLayer(layer: stage.GetRootLayer())
    }
    
    static func CreateNew(name: String) -> UsdStage? {
        UsdStage(pxr.UsdStage.CreateNew(std.string(name)))
    }

    static func CreateInMemory() -> UsdStage? {
        UsdStage(pxr.UsdStage.CreateInMemory())
    }
    
    static func Open(name: String) -> UsdStage? {
        UsdStage(pxr.UsdStage.Open(std.string(name)))
    }
}

@Scriptable("Usd.Prim", convertsToSnakeCase: false)
public class UsdPrim: ObjectWrapper<pxr.UsdPrim> {
    func GetPropertyNames() -> [String] {
        base.GetPropertyNames(Overlay.DefaultPropertyPredicateFunc)
            .map { token in
                String(token.GetString())
            }
    }

    func GetAttribute(name: String) -> UsdAttribute? {
        UsdAttribute(base.GetAttribute(pxr.TfToken(name)))
    }
}

@Scriptable("Usd.Attribute", convertsToSnakeCase: false)
public class UsdAttribute: ObjectWrapper<pxr.UsdAttribute> {
    func Get() -> object? {
        var value = pxr.VtValue()
        if base.Get(&value) {
            return nil
        }
        let type = value.GetType()
        let result = pxr.VtValue.Cast(value, T: pxr.VtVec3fArray.self)
        return nil
    }
}

public protocol UsdObject {
    func IsValid() -> Bool
}

extension pxr.UsdAttribute: UsdObject {}
extension pxr.UsdPrim: UsdObject {}

public class ObjectWrapper<T: UsdObject> {
    let base: T

    init?(_ base: T) {
        guard base.IsValid() else {
            return nil
        }
        self.base = base
    }
}
