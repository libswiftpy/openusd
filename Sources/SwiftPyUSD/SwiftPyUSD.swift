// The Swift Programming Language
// https://docs.swift.org/swift-book

import OpenUSD
import SwiftPy

public typealias pxr = pxrInternal_v0_25_8__pxrReserved__

@MainActor
public enum SwiftPyUSD {
    public static func initialize() {
        Interpreter.bundles.append(.module)
        Interpreter.bindModule("pxr", [
            Usd.self,
            Stage.self,
        ])
    }
}
