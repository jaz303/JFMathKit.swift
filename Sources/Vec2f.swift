import Foundation

public struct Vec2f {
	public var x: Float
	public var y: Float

	public init(_ x: Float, _ y: Float) {
		self.x = x
		self.y = y
	}

	public func magnitude() -> Float {
		return sqrtf(x*x + y*y)
	}

	public func magnitudeSquared() -> Float {
		return x*x + y*y
	}
}

public func +(lhs: Vec2f, rhs: Vec2f) -> Vec2f { return Vec2f(lhs.x + rhs.x, lhs.y + rhs.y) }
public func -(lhs: Vec2f, rhs: Vec2f) -> Vec2f { return Vec2f(lhs.x - rhs.x, lhs.y - rhs.y) }
public func *(lhs: Vec2f, rhs: Float) -> Vec2f { return Vec2f(lhs.x * rhs, lhs.y * rhs) }
public func *(lhs: Float, rhs: Vec2f) -> Vec2f { return Vec2f(lhs * rhs.x, lhs * rhs.y) }
public func /(lhs: Vec2f, rhs: Float) -> Vec2f { return Vec2f(lhs.x / rhs, lhs.y / rhs) }
