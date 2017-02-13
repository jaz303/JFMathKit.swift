public struct Complexf {
	public var r: Float
	public var i: Float

	init(_ r: Float, _ i: Float) {
		self.r = r
		self.i = i
	}

	public func conj() -> Complexf {
		return Complexf(r, -i)
	}
}

public func +(lhs: Complexf, rhs: Complexf) -> Complexf {
	return Complexf(lhs.r + rhs.r, lhs.i + rhs.i)
}

public func -(lhs: Complexf, rhs: Complexf) -> Complexf {
	return Complexf(lhs.r - rhs.r, lhs.i - rhs.i)
}