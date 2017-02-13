import Foundation

// TODO: getTranslation
// TODO: getScaling
// TODO: getRotation
// TODO: quaternion stuff
public struct Mat4f {
	var v00, v01, v02, v03,
		v10, v11, v12, v13,
		v20, v21, v22, v23,
		v30, v31, v32, v33 : Float;

	public static func copy(_ out: inout Mat4f, _ a: inout Mat4f) {
		out.v00 = a.v00; out.v01 = a.v01; out.v02 = a.v02; out.v03 = a.v03
		out.v10 = a.v10; out.v11 = a.v11; out.v12 = a.v12; out.v13 = a.v13
		out.v20 = a.v20; out.v21 = a.v21; out.v22 = a.v22; out.v23 = a.v23
		out.v30 = a.v30; out.v31 = a.v31; out.v32 = a.v32; out.v33 = a.v33
	}

	public static func identity(_ out: inout Mat4f) {
		out.v00 = 1.0; out.v01 = 0.0; out.v02 = 0.0; out.v03 = 0.0
		out.v10 = 0.0; out.v11 = 1.0; out.v12 = 0.0; out.v13 = 0.0
		out.v20 = 0.0; out.v21 = 0.0; out.v22 = 1.0; out.v23 = 0.0
		out.v30 = 0.0; out.v31 = 0.0; out.v32 = 0.0; out.v33 = 1.0
	}

	// out = transpose(out)
	public static func transpose(_ out: inout Mat4f) {
		let v01 = out.v01, v02 = out.v02, v03 = out.v03,
			v12 = out.v12, v13 = out.v13,
			v23 = out.v23
		out.v01 = out.v10
        out.v02 = out.v20
        out.v03 = out.v30
        out.v10 = v01
        out.v12 = out.v21
        out.v13 = out.v31
        out.v20 = v02
        out.v21 = v12
        out.v23 = out.v32
        out.v30 = v03
        out.v31 = v13
        out.v32 = v23
    }

	// out = transpose(a)
	public static func transpose(_ out: inout Mat4f, _ a: inout Mat4f) {
        out.v00 = a.v00
        out.v01 = a.v10
        out.v02 = a.v20
        out.v03 = a.v30
        out.v10 = a.v01
        out.v11 = a.v11
        out.v12 = a.v21
        out.v13 = a.v31
        out.v20 = a.v02
        out.v21 = a.v12
        out.v22 = a.v22
        out.v23 = a.v32
        out.v30 = a.v03
        out.v31 = a.v13
        out.v32 = a.v23
        out.v33 = a.v33
	}

	public static func invert(_ out: inout Mat4f) -> Bool {
		let b00 = out.v00 * out.v11 - out.v01 * out.v10
		let b01 = out.v00 * out.v12 - out.v02 * out.v10
		let b02 = out.v00 * out.v13 - out.v03 * out.v10
		let b03 = out.v01 * out.v12 - out.v02 * out.v11
		let b04 = out.v01 * out.v13 - out.v03 * out.v11
		let b05 = out.v02 * out.v13 - out.v03 * out.v12
		let b06 = out.v20 * out.v31 - out.v21 * out.v30
		let b07 = out.v20 * out.v32 - out.v22 * out.v30
		let b08 = out.v20 * out.v33 - out.v23 * out.v30
		let b09 = out.v21 * out.v32 - out.v22 * out.v31
		let b10 = out.v21 * out.v33 - out.v23 * out.v31
		let b11 = out.v21 * out.v33 - out.v23 * out.v32

		let i1 = b00 * b11
		let i2 = b01 * b10
		let i3 = b02 * b09
		let i4 = b03 * b08
		let i5 = b04 * b07
		let i6 = b05 * b06

		var det = i1 - i2 + i3 + i4 - i5 + i6

		if det == 0 {
			return false
		}

		det = 1.0 / det

		out.v00 = (out.v11 * b11 - out.v12 * b10 + out.v13 * b09) * det;
	    out.v01 = (out.v02 * b10 - out.v01 * b11 - out.v03 * b09) * det;
	    out.v02 = (out.v31 * b05 - out.v32 * b04 + out.v33 * b03) * det;
	    out.v03 = (out.v22 * b04 - out.v21 * b05 - out.v23 * b03) * det;
	    out.v10 = (out.v12 * b08 - out.v10 * b11 - out.v13 * b07) * det;
	    out.v11 = (out.v00 * b11 - out.v02 * b08 + out.v03 * b07) * det;
	    out.v12 = (out.v32 * b02 - out.v30 * b05 - out.v33 * b01) * det;
	    out.v13 = (out.v20 * b05 - out.v22 * b02 + out.v23 * b01) * det;
	    out.v20 = (out.v10 * b10 - out.v11 * b08 + out.v13 * b06) * det;
	    out.v21 = (out.v01 * b08 - out.v00 * b10 - out.v03 * b06) * det;
	    out.v22 = (out.v30 * b04 - out.v31 * b02 + out.v33 * b00) * det;
	    out.v23 = (out.v21 * b02 - out.v20 * b04 - out.v23 * b00) * det;
	    out.v30 = (out.v11 * b07 - out.v10 * b09 - out.v12 * b06) * det;
	    out.v31 = (out.v00 * b09 - out.v01 * b07 + out.v02 * b06) * det;
	    out.v32 = (out.v31 * b01 - out.v30 * b03 - out.v32 * b00) * det;
	    out.v33 = (out.v20 * b03 - out.v21 * b01 + out.v22 * b00) * det;

		return true
	}

