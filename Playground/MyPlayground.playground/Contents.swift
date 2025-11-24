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
        return self.array.removeLast()
    }
}

extension StackArray: CustomStringConvertible {
    public var description: String {
        String(describing: array)
    }
}


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

extension TreeNode: CustomStringConvertible {
    public var description: String {
        String(describing: value)
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
}

extension BinaryTree: CustomStringConvertible {
    public var description: String {
        String(describing: root)
    }
}

var binaryTree = BinaryTree<String>()
binaryTree.root = .init(value: "a")

var bNode = TreeNode(value: "b")
var cNode = TreeNode(value: "c")
var dNode = TreeNode(value: "d")
var eNode = TreeNode(value: "e")
var fNode = TreeNode(value: "f")

cNode.rightChild = fNode

bNode.leftChild = dNode
bNode.rightChild = eNode

binaryTree.root?.leftChild = bNode
binaryTree.root?.rightChild = cNode

binaryTree.depthFirstSearch()
