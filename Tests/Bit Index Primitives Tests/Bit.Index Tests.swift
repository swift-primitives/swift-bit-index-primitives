// ===----------------------------------------------------------------------===//
//
// This source file is part of the swift-primitives open source project
//
// Copyright (c) 2024-2026 Coen ten Thije Boonkkamp and the swift-primitives project authors
// Licensed under Apache License v2.0
//
// See LICENSE for license information
//
// ===----------------------------------------------------------------------===//

import Testing
import Bit_Index_Primitives
import Bit_Index_Primitives_Test_Support

// MARK: - Bit.Index Typealias

@Suite("Bit.Index")
struct BitIndexTests {

    @Test("Bit.Index is Index<Bit>")
    func typealiasIdentity() {
        let index: Bit.Index = 5
        #expect(index == 5)
    }

    @Test("Bit.Index.Count wraps Cardinal")
    func countType() {
        let count: Bit.Index.Count = 42
        #expect(count == 42)
    }

    @Test("Bit.Index.Offset wraps Vector")
    func offsetType() {
        let offset: Bit.Index.Offset = 7
        #expect(offset == 7)
    }
}

// MARK: - Affine Ratios

@Suite("Affine.Discrete.Ratio")
struct BitRatioTests {

    @Test("bitsPerByte is 8")
    func bitsPerByte() {
        let ratio: Affine.Discrete.Ratio<UInt8, Bit> = .bitsPerByte
        #expect(ratio.factor == 8)
    }

    @Test("bitsPerWord is UInt.bitWidth")
    func bitsPerWord() {
        let ratio: Affine.Discrete.Ratio<UInt, Bit> = .bitsPerWord
        #expect(ratio.factor == UInt.bitWidth)
    }

    @Test("bitWidth for UInt32 is 32")
    func bitWidthUInt32() {
        let ratio: Affine.Discrete.Ratio<UInt32, Bit> = .bitWidth
        #expect(ratio.factor == 32)
    }

    @Test("bitWidth for UInt64 is 64")
    func bitWidthUInt64() {
        let ratio: Affine.Discrete.Ratio<UInt64, Bit> = .bitWidth
        #expect(ratio.factor == 64)
    }
}

// MARK: - Byte-to-Bit Conversions

@Suite("Bit.Index byte conversions")
struct BitIndexByteTests {

    @Test("byte 0 maps to bit 0")
    func byte0() {
        let byteIndex: Index<UInt8> = 0
        let bitIndex = Bit.Index(byteIndex)
        #expect(bitIndex == 0)
    }

    @Test("byte 1 maps to bit 8")
    func byte1() {
        let byteIndex: Index<UInt8> = 1
        let bitIndex = Bit.Index(byteIndex)
        #expect(bitIndex == 8)
    }

    @Test("byte 3 maps to bit 24")
    func byte3() {
        let byteIndex: Index<UInt8> = 3
        let bitIndex = Bit.Index(byteIndex)
        #expect(bitIndex == 24)
    }

    @Test("byte 2 with bit offset 5 maps to bit 21")
    func byteWithOffset() throws {
        let byteIndex: Index<UInt8> = 2
        let offset: Index<Bit>.Offset = 5
        let bitIndex: Bit.Index = try .init(byteIndex, offset: offset)
        #expect(bitIndex == 21)
    }

    @Test("byte 0 with bit offset 0 maps to bit 0")
    func byteZeroOffsetZero() throws {
        #expect(try Bit.Index(0, offset: 0) == 0)
    }
}