	public static func invert(_ out: inout Mat4f, _ a: inout Mat4f) -> Bool {
		let b00 = a.v00 * a.v11 - a.v01 * a.v10
		let b01 = a.v00 * a.v12 - a.v02 * a.v10
		let b02 = a.v00 * a.v13 - a.v03 * a.v10
		let b03 = a.v01 * a.v12 - a.v02 * a.v11
		let b04 = a.v01 * a.v13 - a.v03 * a.v11
		let b05 = a.v02 * a.v13 - a.v03 * a.v12
		let b06 = a.v20 * a.v31 - a.v21 * a.v30
		let b07 = a.v20 * a.v32 - a.v22 * a.v30
		let b08 = a.v20 * a.v33 - a.v23 * a.v30
		let b09 = a.v21 * a.v32 - a.v22 * a.v31
		let b10 = a.v21 * a.v33 - a.v23 * a.v31
		let b11 = a.v21 * a.v33 - a.v23 * a.v32

		let i1 = b00 * b11
		let i2 = b01 * b10
		let i3 = b02 * b09
		let i4 = b03 * b08
		let i5 = b04 * b07
		let i6 = b05 * b06

		var det = i1 - i2 + i3 + i4 - i5 + i6

		if det == 0 {
			return false
		}

		det = 1.0 / det

		out.v00 = (a.v11 * b11 - a.v12 * b10 + a.v13 * b09) * det;
	    out.v01 = (a.v02 * b10 - a.v01 * b11 - a.v03 * b09) * det;
	    out.v02 = (a.v31 * b05 - a.v32 * b04 + a.v33 * b03) * det;
	    out.v03 = (a.v22 * b04 - a.v21 * b05 - a.v23 * b03) * det;
	    out.v10 = (a.v12 * b08 - a.v10 * b11 - a.v13 * b07) * det;
	    out.v11 = (a.v00 * b11 - a.v02 * b08 + a.v03 * b07) * det;
	    out.v12 = (a.v32 * b02 - a.v30 * b05 - a.v33 * b01) * det;
	    out.v13 = (a.v20 * b05 - a.v22 * b02 + a.v23 * b01) * det;
	    out.v20 = (a.v10 * b10 - a.v11 * b08 + a.v13 * b06) * det;
	    out.v21 = (a.v01 * b08 - a.v00 * b10 - a.v03 * b06) * det;
	    out.v22 = (a.v30 * b04 - a.v31 * b02 + a.v33 * b00) * det;
	    out.v23 = (a.v21 * b02 - a.v20 * b04 - a.v23 * b00) * det;
	    out.v30 = (a.v11 * b07 - a.v10 * b09 - a.v12 * b06) * det;
	    out.v31 = (a.v00 * b09 - a.v01 * b07 + a.v02 * b06) * det;
	    out.v32 = (a.v31 * b01 - a.v30 * b03 - a.v32 * b00) * det;
	    out.v33 = (a.v20 * b03 - a.v21 * b01 + a.v22 * b00) * det;

		return true
	}

	public static func adjoint(_ out: inout Mat4f) {
		let tmp = out
		out.v00 =  (tmp.v11 * (tmp.v22 * tmp.v33 - tmp.v23 * tmp.v32) - tmp.v21 * (tmp.v12 * tmp.v33 - tmp.v13 * tmp.v32) + tmp.v31 * (tmp.v12 * tmp.v23 - tmp.v13 * tmp.v22))
	    out.v01 = -(tmp.v01 * (tmp.v22 * tmp.v33 - tmp.v23 * tmp.v32) - tmp.v21 * (tmp.v02 * tmp.v33 - tmp.v03 * tmp.v32) + tmp.v31 * (tmp.v02 * tmp.v23 - tmp.v03 * tmp.v22))
	    out.v02 =  (tmp.v01 * (tmp.v12 * tmp.v33 - tmp.v13 * tmp.v32) - tmp.v11 * (tmp.v02 * tmp.v33 - tmp.v03 * tmp.v32) + tmp.v31 * (tmp.v02 * tmp.v13 - tmp.v03 * tmp.v12))
	    out.v03 = -(tmp.v01 * (tmp.v12 * tmp.v23 - tmp.v13 * tmp.v22) - tmp.v11 * (tmp.v02 * tmp.v23 - tmp.v03 * tmp.v22) + tmp.v21 * (tmp.v02 * tmp.v13 - tmp.v03 * tmp.v12))
	    out.v10 = -(tmp.v10 * (tmp.v22 * tmp.v33 - tmp.v23 * tmp.v32) - tmp.v20 * (tmp.v12 * tmp.v33 - tmp.v13 * tmp.v32) + tmp.v30 * (tmp.v12 * tmp.v23 - tmp.v13 * tmp.v22))
	    out.v11 =  (tmp.v00 * (tmp.v22 * tmp.v33 - tmp.v23 * tmp.v32) - tmp.v20 * (tmp.v02 * tmp.v33 - tmp.v03 * tmp.v32) + tmp.v30 * (tmp.v02 * tmp.v23 - tmp.v03 * tmp.v22))
	    out.v12 = -(tmp.v00 * (tmp.v12 * tmp.v33 - tmp.v13 * tmp.v32) - tmp.v10 * (tmp.v02 * tmp.v33 - tmp.v03 * tmp.v32) + tmp.v30 * (tmp.v02 * tmp.v13 - tmp.v03 * tmp.v12))
	    out.v13 =  (tmp.v00 * (tmp.v12 * tmp.v23 - tmp.v13 * tmp.v22) - tmp.v10 * (tmp.v02 * tmp.v23 - tmp.v03 * tmp.v22) + tmp.v20 * (tmp.v02 * tmp.v13 - tmp.v03 * tmp.v12))
	    out.v20 =  (tmp.v10 * (tmp.v21 * tmp.v33 - tmp.v23 * tmp.v31) - tmp.v20 * (tmp.v11 * tmp.v33 - tmp.v13 * tmp.v31) + tmp.v30 * (tmp.v11 * tmp.v23 - tmp.v13 * tmp.v21))
	    out.v21 = -(tmp.v00 * (tmp.v21 * tmp.v33 - tmp.v23 * tmp.v31) - tmp.v20 * (tmp.v01 * tmp.v33 - tmp.v03 * tmp.v31) + tmp.v30 * (tmp.v01 * tmp.v23 - tmp.v03 * tmp.v21))
	    out.v22 =  (tmp.v00 * (tmp.v11 * tmp.v33 - tmp.v13 * tmp.v31) - tmp.v10 * (tmp.v01 * tmp.v33 - tmp.v03 * tmp.v31) + tmp.v30 * (tmp.v01 * tmp.v13 - tmp.v03 * tmp.v11))
	    out.v23 = -(tmp.v00 * (tmp.v11 * tmp.v23 - tmp.v13 * tmp.v21) - tmp.v10 * (tmp.v01 * tmp.v23 - tmp.v03 * tmp.v21) + tmp.v20 * (tmp.v01 * tmp.v13 - tmp.v03 * tmp.v11))
	    out.v30 = -(tmp.v10 * (tmp.v21 * tmp.v32 - tmp.v22 * tmp.v31) - tmp.v20 * (tmp.v11 * tmp.v32 - tmp.v12 * tmp.v31) + tmp.v30 * (tmp.v11 * tmp.v22 - tmp.v12 * tmp.v21))
	    out.v31 =  (tmp.v00 * (tmp.v21 * tmp.v32 - tmp.v22 * tmp.v31) - tmp.v20 * (tmp.v01 * tmp.v32 - tmp.v02 * tmp.v31) + tmp.v30 * (tmp.v01 * tmp.v22 - tmp.v02 * tmp.v21))
	    out.v32 = -(tmp.v00 * (tmp.v11 * tmp.v32 - tmp.v12 * tmp.v31) - tmp.v10 * (tmp.v01 * tmp.v32 - tmp.v02 * tmp.v31) + tmp.v30 * (tmp.v01 * tmp.v12 - tmp.v02 * tmp.v11))
	    out.v33 =  (tmp.v00 * (tmp.v11 * tmp.v22 - tmp.v12 * tmp.v21) - tmp.v10 * (tmp.v01 * tmp.v22 - tmp.v02 * tmp.v21) + tmp.v20 * (tmp.v01 * tmp.v12 - tmp.v02 * tmp.v11))
    }

