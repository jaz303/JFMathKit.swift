import Foundation

public struct Vec3f {
	public var x: Float
	public var y: Float
	public var z: Float

	public init(_ x: Float, _ y: Float, _ z: Float) {
		self.x = x
		self.y = y
		self.z = z
	}

	public func magnitude() -> Float {
		return sqrtf(x*x + y*y + z*z)
	}

	public func magnitudeSquared() -> Float {
		return x*x + y*y + z*z
	}
}

public func +(lhs: Vec3f, rhs: Vec3f) -> Vec3f { return Vec3f(lhs.x + rhs.x, lhs.y + rhs.y, lhs.z + rhs.z) }
public func -(lhs: Vec3f, rhs: Vec3f) -> Vec3f { return Vec3f(lhs.x - rhs.x, lhs.y - rhs.y, lhs.z - rhs.z) }
public func *(lhs: Vec3f, rhs: Float) -> Vec3f { return Vec3f(lhs.x * rhs, lhs.y * rhs, lhs.z * rhs) }
public func *(lhs: Float, rhs: Vec3f) -> Vec3f { return Vec3f(lhs * rhs.x, lhs * rhs.y, lhs * rhs.z) }
public func /(lhs: Vec3f, rhs: Float) -> Vec3f { return Vec3f(lhs.x / rhs, lhs.y / rhs, lhs.z / rhs) }
