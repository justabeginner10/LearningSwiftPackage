import Foundation

//MARK: - Stack
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
 
//MARK: - Queue
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

//MARK: - Binary Tree
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


var binaryTree = BinaryTree<String>()

@MainActor
func setupBinaryTree() {
    binaryTree.root = .init(value: "a")

    let bNode = TreeNode(value: "b")
    let cNode = TreeNode(value: "c")
    let dNode = TreeNode(value: "d")
    let eNode = TreeNode(value: "e")
    let fNode = TreeNode(value: "f")

    cNode.rightChild = fNode

    bNode.leftChild = dNode
    bNode.rightChild = eNode

    binaryTree.root?.leftChild = bNode
    binaryTree.root?.rightChild = cNode
}
setupBinaryTree()

// MARK: - Searching an element in our binary search tree.
/// Space Complx: O(n)
/// Time  Complx: O(n)
let result = binaryTree.depthFirstSearch()
//print(result)
//print(result.contains("g"))

// RECURSIVELY FINDING THE ELEMENT IN BST
/// Return false when node is null and true when node found -> My base cases for recursion

func checkIfPresent(in root: TreeNode<String>?, target: String) -> Bool {
    if let root = root {
        if root.value == target { return true }
    } else {
        return false
    }
    
    return checkIfPresent(in: root?.leftChild, target: target) || checkIfPresent(in: root?.rightChild, target: target)
}

print(checkIfPresent(in: binaryTree.root, target: "e"))

func calculateTotalSum(for root: TreeNode<Int>?) -> Int {
    guard let root else { return 0 }
    return (root.value) + calculateTotalSum(for: root.leftChild) + calculateTotalSum(for: root.rightChild)
}

var binaryTreeWithIntValues: BinaryTree<Int> = .init()

@MainActor
func setupBinaryTreeWithIntValues() {
    binaryTreeWithIntValues.root = .init(value: 5)

    let bNode = TreeNode(value: 11)
    let cNode = TreeNode(value: 3)
    let dNode = TreeNode(value: 4)
    let eNode = TreeNode(value: 2)
    let fNode = TreeNode(value: 1)

    cNode.rightChild = fNode

    bNode.leftChild = dNode
    bNode.rightChild = eNode

    binaryTreeWithIntValues.root?.leftChild = bNode
    binaryTreeWithIntValues.root?.rightChild = cNode
}
setupBinaryTreeWithIntValues()

//print(binaryTreeWithIntValues.breadthFirstSearch())
//print(calculateTotalSum(for: binaryTreeWithIntValues.root))
// 3
// 11 4
// 4 2 1

// Finding Maximum Root to Leaf Path Sum
func calculateMaximumRootToLeafPathSum(root: TreeNode<Int>?) -> Int {
    guard let root else { return Int.min }
    if root.leftChild == nil && root.rightChild == nil { return root.value }
    
    return root.value + max(calculateMaximumRootToLeafPathSum(root: root.leftChild), calculateMaximumRootToLeafPathSum(root: root.rightChild))
}

print(calculateMaximumRootToLeafPathSum(root: binaryTreeWithIntValues.root))
print(binaryTreeWithIntValues.breadthFirstSearch())
