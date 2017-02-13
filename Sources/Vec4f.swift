import Foundation

public struct Vec4f {
	public var x: Float
	public var y: Float
	public var z: Float
	public var w: Float

	public init(_ x: Float, _ y: Float, _ z: Float, _ w: Float) {
		self.x = x
		self.y = y
		self.z = z
		self.w = w
	}

	public func magnitude() -> Float {
		return sqrtf(x*x + y*y + z*z + w*w)
	}

	public func magnitudeSquared() -> Float {
		return x*x + y*y + z*z + w*w
	}
}

public func +(lhs: Vec4f, rhs: Vec4f) -> Vec4f { return Vec4f(lhs.x + rhs.x, lhs.y + rhs.y, lhs.z + rhs.z, lhs.w + rhs.w) }
public func -(lhs: Vec4f, rhs: Vec4f) -> Vec4f { return Vec4f(lhs.x - rhs.x, lhs.y - rhs.y, lhs.z - rhs.z, lhs.w - rhs.w) }
public func *(lhs: Vec4f, rhs: Float) -> Vec4f { return Vec4f(lhs.x * rhs, lhs.y * rhs, lhs.z * rhs, lhs.w * rhs) }
public func *(lhs: Float, rhs: Vec4f) -> Vec4f { return Vec4f(lhs * rhs.x, lhs * rhs.y, lhs * rhs.z, lhs * rhs.w) }
public func /(lhs: Vec4f, rhs: Float) -> Vec4f { return Vec4f(lhs.x / rhs, lhs.y / rhs, lhs.z / rhs, lhs.w / rhs) }
