import Foundation

public struct Vec2d {
	public var x: Double
	public var y: Double

	public init(_ x: Double, _ y: Double) {
		self.x = x
		self.y = y
	}

	public func magnitude() -> Double {
		return sqrt(x*x + y*y)
	}

	public func magnitudeSquared() -> Double {
		return x*x + y*y
	}
}

public func +(lhs: Vec2d, rhs: Vec2d) -> Vec2d { return Vec2d(lhs.x + rhs.x, lhs.y + rhs.y) }
public func -(lhs: Vec2d, rhs: Vec2d) -> Vec2d { return Vec2d(lhs.x - rhs.x, lhs.y - rhs.y) }
public func *(lhs: Vec2d, rhs: Double) -> Vec2d { return Vec2d(lhs.x * rhs, lhs.y * rhs) }
public func *(lhs: Double, rhs: Vec2d) -> Vec2d { return Vec2d(lhs * rhs.x, lhs * rhs.y) }
public func /(lhs: Vec2d, rhs: Double) -> Vec2d { return Vec2d(lhs.x / rhs, lhs.y / rhs) }
