//
//  File.swift
//  LearningLibrary
//
//  Created by Aditya Raj on 27/10/25.
//

import Foundation

public protocol Queue {
    associatedtype Element
    @discardableResult mutating func enqueue(_ element: Element) -> Bool
    mutating func dequeue() -> Element?
    var isEmpty: Bool { get }
    var peek: Element? { get }
}

public struct QueueArray<T>: Queue {
    private var array: [T] = []
    
    public init() {}
    
    public var peek: T? {
        return array.first
    }
    
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    @discardableResult
    public mutating func enqueue(_ element: T) -> Bool {
        array.append(element)
        return true
    }
    
    public mutating func dequeue() -> T? {
        isEmpty ? nil : array.removeFirst()
    }
}

extension QueueArray: CustomStringConvertible {
    public var description: String {
        String(describing: array)
    }
}
