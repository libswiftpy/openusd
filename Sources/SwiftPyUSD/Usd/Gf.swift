//
//  Gf.swift
//  openusd
//
//  Created by Tibor Felföldy on 2026-03-22.
//

import SwiftPy

@Scriptable(convertsToSnakeCase: false)
final class Gf: PythonBindable {
    static let Vec3d: object? = GfVec3d.pyTypeObject
}

@Scriptable("Gf.Vec3d", convertsToSnakeCase: false)
final class GfVec3d: PythonConvertible {
    internal let base: pxr.GfVec3d
    
    init(x: Double, y: Double, z: Double) {
        base = pxr.GfVec3d(x, y, z)
    }
}
