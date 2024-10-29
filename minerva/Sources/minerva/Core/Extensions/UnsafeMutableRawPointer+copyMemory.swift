//
//  UnsafeMutableRawPointer+copyMemory.swift
//  Minerva
//
//  Created by Juan Hurtado on 25/10/24.
//

extension UnsafeMutableRawPointer {
    func copyMemory(
        from source: UnsafeRawPointer,
        byteCount: Int,
        atOffset offset: Int
    ) {
        // advance by the desaired offset
        let advancedPointer = advanced(by: offset)
        // copy the bytes
        advancedPointer.copyMemory(
            from: source,
            byteCount: byteCount
        )
    }
}
