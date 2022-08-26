import Foundation

open class Queue<T> {
	private var headArray: [T]
	private var tailArray: [T]
	
	private let _lock: NSLock
	private let isThreadSafe: Bool
	
	init(withLock: Bool = false) {
		self.headArray = []
		self.tailArray = []
		self._lock = NSLock()
		self.isThreadSafe = withLock
	}
	
	open var count: Int {
		return headArray.count + tailArray.count
	}
	
	open var isEmpty: Bool {
		return headArray.isEmpty && tailArray.isEmpty
	}
	
	open func push(_ element: T) {
		lock()
		defer { unlock() }
		
		headArray.append(element)
	}
	
	open func pop() -> T? {
		lock()
		defer { unlock() }
		
		if tailArray.isEmpty {
			tailArray = headArray.reversed()
			headArray.removeAll()
		}
		return headArray.popLast()
		
	}
	
	open func getData() -> [T] {
		lock()
		defer { unlock() }
		
		return headArray.reversed() + tailArray
	}
	
	private func lock() {
		if isThreadSafe {
			_lock.lock()
		}
	}
	
	private func unlock() {
		if isThreadSafe {
			_lock.unlock()
		}
	}
}


