import Foundation

public struct Vec3d {
	public var x: Double
	public var y: Double
	public var z: Double

	public init(_ x: Double, _ y: Double, _ z: Double) {
		self.x = x
		self.y = y
		self.z = z
	}

	public func magnitude() -> Double {
		return sqrt(x*x + y*y + z*z)
	}

	public func magnitudeSquared() -> Double {
		return x*x + y*y + z*z
	}
}

public func +(lhs: Vec3d, rhs: Vec3d) -> Vec3d { return Vec3d(lhs.x + rhs.x, lhs.y + rhs.y, lhs.z + rhs.z) }
public func -(lhs: Vec3d, rhs: Vec3d) -> Vec3d { return Vec3d(lhs.x - rhs.x, lhs.y - rhs.y, lhs.z - rhs.z) }
public func *(lhs: Vec3d, rhs: Double) -> Vec3d { return Vec3d(lhs.x * rhs, lhs.y * rhs, lhs.z * rhs) }
public func *(lhs: Double, rhs: Vec3d) -> Vec3d { return Vec3d(lhs * rhs.x, lhs * rhs.y, lhs * rhs.z) }
public func /(lhs: Vec3d, rhs: Double) -> Vec3d { return Vec3d(lhs.x / rhs, lhs.y / rhs, lhs.z / rhs) }
