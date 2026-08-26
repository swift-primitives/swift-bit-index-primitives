public import Affine
public import Byte
public import Index
import Ordinal

extension Bit.Index {

    @inlinable
    public init(
        _ index: Index.Index<Byte>
    ) {
        self = .zero + Index.Index<Byte>.Count(index) * .bitsPerByte
    }

    @inlinable
    public init(
        _ byteIndex: Index.Index<Byte>,
        offset: Index.Index<Bit>.Offset
    ) throws(Ordinal.Error) {
        self = try (.zero + Index.Index<Byte>.Count(byteIndex) * .bitsPerByte) + offset
    }
}