	public static func adjoint(_ out: inout Mat4f, _ a: inout Mat4f) {
		out.v00 =  (a.v11 * (a.v22 * a.v33 - a.v23 * a.v32) - a.v21 * (a.v12 * a.v33 - a.v13 * a.v32) + a.v31 * (a.v12 * a.v23 - a.v13 * a.v22))
		out.v01 = -(a.v01 * (a.v22 * a.v33 - a.v23 * a.v32) - a.v21 * (a.v02 * a.v33 - a.v03 * a.v32) + a.v31 * (a.v02 * a.v23 - a.v03 * a.v22))
		out.v02 =  (a.v01 * (a.v12 * a.v33 - a.v13 * a.v32) - a.v11 * (a.v02 * a.v33 - a.v03 * a.v32) + a.v31 * (a.v02 * a.v13 - a.v03 * a.v12))
		out.v03 = -(a.v01 * (a.v12 * a.v23 - a.v13 * a.v22) - a.v11 * (a.v02 * a.v23 - a.v03 * a.v22) + a.v21 * (a.v02 * a.v13 - a.v03 * a.v12))
		out.v10 = -(a.v10 * (a.v22 * a.v33 - a.v23 * a.v32) - a.v20 * (a.v12 * a.v33 - a.v13 * a.v32) + a.v30 * (a.v12 * a.v23 - a.v13 * a.v22))
		out.v11 =  (a.v00 * (a.v22 * a.v33 - a.v23 * a.v32) - a.v20 * (a.v02 * a.v33 - a.v03 * a.v32) + a.v30 * (a.v02 * a.v23 - a.v03 * a.v22))
		out.v12 = -(a.v00 * (a.v12 * a.v33 - a.v13 * a.v32) - a.v10 * (a.v02 * a.v33 - a.v03 * a.v32) + a.v30 * (a.v02 * a.v13 - a.v03 * a.v12))
		out.v13 =  (a.v00 * (a.v12 * a.v23 - a.v13 * a.v22) - a.v10 * (a.v02 * a.v23 - a.v03 * a.v22) + a.v20 * (a.v02 * a.v13 - a.v03 * a.v12))
		out.v20 =  (a.v10 * (a.v21 * a.v33 - a.v23 * a.v31) - a.v20 * (a.v11 * a.v33 - a.v13 * a.v31) + a.v30 * (a.v11 * a.v23 - a.v13 * a.v21))
		out.v21 = -(a.v00 * (a.v21 * a.v33 - a.v23 * a.v31) - a.v20 * (a.v01 * a.v33 - a.v03 * a.v31) + a.v30 * (a.v01 * a.v23 - a.v03 * a.v21))
		out.v22 =  (a.v00 * (a.v11 * a.v33 - a.v13 * a.v31) - a.v10 * (a.v01 * a.v33 - a.v03 * a.v31) + a.v30 * (a.v01 * a.v13 - a.v03 * a.v11))
		out.v23 = -(a.v00 * (a.v11 * a.v23 - a.v13 * a.v21) - a.v10 * (a.v01 * a.v23 - a.v03 * a.v21) + a.v20 * (a.v01 * a.v13 - a.v03 * a.v11))
		out.v30 = -(a.v10 * (a.v21 * a.v32 - a.v22 * a.v31) - a.v20 * (a.v11 * a.v32 - a.v12 * a.v31) + a.v30 * (a.v11 * a.v22 - a.v12 * a.v21))
		out.v31 =  (a.v00 * (a.v21 * a.v32 - a.v22 * a.v31) - a.v20 * (a.v01 * a.v32 - a.v02 * a.v31) + a.v30 * (a.v01 * a.v22 - a.v02 * a.v21))
		out.v32 = -(a.v00 * (a.v11 * a.v32 - a.v12 * a.v31) - a.v10 * (a.v01 * a.v32 - a.v02 * a.v31) + a.v30 * (a.v01 * a.v12 - a.v02 * a.v11))
		out.v33 =  (a.v00 * (a.v11 * a.v22 - a.v12 * a.v21) - a.v10 * (a.v01 * a.v22 - a.v02 * a.v21) + a.v20 * (a.v01 * a.v12 - a.v02 * a.v11))
	}

