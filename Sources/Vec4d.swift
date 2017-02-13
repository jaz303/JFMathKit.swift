import Foundation

public struct Vec4d {
	public var x: Double
	public var y: Double
	public var z: Double
	public var w: Double

	public init(_ x: Double, _ y: Double, _ z: Double, _ w: Double) {
		self.x = x
		self.y = y
		self.z = z
		self.w = w
	}

	public func magnitude() -> Double {
		return sqrt(x*x + y*y + z*z + w*w)
	}

	public func magnitudeSquared() -> Double {
		return x*x + y*y + z*z + w*w
	}
}

public func +(lhs: Vec4d, rhs: Vec4d) -> Vec4d { return Vec4d(lhs.x + rhs.x, lhs.y + rhs.y, lhs.z + rhs.z, lhs.w + rhs.w) }
public func -(lhs: Vec4d, rhs: Vec4d) -> Vec4d { return Vec4d(lhs.x - rhs.x, lhs.y - rhs.y, lhs.z - rhs.z, lhs.w - rhs.w) }
public func *(lhs: Vec4d, rhs: Double) -> Vec4d { return Vec4d(lhs.x * rhs, lhs.y * rhs, lhs.z * rhs, lhs.w * rhs) }
public func *(lhs: Double, rhs: Vec4d) -> Vec4d { return Vec4d(lhs * rhs.x, lhs * rhs.y, lhs * rhs.z, lhs * rhs.w) }
public func /(lhs: Vec4d, rhs: Double) -> Vec4d { return Vec4d(lhs.x / rhs, lhs.y / rhs, lhs.z / rhs, lhs.w / rhs) }
