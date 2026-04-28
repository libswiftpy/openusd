//
//  UsdSkel.swift
//  swiftpy-usd
//
//  Created by Tibor Felföldy on 2026-04-28.
//

import SwiftPy

@MainActor
public func bindModule() {
    PyBind.module("pxr.UsdSkel") { UsdSkel in
        UsdSkel.classes(
            Animation.self,
            BindingAPI.self,
        )
    }
}