	public static func mul(_ out: inout Mat4f, _ a: inout Mat4f, _ b: inout Mat4f) {
		var b0 = b.v00, b1 = b.v01, b2 = b.v02, b3 = b.v03
		out.v00 = (b0 * a.v00) + (b1 * a.v10) + (b2 * a.v20) + (b3 * a.v30)
		out.v01 = (b0 * a.v01) + (b1 * a.v11) + (b2 * a.v21) + (b3 * a.v31)
		out.v02 = (b0 * a.v02) + (b1 * a.v12) + (b2 * a.v22) + (b3 * a.v32)
		out.v03 = (b0 * a.v03) + (b1 * a.v13) + (b2 * a.v23) + (b3 * a.v33)

		b0 = b.v10; b1 = b.v11; b2 = b.v12; b3 = b.v13
		out.v10 = (b0 * a.v00) + (b1 * a.v10) + (b2 * a.v20) + (b3 * a.v30)
		out.v11 = (b0 * a.v01) + (b1 * a.v11) + (b2 * a.v21) + (b3 * a.v31)
		out.v12 = (b0 * a.v02) + (b1 * a.v12) + (b2 * a.v22) + (b3 * a.v32)
		out.v13 = (b0 * a.v03) + (b1 * a.v13) + (b2 * a.v23) + (b3 * a.v33)

		b0 = b.v20; b1 = b.v21; b2 = b.v22; b3 = b.v23
		out.v20 = (b0 * a.v00) + (b1 * a.v10) + (b2 * a.v20) + (b3 * a.v30)
		out.v21 = (b0 * a.v01) + (b1 * a.v11) + (b2 * a.v21) + (b3 * a.v31)
		out.v22 = (b0 * a.v02) + (b1 * a.v12) + (b2 * a.v22) + (b3 * a.v32)
		out.v23 = (b0 * a.v03) + (b1 * a.v13) + (b2 * a.v23) + (b3 * a.v33)

		b0 = b.v30; b1 = b.v31; b2 = b.v32; b3 = b.v33
		out.v30 = (b0 * a.v00) + (b1 * a.v10) + (b2 * a.v20) + (b3 * a.v30)
		out.v31 = (b0 * a.v01) + (b1 * a.v11) + (b2 * a.v21) + (b3 * a.v31)
		out.v32 = (b0 * a.v02) + (b1 * a.v12) + (b2 * a.v22) + (b3 * a.v32)
		out.v33 = (b0 * a.v03) + (b1 * a.v13) + (b2 * a.v23) + (b3 * a.v33)
	}

	public static func translate(_ out: inout Mat4f, _ v: inout Vec3f) {
		let v30 = out.v00 * v.x + out.v10 * v.y + out.v20 * v.z + out.v30
        let v31 = out.v01 * v.x + out.v11 * v.y + out.v21 * v.z + out.v31
        let v32 = out.v02 * v.x + out.v12 * v.y + out.v22 * v.z + out.v32
        let v33 = out.v03 * v.x + out.v13 * v.y + out.v23 * v.z + out.v33

        out.v30 = v30
        out.v31 = v31
        out.v32 = v32
        out.v33 = v33
	}

	public static func translate(_ out: inout Mat4f, _ a: inout Mat4f, _ v: inout Vec3f) {
		out.v00 = a.v00; out.v01 = a.v01; out.v02 = a.v02; out.v03 = a.v03
		out.v10 = a.v10; out.v11 = a.v11; out.v12 = a.v12; out.v13 = a.v13
		out.v20 = a.v20; out.v21 = a.v21; out.v22 = a.v22; out.v23 = a.v23

		out.v30 = a.v00 * v.x + a.v10 * v.y + a.v20 * v.z + out.v30
		out.v31 = a.v01 * v.x + a.v11 * v.y + a.v21 * v.z + out.v31
		out.v32 = a.v02 * v.x + a.v12 * v.y + a.v22 * v.z + out.v32
		out.v33 = a.v03 * v.x + a.v13 * v.y + a.v23 * v.z + out.v33
	}

	public static func rotate(_ out: inout Mat4f, angle: Float, axis: inout Vec3f) -> Bool {
		var len = sqrtf(axis.x*axis.x + axis.y*axis.y + axis.z*axis.z)

		// TODO: epsilon check on len

		len = 1 / len
		let x = axis.x * len
		let y = axis.y * len
		let z = axis.z * len

		let s = sinf(angle)
		let c = cosf(angle)
		let t = 1 - c

		let a00 = out.v00, a01 = out.v01, a02 = out.v02, a03 = out.v03,
			a10 = out.v10, a11 = out.v11, a12 = out.v12, a13 = out.v13,
			a20 = out.v20, a21 = out.v21, a22 = out.v22, a23 = out.v23

		let b00 = x * x * t + c, b01 = y * x * t + z * s, b02 = z * x * t - y * s,
	    	b10 = x * y * t - z * s, b11 = y * y * t + c, b12 = z * y * t + x * s,
	    	b20 = x * z * t + y * s, b21 = y * z * t - x * s, b22 = z * z * t + c

	    out.v00 = a00 * b00 + a10 * b01 + a20 * b02;
	    out.v01	= a01 * b00 + a11 * b01 + a21 * b02;
	    out.v02	= a02 * b00 + a12 * b01 + a22 * b02;
	    out.v03	= a03 * b00 + a13 * b01 + a23 * b02;
	    out.v10	= a00 * b10 + a10 * b11 + a20 * b12;
	    out.v11	= a01 * b10 + a11 * b11 + a21 * b12;
	    out.v12	= a02 * b10 + a12 * b11 + a22 * b12;
	    out.v13	= a03 * b10 + a13 * b11 + a23 * b12;
	    out.v20	= a00 * b20 + a10 * b21 + a20 * b22;
	    out.v21	= a01 * b20 + a11 * b21 + a21 * b22;
	    out.v22 = a02 * b20 + a12 * b21 + a22 * b22;
	    out.v23 = a03 * b20 + a13 * b21 + a23 * b22;

	    return true
	}

