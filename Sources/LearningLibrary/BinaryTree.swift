//
//  BinaryTrees.swift
//  LearningLibrary
//
//  Created by Aditya Raj on 24/11/25.
//

import Foundation

public class TreeNode<Value: Equatable> {
    public var value: Value
    public var leftChild: TreeNode?
    public var rightChild: TreeNode?
    
    public init(value: Value, leftChild: TreeNode? = nil, rightChild: TreeNode? = nil) {
        self.value = value
        self.leftChild = leftChild
        self.rightChild = rightChild
    }
}

public struct BinaryTree<Value: Equatable> {
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
    
    public func breadthFirstSearch() -> [Value] {
        guard let root = root else {
            return []
        }
        
        var queue: QueueArray<TreeNode<Value>> = .init()
        queue.enqueue(root)
        
        var values: [Value] = []
        
        while !queue.isEmpty {
            if let current = queue.dequeue() {
                values.append(current.value)
                
                if let leftChild = current.leftChild {
                    queue.enqueue(leftChild)
                }
                
                if let rightChild = current.rightChild {
                    queue.enqueue(rightChild)
                }
            }
        }
        
        return values
    }
    
    public func breadthFirstSearch(root: TreeNode<Value>?) -> [Value] {
        guard let root = root else {
            return []
        }
        
        let leftChildren = depthFirstSearch(root: root.leftChild)
        let rightChildren = depthFirstSearch(root: root.rightChild)
        
        return [root.value] + leftChildren + rightChildren
    }
}

extension BinaryTree {
    
    /// Method to checks if particular value is present in the tree of not
    public func checkIfPresent(for root: TreeNode<Value>?, target: Value) -> Bool {
        if let root = root {
            if root.value == target { return true }
        } else {
            return false
        }
        
        return checkIfPresent(for: root?.leftChild, target: target) || checkIfPresent(for: root?.rightChild, target: target)
    }
    
    /// <T: AdditiveArithmetic> tells the compiler:
    /// "Accept any type T, as long as it supports '+' and has a '.zero' property"
    public func calculateTotalSum<T: AdditiveArithmetic>(for root: TreeNode<T>?) -> T {
        /// This works for Int, Double, CGFloat, Float, etc.
        guard let root = root else { return .zero }
        
        /// 2. The + operator is now guaranteed to exist
        return root.value + calculateTotalSum(for: root.leftChild) + calculateTotalSum(for: root.rightChild)
    }
    
    public func calculateMaximumRootToLeafPathSum(for root: TreeNode<Int>?) -> Int {
        guard let root = root else { return Int.min }
        if root.leftChild == nil && root.rightChild == nil {
            return root.value
        }
        
        return root.value + max(calculateMaximumRootToLeafPathSum(for: root.leftChild), calculateMaximumRootToLeafPathSum(for: root.rightChild))
    }
    
    public func calculateMaximumRootToLeafPathSum(for root: TreeNode<Double>?) -> Double {
        guard let root = root else { return -(.infinity) }
        if root.leftChild == nil && root.rightChild == nil {
            return root.value
        }
        
        return root.value + max(calculateMaximumRootToLeafPathSum(for: root.leftChild), calculateMaximumRootToLeafPathSum(for: root.rightChild))
    }
    
    public func calculateMaximumRootToLeafPathSum(for root: TreeNode<CGFloat>?) -> CGFloat {
        guard let root = root else { return -(.infinity) }
        if root.leftChild == nil && root.rightChild == nil {
            return root.value
        }
        
        return root.value + max(calculateMaximumRootToLeafPathSum(for: root.leftChild), calculateMaximumRootToLeafPathSum(for: root.rightChild))
    }
}
