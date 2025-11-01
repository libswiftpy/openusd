//
//  UsdUtils.swift
//  openusd
//
//  Created by Tibor Felföldy on 2025-10-31.
//

import SwiftPy
import OpenUSD

@Scriptable(convertsToSnakeCase: false)
final class UsdUtils {
    static func CreateNewARKitUsdzPackage(assetPath: SdfAssetPath, outputPath: String, layerName: String) {
        pxr.UsdUtilsCreateNewARKitUsdzPackage(assetPath.base, std.string(outputPath), std.string(layerName))
    }
}
