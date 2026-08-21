public import Affine_Primitives
public import Byte_Primitives
public import Index_Primitives
import Ordinal_Primitives

extension Bit.Index {

    @inlinable
    public init(
        _ index: Index_Primitives.Index<Byte>
    ) {
        self = .zero + Index_Primitives.Index<Byte>.Count(index) * .bitsPerByte
    }

    @inlinable
    public init(
        _ byteIndex: Index_Primitives.Index<Byte>,
        offset: Index_Primitives.Index<Bit>.Offset
    ) throws(Ordinal.Error) {
        self = try (.zero + Index_Primitives.Index<Byte>.Count(byteIndex) * .bitsPerByte) + offset
    }
}
