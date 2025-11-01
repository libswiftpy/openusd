//
//  IntegrationTests.swift
//  openusd
//
//  Created by Tibor Felföldy on 2025-10-28.
//

import Testing
import SwiftPyUSD
import SwiftPy

@MainActor
@Test
func pythonExample() async {
    SwiftPyUSD.initialize()
    
    Interpreter.run("""
    from pxr import Usd
    stage = Usd.Stage.CreateNew('HelloWorldRedux.usda')
    stage.DefinePrim('/hello', 'Xform')
    stage.DefinePrim('/hello/world', 'Sphere')
    layer = stage.GetRootLayer()
    layer.Save()
    print(layer.real_path)
    """)

    #expect(StageView(.main["view"]) != nil)
}
