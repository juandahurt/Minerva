//
//  Library.swift
//  lulolib
//
//  Created by Juan Hurtado on 19/10/24.
//

protocol Library {
    associatedtype Key: Hashable
    associatedtype Value
    
    func load()
    func getValue(ofKey key: Key) -> Value
}
