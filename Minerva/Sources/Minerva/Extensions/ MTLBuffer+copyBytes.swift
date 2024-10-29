//
//  MTLBuffer+copyBytes.swift
//  Minerva
//
//  Created by Juan Hurtado on 25/10/24.
//

import Metal

extension MTLBuffer {
    func copyBytes(from source: UnsafeRawPointer, size: Int, atOffset offset: Int) {
        contents().copyMemory(
            from: source,
            byteCount: size,
            atOffset: offset
        )
    }
}
