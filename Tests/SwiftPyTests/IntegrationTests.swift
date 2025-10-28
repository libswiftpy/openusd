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
func pythonExample() {
    SwiftPyUSD.initialize()
    
    Interpreter.run("""
    from pxr import Usd
    stage = Usd.Stage.create_new('HelloWorldRedux.usda')
    stage.define_prim('/hello', 'Xform')
    stage.define_prim('/hello/world', 'Sphere')
    layer = stage.get_root_layer()
    layer.save()
    print(layer.real_path)
    """)

    Interpreter.run("""
    stage = Usd.Stage.open('HelloWorldRedux.usda')
    content = stage.export_to_string()
    """)

    Interpreter.run("content", mode: .single)

    #expect(Interpreter.evaluate("content") != String?.none)
}
