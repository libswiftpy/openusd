//
//  Vt.swift
//  openusd
//
//  Created by Tibor Felföldy on 2025-11-03.
//

import SwiftPy
import OpenUSD

@Scriptable(convertsToSnakeCase: false)
public class Vt {}

extension [String] {
    func vtStringArray() -> pxr.VtStringArray {
        var array = pxr.VtStringArray()
        for element in self {
            array.push_back(std.string(element))
        }
        return array
    }
    
    func vtTokenArray() -> pxr.VtTokenArray {
        var array = pxr.VtTokenArray()
        for element in self {
            array.push_back(pxr.TfToken(element))
        }
        return array
    }
}

extension [Float] {
    func vtArray() -> pxr.VtFloatArray {
        var array = pxr.VtFloatArray()
        for element in self {
            array.push_back(element)
        }
        return array
    }
}