	public static func rotate(_ out: inout Mat4f, _ a: inout Mat4f, angle: Float, axis: inout Vec3f) -> Bool {
		var len = sqrtf(axis.x*axis.x + axis.y*axis.y + axis.z*axis.z)

		// TODO: epsilon check on len

		len = 1 / len
		let x = axis.x * len
		let y = axis.y * len
		let z = axis.z * len

		let s = sinf(angle)
		let c = cosf(angle)
		let t = 1 - c

		let b00 = x * x * t + c, b01 = y * x * t + z * s, b02 = z * x * t - y * s,
	    	b10 = x * y * t - z * s, b11 = y * y * t + c, b12 = z * y * t + x * s,
	    	b20 = x * z * t + y * s, b21 = y * z * t - x * s, b22 = z * z * t + c

	    out.v00 = a.v00 * b00 + a.v10 * b01 + a.v20 * b02
	    out.v01 = a.v01 * b00 + a.v11 * b01 + a.v21 * b02
	    out.v02 = a.v02 * b00 + a.v12 * b01 + a.v22 * b02
	    out.v03 = a.v03 * b00 + a.v13 * b01 + a.v23 * b02
	    out.v10 = a.v00 * b10 + a.v10 * b11 + a.v20 * b12
	    out.v11 = a.v01 * b10 + a.v11 * b11 + a.v21 * b12
	    out.v12 = a.v02 * b10 + a.v12 * b11 + a.v22 * b12
	    out.v13 = a.v03 * b10 + a.v13 * b11 + a.v23 * b12
	    out.v20 = a.v00 * b20 + a.v10 * b21 + a.v20 * b22
	    out.v21 = a.v01 * b20 + a.v11 * b21 + a.v21 * b22
	    out.v22 = a.v02 * b20 + a.v12 * b21 + a.v22 * b22
	    out.v23 = a.v03 * b20 + a.v13 * b21 + a.v23 * b22

	    out.v30 = a.v30
	    out.v31 = a.v31
	    out.v32 = a.v32
	    out.v33 = a.v33

	    return true
	}

	public static func rotateX(_ out: inout Mat4f, angle: Float) {
		let s = sinf(angle), c = cosf(angle)
		let a10 = out.v10, a11 = out.v11, a12 = out.v12, a13 = out.v13,
			a20 = out.v20, a21 = out.v21, a22 = out.v22, a23 = out.v23

		out.v10 = a10 * c + a20 * s;
	    out.v11 = a11 * c + a21 * s;
	    out.v12 = a12 * c + a22 * s;
	    out.v13 = a13 * c + a23 * s;
	    out.v20 = a20 * c - a10 * s;
	    out.v21 = a21 * c - a11 * s;
	    out.v22 = a22 * c - a12 * s;
	    out.v23 = a23 * c - a13 * s;		
	}

	public static func rotateX(_ out: inout Mat4f, _ a: inout Mat4f, angle: Float) {
		let s = sinf(angle), c = cosf(angle)
		
		out.v00 = a.v00
		out.v01 = a.v01
		out.v02 = a.v02
		out.v02 = a.v03
		out.v30 = a.v30
		out.v31 = a.v31
		out.v32 = a.v32
		out.v32 = a.v33

	    out.v10 = a.v10 * c + a.v20 * s;
	    out.v11 = a.v11 * c + a.v21 * s;
	    out.v12 = a.v12 * c + a.v22 * s;
	    out.v13 = a.v13 * c + a.v23 * s;
	    out.v20 = a.v20 * c - a.v10 * s;
	    out.v21 = a.v21 * c - a.v11 * s;
	    out.v22 = a.v22 * c - a.v12 * s;
	    out.v23 = a.v23 * c - a.v13 * s;
	}

	public static func rotateY(_ out: inout Mat4f, angle: Float) {
		let s = sinf(angle), c = cosf(angle)
		let a00 = out.v00, a01 = out.v01, a02 = out.v02, a03 = out.v03,
			a20 = out.v20, a21 = out.v21, a22 = out.v22, a23 = out.v23

	    out.v00 = a00 * c - a20 * s;
	    out.v01 = a01 * c - a21 * s;
	    out.v02 = a02 * c - a22 * s;
	    out.v03 = a03 * c - a23 * s;
	    out.v20 = a00 * s + a20 * c;
	    out.v21 = a01 * s + a21 * c;
	    out.v22 = a02 * s + a22 * c;
	    out.v23 = a03 * s + a23 * c;		
	}

	public static func rotateY(_ out: inout Mat4f, _ a: inout Mat4f, angle: Float) {
		let s = sinf(angle), c = cosf(angle)
		
		out.v10 = a.v10
		out.v11 = a.v11
		out.v12 = a.v12
		out.v12 = a.v13
		out.v30 = a.v30
		out.v31 = a.v31
		out.v32 = a.v32
		out.v32 = a.v33

	    out.v00 = a.v00 * c - a.v20 * s;
	    out.v01 = a.v01 * c - a.v21 * s;
	    out.v02 = a.v02 * c - a.v22 * s;
	    out.v03 = a.v03 * c - a.v23 * s;
	    out.v20 = a.v00 * s + a.v20 * c;
	    out.v21 = a.v01 * s + a.v21 * c;
	    out.v22 = a.v02 * s + a.v22 * c;
	    out.v23 = a.v03 * s + a.v23 * c;
	}

	public static func rotateZ(_ out: inout Mat4f, angle: Float) {
		let s = sinf(angle), c = cosf(angle)
		let a00 = out.v00, a01 = out.v01, a02 = out.v02, a03 = out.v03,
			a10 = out.v10, a11 = out.v11, a12 = out.v12, a13 = out.v13

		out.v00 = a00 * c + a10 * s;
	    out.v01 = a01 * c + a11 * s;
	    out.v02 = a02 * c + a12 * s;
	    out.v03 = a03 * c + a13 * s;
	    out.v10 = a10 * c - a00 * s;
	    out.v11 = a11 * c - a01 * s;
	    out.v12 = a12 * c - a02 * s;
	    out.v13 = a13 * c - a03 * s;		
	}

	public static func rotateZ(_ out: inout Mat4f, _ a: inout Mat4f, angle: Float) {
		let s = sinf(angle), c = cosf(angle)
		
		out.v20 = a.v20
		out.v21 = a.v21
		out.v22 = a.v22
		out.v32 = a.v23
		out.v30 = a.v30
		out.v31 = a.v31
		out.v32 = a.v32
		out.v32 = a.v33

		out.v00 = a.v00 * c + a.v10 * s;
	    out.v01 = a.v01 * c + a.v11 * s;
	    out.v02 = a.v02 * c + a.v12 * s;
	    out.v03 = a.v03 * c + a.v13 * s;
	    out.v10 = a.v10 * c - a.v00 * s;
	    out.v11 = a.v11 * c - a.v01 * s;
	    out.v12 = a.v12 * c - a.v02 * s;
	    out.v13 = a.v13 * c - a.v03 * s;
	}

