import Bit_Index_Primitives
import Bit_Index_Primitives_Test_Support
import Ordinal_Primitives
import Testing

@Suite
struct `Bit.Index Tests` {
    @Suite struct Unit {}
    @Suite struct `Edge Case` {}
    @Suite struct Integration {}
    @Suite(.serialized) struct Performance {}
}

extension `Bit.Index Tests`.Unit {
    @Suite struct Typealias {}
    @Suite struct Ratio {}
    @Suite struct `Byte Conversion` {}
}

extension `Bit.Index Tests`.Unit.Typealias {
    @Test
    func `Bit.Index is Index<Bit>`() {
        let index: Bit.Index = 5
        #expect(index == 5)
    }

    @Test
    func `Bit.Index.Count wraps Cardinal`() {
        let count: Bit.Index.Count = 42
        #expect(count == 42)
    }

    @Test
    func `Bit.Index.Offset wraps Vector`() {
        let offset: Bit.Index.Offset = 7
        #expect(offset == 7)
    }
}

extension `Bit.Index Tests`.Unit.Ratio {
    @Test
    func `bitsPerByte is 8`() {
        let ratio: Affine.Discrete.Ratio<Byte, Bit> = .bitsPerByte
        #expect(ratio.factor == 8)
    }

    @Test
    func `bitsPerWord is UInt.bitWidth`() {
        let ratio: Affine.Discrete.Ratio<UInt, Bit> = .bitsPerWord
        #expect(ratio.factor == UInt.bitWidth)
    }

    @Test
    func `bitWidth for UInt32 is 32`() {
        let ratio: Affine.Discrete.Ratio<UInt32, Bit> = .bitWidth
        #expect(ratio.factor == 32)
    }

    @Test
    func `bitWidth for UInt64 is 64`() {
        let ratio: Affine.Discrete.Ratio<UInt64, Bit> = .bitWidth
        #expect(ratio.factor == 64)
    }
}

extension `Bit.Index Tests`.Unit.`Byte Conversion` {
    @Test
    func `byte 0 maps to bit 0`() {
        let byteIndex: Index<Byte> = 0
        let bitIndex = Bit.Index(byteIndex)
        #expect(bitIndex == 0)
    }

    @Test
    func `byte 1 maps to bit 8`() {
        let byteIndex: Index<Byte> = 1
        let bitIndex = Bit.Index(byteIndex)
        #expect(bitIndex == 8)
    }

    @Test
    func `byte 3 maps to bit 24`() {
        let byteIndex: Index<Byte> = 3
        let bitIndex = Bit.Index(byteIndex)
        #expect(bitIndex == 24)
    }

    @Test
    func `byte 2 with bit offset 5 maps to bit 21`() throws(Ordinal.Error) {
        let byteIndex: Index<Byte> = 2
        let offset: Index<Bit>.Offset = 5
        let bitIndex: Bit.Index = try .init(byteIndex, offset: offset)
        #expect(bitIndex == 21)
    }

    @Test
    func `byte 0 with bit offset 0 maps to bit 0`() throws(Ordinal.Error) {
        #expect(try Bit.Index(0, offset: 0) == 0)
    }
}
