public import Affine_Primitives
public import Byte_Primitives

extension Affine.Discrete.Ratio where To == Bit, From: FixedWidthInteger {

    @inlinable
    public static var bitWidth: Self { .init(From.bitWidth) }
}

extension Affine.Discrete.Ratio where From == Byte, To == Bit {

    @inlinable
    public static var bitsPerByte: Self { .init(8) }
}

extension Affine.Discrete.Ratio where From == UInt, To == Bit {

    @inlinable
    public static var bitsPerWord: Self { .bitWidth }
}