	public static func scale(_ out: inout Mat4f, _ v: inout Vec3f) {
		out.v00 = out.v00 * v.x
		out.v01 = out.v01 * v.x
		out.v02 = out.v02 * v.x
		out.v03 = out.v03 * v.x
		out.v10 = out.v10 * v.y
		out.v11 = out.v11 * v.y
		out.v12 = out.v12 * v.y
		out.v13 = out.v13 * v.y
		out.v20 = out.v20 * v.z
		out.v21 = out.v21 * v.z
		out.v22 = out.v22 * v.z
		out.v23 = out.v23 * v.z
	}

	public static func scale(_ out: inout Mat4f, _ a: inout Mat4f, _ v: inout Vec3f) {
		out.v00 = a.v00 * v.x
		out.v01 = a.v01 * v.x
		out.v02 = a.v02 * v.x
		out.v03 = a.v03 * v.x
		out.v10 = a.v10 * v.y
		out.v11 = a.v11 * v.y
		out.v12 = a.v12 * v.y
		out.v13 = a.v13 * v.y
		out.v20 = a.v20 * v.z
		out.v21 = a.v21 * v.z
		out.v22 = a.v22 * v.z
		out.v23 = a.v23 * v.z
		out.v30 = a.v30
		out.v31 = a.v31
		out.v32 = a.v32
		out.v33 = a.v33
	}

	public static func fromTranslation(_ out: inout Mat4f, _ v: inout Vec3f) {
		out.v00 = 1;
		out.v01 = 0;
		out.v02 = 0;
		out.v03 = 0;
	    out.v10 = 0;
	    out.v11 = 1;
	    out.v12 = 0;
	    out.v13 = 0;
	    out.v20 = 0;
	    out.v21 = 0;
	    out.v22 = 1;
	    out.v23 = 0;
	    out.v30 = v.x;
	    out.v31 = v.y;
	    out.v32 = v.z;
	    out.v33 = 1;
	}

	public static func fromScaling(_ out: inout Mat4f, _ v: inout Vec3f) {
		out.v00 = v.x;
	    out.v01 = 0;
	    out.v02 = 0;
	    out.v03 = 0;
	    out.v10 = 0;
	    out.v11 = v.y;
	    out.v12 = 0;
	    out.v13 = 0;
	    out.v20 = 0;
	    out.v21 = 0;
	    out.v22 = v.z;
	    out.v23 = 0;
	    out.v30 = 0;
	    out.v31 = 0;
	    out.v32 = 0;
	    out.v33 = 1;
	}

	public static func fromRotation(_ out: inout Mat4f, angle: Float, axis: inout Vec3f) {
		var len = sqrtf(axis.x*axis.x + axis.y*axis.y + axis.z*axis.z)

		// TODO: epsilon check on len

		len = 1 / len
		let x = axis.x * len
		let y = axis.y * len
		let z = axis.z * len

		let s = sinf(angle)
		let c = cosf(angle)
		let t = 1 - c

		out.v00 = x * x * t + c;
	    out.v01 = y * x * t + z * s;
	    out.v02 = z * x * t - y * s;
	    out.v03 = 0;
	    out.v10 = x * y * t - z * s;
	    out.v11 = y * y * t + c;
	    out.v12 = z * y * t + x * s;
	    out.v13 = 0;
	    out.v20 = x * z * t + y * s;
	    out.v21 = y * z * t - x * s;
	    out.v22 = z * z * t + c;
	    out.v23 = 0;
	    out.v30 = 0;
	    out.v31 = 0;
	    out.v32 = 0;
	    out.v33 = 1;
	}

	public static func fromXRotation(_ out: inout Mat4f, angle: Float) {
		let s = sinf(angle), c = cosf(angle)
		out.v00 = 1;
		out.v01 = 0;
		out.v02 = 0;
		out.v03 = 0;
		out.v10 = 0;
		out.v11 = c;
		out.v12 = s;
		out.v13 = 0;
		out.v20 = 0;
		out.v21 = -s;
		out.v22 = c;
		out.v23 = 0;
		out.v30 = 0;
		out.v31 = 0;
		out.v32 = 0;
		out.v33 = 1;
	}

	public static func fromYRotation(_ out: inout Mat4f, angle: Float) {
		let s = sinf(angle), c = cosf(angle)
		out.v00 = c;
	    out.v01 = 0;
	    out.v02 = -s;
	    out.v03 = 0;
	    out.v10 = 0;
	    out.v11 = 1;
	    out.v12 = 0;
	    out.v13 = 0;
	    out.v20 = s;
	    out.v21 = 0;
	    out.v22 = c;
	    out.v23 = 0;
	    out.v30 = 0;
	    out.v31 = 0;
	    out.v32 = 0;
	    out.v33 = 1;
	}

	public static func fromZRotation(_ out: inout Mat4f, angle: Float) {
		let s = sinf(angle), c = cosf(angle)
		out.v00 = c;
	    out.v01 = s;
	    out.v02 = 0;
	    out.v03 = 0;
	    out.v10 = -s;
	    out.v11 = c;
	    out.v12 = 0;
	    out.v13 = 0;
	    out.v20 = 0;
	    out.v21 = 0;
	    out.v22 = 1;
	    out.v23 = 0;
	    out.v30 = 0;
	    out.v31 = 0;
	    out.v32 = 0;
	    out.v33 = 1;
	}

	public static func frustum(_ out: inout Mat4f, left: Float, right: Float, bottom: Float, top: Float, near: Float, far: Float) {
		let rl = 1 / (right - left)
		let tb = 1 / (top - bottom)
		let nf = 1 / (near - far)
		out.v00 = (near * 2) * rl;
	    out.v01 = 0;
	    out.v02 = 0;
	    out.v03 = 0;
	    out.v10 = 0;
	    out.v11 = (near * 2) * tb;
	    out.v12 = 0;
	    out.v13 = 0;
	    out.v20 = (right + left) * rl;
	    out.v21 = (top + bottom) * tb;
	    out.v22 = (far + near) * nf;
	    out.v23 = -1;
	    out.v30 = 0;
	    out.v31 = 0;
	    out.v32 = (far * near * 2) * nf;
	    out.v33 = 0;
	}

