public struct Complexd {
	public var r: Double
	public var i: Double

	init(_ r: Double, _ i: Double) {
		self.r = r
		self.i = i
	}

	public func conj() -> Complexd {
		return Complexd(r, -i)
	}
}

public func +(lhs: Complexd, rhs: Complexd) -> Complexd {
	return Complexd(lhs.r + rhs.r, lhs.i + rhs.i)
}

public func -(lhs: Complexd, rhs: Complexd) -> Complexd {
	return Complexd(lhs.r - rhs.r, lhs.i - rhs.i)
}
