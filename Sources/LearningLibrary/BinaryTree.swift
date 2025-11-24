//
//  BinaryTrees.swift
//  LearningLibrary
//
//  Created by Aditya Raj on 24/11/25.
//

import Foundation

public class TreeNode<Value> {
    public var value: Value
    public var leftChild: TreeNode?
    public var rightChild: TreeNode?
    
    public init(value: Value, leftChild: TreeNode? = nil, rightChild: TreeNode? = nil) {
        self.value = value
        self.leftChild = leftChild
        self.rightChild = rightChild
    }
}

public struct BinaryTree<Value> {
    public var root: TreeNode<Value>?
    
    public init() {}
    
    public func depthFirstSearch() -> [Value] {
        guard let rootNode = root else {
            return []
        }
        
        var stack = StackArray<TreeNode<Value>>()
        stack.append(rootNode)
        
        var values: [Value] = []
        
        while !stack.isEmpty {
            guard let current = stack.remove() else { continue }
            values.append(current.value)
            
            if let right = current.rightChild {
                stack.append(right)
            }
            
            if let left = current.leftChild  {
                stack.append(left)
            }
        }
        
        return values
    }
    
    public func depthFirstSearch(root: TreeNode<Value>?) -> [Value] {
        guard let root = root else {
            return []
        }
        
        let leftChildren = depthFirstSearch(root: root.leftChild)
        let rightChildren = depthFirstSearch(root: root.rightChild)
        
        return [root.value] + leftChildren + rightChildren
    }
}