	public static func perspective(_ out: inout Mat4f, fovy: Float, aspect: Float, near: Float, far: Float) {
		let f = 1.0 / tanf(fovy / 2.0)
		let nf = 1 / (near - far)
		out.v00 = f / aspect;
	    out.v01 = 0;
	    out.v02 = 0;
	    out.v03 = 0;
	    out.v10 = 0;
	    out.v11 = f;
	    out.v12 = 0;
	    out.v13 = 0;
	    out.v20 = 0;
	    out.v21 = 0;
	    out.v22 = (far + near) * nf;
	    out.v23 = -1;
	    out.v30 = 0;
	    out.v31 = 0;
	    out.v32 = (2 * far * near) * nf;
	    out.v33 = 0;
	}

	// TODO: perspectiveFromFieldOfView

	public static func ortho(_ out: inout Mat4f, left: Float, right: Float, bottom: Float, top: Float, near: Float, far: Float) {
		let lr = 1.0 / (left - right)
        let bt = 1.0 / (bottom - top)
        let nf = 1.0 / (near - far)
        out.v00 = -2 * lr;
	    out.v01 = 0;
	    out.v02 = 0;
	    out.v03 = 0;
	    out.v10 = 0;
	    out.v11 = -2 * bt;
	    out.v12 = 0;
	    out.v13 = 0;
	    out.v20 = 0;
	    out.v21 = 0;
	    out.v22 = 2 * nf;
	    out.v23 = 0;
	    out.v30 = (left + right) * lr;
	    out.v31 = (top + bottom) * bt;
	    out.v32 = (far + near) * nf;
	    out.v33 = 1;
	}

	public static func lookAt(_ out: inout Mat4f, eye: inout Vec3f, center: inout Vec3f, up: inout Vec3f) {
		var x0, x1, x2, y0, y1, y2, z0, z1, z2, len : Float

		// TODO: bring in some epsilon stuff
		// if (Math.abs(eyex - centerx) < glMatrix.EPSILON &&
		//     Math.abs(eyey - centery) < glMatrix.EPSILON &&
		//     Math.abs(eyez - centerz) < glMatrix.EPSILON) {
		//     return mat4.identity(out);
		// }

		z0 = eye.x - center.x;
		z1 = eye.y - center.y;
		z2 = eye.z - center.z;

		len = 1.0 / sqrtf(z0 * z0 + z1 * z1 + z2 * z2);
		z0 *= len;
		z1 *= len;
		z2 *= len;

		x0 = up.y * z2 - up.z * z1;
		x1 = up.z * z0 - up.x * z2;
		x2 = up.x * z1 - up.y * z0;
		len = sqrtf(x0 * x0 + x1 * x1 + x2 * x2);
		if (len == 0 || len.isNaN) {
		    x0 = 0;
		    x1 = 0;
		    x2 = 0;
		} else {
		    len = 1 / len;
		    x0 *= len;
		    x1 *= len;
		    x2 *= len;
		}

		y0 = z1 * x2 - z2 * x1;
		y1 = z2 * x0 - z0 * x2;
		y2 = z0 * x1 - z1 * x0;

		len = sqrtf(y0 * y0 + y1 * y1 + y2 * y2);
		if (len == 0 || len.isNaN) {
		    y0 = 0;
		    y1 = 0;
		    y2 = 0;
		} else {
		    len = 1 / len;
		    y0 *= len;
		    y1 *= len;
		    y2 *= len;
		}

		out.v00 = x0;
		out.v01 = y0;
		out.v02 = z0;
		out.v03 = 0;
		out.v10 = x1;
		out.v11 = y1;
		out.v12 = z1;
		out.v13 = 0;
		out.v20 = x2;
		out.v21 = y2;
		out.v22 = z2;
		out.v23 = 0;
		out.v30 = -(x0 * eye.x + x1 * eye.y + x2 * eye.z);
		out.v31 = -(y0 * eye.x + y1 * eye.y + y2 * eye.z);
		out.v32 = -(z0 * eye.x + z1 * eye.y + z2 * eye.z);
		out.v33 = 1;
	}

	public static func add(_ out: inout Mat4f, _ a: inout Mat4f, _ b: inout Mat4f) {
		out.v00 = a.v00 + b.v00
		out.v01 = a.v01 + b.v01
		out.v02 = a.v02 + b.v02
		out.v03 = a.v03 + b.v03
		out.v10 = a.v10 + b.v10
		out.v11 = a.v11 + b.v11
		out.v12 = a.v12 + b.v12
		out.v13 = a.v13 + b.v13
		out.v20 = a.v20 + b.v20
		out.v21 = a.v21 + b.v21
		out.v22 = a.v22 + b.v22
		out.v23 = a.v23 + b.v23
		out.v30 = a.v30 + b.v30
		out.v31 = a.v31 + b.v31
		out.v32 = a.v32 + b.v32
		out.v33 = a.v33 + b.v33
	}

	public static func sub(_ out: inout Mat4f, _ a: inout Mat4f, _ b: inout Mat4f) {
		out.v00 = a.v00 - b.v00
		out.v01 = a.v01 - b.v01
		out.v02 = a.v02 - b.v02
		out.v03 = a.v03 - b.v03
		out.v10 = a.v10 - b.v10
		out.v11 = a.v11 - b.v11
		out.v12 = a.v12 - b.v12
		out.v13 = a.v13 - b.v13
		out.v20 = a.v20 - b.v20
		out.v21 = a.v21 - b.v21
		out.v22 = a.v22 - b.v22
		out.v23 = a.v23 - b.v23
		out.v30 = a.v30 - b.v30
		out.v31 = a.v31 - b.v31
		out.v32 = a.v32 - b.v32
		out.v33 = a.v33 - b.v33
	}

	public static func mul(_ out: inout Mat4f, _ a: inout Mat4f, _ b: Float) {
		out.v00 = a.v00 * b
		out.v01 = a.v01 * b
		out.v02 = a.v02 * b
		out.v03 = a.v03 * b
		out.v10 = a.v10 * b
		out.v11 = a.v11 * b
		out.v12 = a.v12 * b
		out.v13 = a.v13 * b
		out.v20 = a.v20 * b
		out.v21 = a.v21 * b
		out.v22 = a.v22 * b
		out.v23 = a.v23 * b
		out.v30 = a.v30 * b
		out.v31 = a.v31 * b
		out.v32 = a.v32 * b
		out.v33 = a.v33 * b
	}

