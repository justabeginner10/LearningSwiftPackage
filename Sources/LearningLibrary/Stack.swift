//
//  Stack.swift
//  LearningLibrary
//
//  Created by Aditya Raj on 24/11/25.
//

import Foundation

public protocol Stack {
    associatedtype Element
    mutating func append(_ element: Element)
    mutating func remove() -> Element?
    var isEmpty: Bool { get }
    var peek: Element? { get }
}

public struct StackArray<T>: Stack {
    private var array: [T] = []
    
    public init() { }
    
    public var peek: T? {
        return array.last
    }
    
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    public mutating func append(_ element: T) {
        self.array.append(element)
    }
    
    public mutating func remove() -> T? {
        return self.array.popLast()
    }
}

extension StackArray: CustomStringConvertible {
    public var description: String {
        String(describing: array)
    }
}
 
