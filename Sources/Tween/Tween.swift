import Math

/// Struct that stores two colors (used for LineRenderer tweens)
public struct Color2 {
    public var ca: Color, cb: Color

    public init(ca: Color, cb: Color) {
        self.ca = ca;
        self.cb = cb;
    }

    public static func +(c1: Color2, c2: Color2) -> Color2 {
        Color2(ca: c1.ca + c2.ca, cb: c1.cb + c2.cb);
    }

    public static func -(c1: Color2, c2: Color2) -> Color2 {
        Color2(ca: c1.ca - c2.ca, cb: c1.cb - c2.cb);
    }

    public static func *(c1: Color2, f: Float) -> Color2 {
        Color2(ca: c1.ca * f, cb: c1.cb * f);
    }
}