	public static func mac(_ out: inout Mat4f, _ a: inout Mat4f, _ scale: Float) {
		out.v00 = out.v00 + (a.v00 * scale)
		out.v01 = out.v01 + (a.v01 * scale)
		out.v02 = out.v02 + (a.v02 * scale)
		out.v03 = out.v03 + (a.v03 * scale)
		out.v10 = out.v10 + (a.v10 * scale)
		out.v11 = out.v11 + (a.v11 * scale)
		out.v12 = out.v12 + (a.v12 * scale)
		out.v13 = out.v13 + (a.v13 * scale)
		out.v20 = out.v20 + (a.v20 * scale)
		out.v21 = out.v21 + (a.v21 * scale)
		out.v22 = out.v22 + (a.v22 * scale)
		out.v23 = out.v23 + (a.v23 * scale)
		out.v30 = out.v30 + (a.v30 * scale)
		out.v31 = out.v31 + (a.v31 * scale)
		out.v32 = out.v32 + (a.v32 * scale)
		out.v33 = out.v33 + (a.v33 * scale)
	}

	public static func mac(_ out: inout Mat4f, _ a: inout Mat4f, _ b: inout Mat4f, _ scale: Float) {
		out.v00 = a.v00 + (b.v00 * scale)
		out.v01 = a.v01 + (b.v01 * scale)
		out.v02 = a.v02 + (b.v02 * scale)
		out.v03 = a.v03 + (b.v03 * scale)
		out.v10 = a.v10 + (b.v10 * scale)
		out.v11 = a.v11 + (b.v11 * scale)
		out.v12 = a.v12 + (b.v12 * scale)
		out.v13 = a.v13 + (b.v13 * scale)
		out.v20 = a.v20 + (b.v20 * scale)
		out.v21 = a.v21 + (b.v21 * scale)
		out.v22 = a.v22 + (b.v22 * scale)
		out.v23 = a.v23 + (b.v23 * scale)
		out.v30 = a.v30 + (b.v30 * scale)
		out.v31 = a.v31 + (b.v31 * scale)
		out.v32 = a.v32 + (b.v32 * scale)
		out.v33 = a.v33 + (b.v33 * scale)
	}

	public static func exactEquals(_ a: inout Mat4f, _ b: inout Mat4f) -> Bool {
		return a.v00 == b.v00
			&& a.v01 == b.v01
			&& a.v02 == b.v02
			&& a.v03 == b.v03
			&& a.v10 == b.v10
			&& a.v11 == b.v11
			&& a.v12 == b.v12
			&& a.v13 == b.v13
			&& a.v20 == b.v20
			&& a.v21 == b.v21
			&& a.v22 == b.v22
			&& a.v23 == b.v23
			&& a.v30 == b.v30
			&& a.v31 == b.v31
			&& a.v32 == b.v32
			&& a.v33 == b.v33
	}

	public static func equals(_ a: inout Mat4f, _ b: inout Mat4f, epsilon: Float) -> Bool {
		return abs(a.v00 - b.v00) <= (epsilon * max3(1.0, abs(a.v00), abs(b.v00)))
			&& abs(a.v01 - b.v01) <= (epsilon * max3(1.0, abs(a.v01), abs(b.v01)))
			&& abs(a.v02 - b.v02) <= (epsilon * max3(1.0, abs(a.v02), abs(b.v02)))
			&& abs(a.v03 - b.v03) <= (epsilon * max3(1.0, abs(a.v03), abs(b.v03)))
			&& abs(a.v10 - b.v10) <= (epsilon * max3(1.0, abs(a.v10), abs(b.v10)))
			&& abs(a.v11 - b.v11) <= (epsilon * max3(1.0, abs(a.v11), abs(b.v11)))
			&& abs(a.v12 - b.v12) <= (epsilon * max3(1.0, abs(a.v12), abs(b.v12)))
			&& abs(a.v13 - b.v13) <= (epsilon * max3(1.0, abs(a.v13), abs(b.v13)))
			&& abs(a.v20 - b.v20) <= (epsilon * max3(1.0, abs(a.v20), abs(b.v20)))
			&& abs(a.v21 - b.v21) <= (epsilon * max3(1.0, abs(a.v21), abs(b.v21)))
			&& abs(a.v22 - b.v22) <= (epsilon * max3(1.0, abs(a.v22), abs(b.v22)))
			&& abs(a.v23 - b.v23) <= (epsilon * max3(1.0, abs(a.v23), abs(b.v23)))
			&& abs(a.v30 - b.v30) <= (epsilon * max3(1.0, abs(a.v30), abs(b.v30)))
			&& abs(a.v31 - b.v31) <= (epsilon * max3(1.0, abs(a.v31), abs(b.v31)))
			&& abs(a.v32 - b.v32) <= (epsilon * max3(1.0, abs(a.v32), abs(b.v32)))
			&& abs(a.v33 - b.v33) <= (epsilon * max3(1.0, abs(a.v33), abs(b.v33)))
	}

	private static func max3(_ a: Float, _ b: Float, _ c: Float) -> Float {
		return (a > b) ? (a > c ? a : c) : (b > c ? b : c)
	}

	//
	//

	public init() {
		v00 = 1.0; v01 = 0.0; v02 = 0.0; v03 = 0.0;
		v10 = 0.0; v11 = 1.0; v12 = 0.0; v13 = 0.0;
		v20 = 0.0; v21 = 0.0; v22 = 1.0; v23 = 0.0;
		v30 = 0.0; v31 = 0.0; v32 = 0.0; v33 = 1.0;
	}

	public func determinant() -> Float {
		let b00 = v00 * v11 - v01 * v10,
			b01 = v00 * v12 - v02 * v10,
			b02 = v00 * v13 - v03 * v10,
			b03 = v01 * v12 - v02 * v11,
			b04 = v01 * v13 - v03 * v11,
			b05 = v02 * v13 - v03 * v12,
			b06 = v20 * v31 - v21 * v30,
			b07 = v20 * v32 - v22 * v30,
			b08 = v20 * v33 - v23 * v30,
			b09 = v21 * v32 - v22 * v31,
			b10 = v21 * v33 - v23 * v31,
			b11 = v21 * v33 - v23 * v32

		let i1 = b00 * b11,
			i2 = b01 * b10,
			i3 = b02 * b09,
			i4 = b03 * b08,
			i5 = b04 * b07,
			i6 = b05 * b06

		return i1 - i2 + i3 + i4 - i5 + i6;
	}
}