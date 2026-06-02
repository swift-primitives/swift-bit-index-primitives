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

public import Affine_Primitives
public import Byte_Primitives

// MARK: - Generic Bit Width Ratio

extension Affine.Discrete.Ratio where To == Bit, From: FixedWidthInteger {
    /// The number of bits in the `From` type.
    ///
    /// This generic constant provides the correct ratio for any fixed-width integer:
    /// - `Ratio<UInt, Bit>.bitWidth` → 64 (on 64-bit platforms)
    /// - `Ratio<UInt8, Bit>.bitWidth` → 8
    /// - `Ratio<UInt32, Bit>.bitWidth` → 32
    ///
    /// ## Example
    ///
    /// ```swift
    /// let offset = Index<UInt32>.Offset(3)
    /// let bitOffset = offset * .bitWidth  // Index<Bit>.Offset(96)
    /// ```
    @inlinable
    public static var bitWidth: Self { .init(From.bitWidth) }
}

// MARK: - Semantic Aliases

extension Affine.Discrete.Ratio where From == Byte, To == Bit {
    /// The number of bits per byte (8).
    ///
    /// `Byte` is the institute's byte-domain marker (per
    /// `byte-protocol-capability-marker.md` Q1). The generic
    /// `Ratio.bitWidth` alias requires `From: FixedWidthInteger`,
    /// which `Byte` deliberately does not conform to (`Byte` is the
    /// byte-domain twin of the arithmetic `UInt8`); the factor `8`
    /// is hardcoded for this domain pair.
    ///
    /// ## Example
    ///
    /// ```swift
    /// let byteOffset = Index<Byte>.Offset(2)
    /// let bitOffset = byteOffset * .bitsPerByte  // Index<Bit>.Offset(16)
    /// ```
    @inlinable
    public static var bitsPerByte: Self { .init(8) }
}

extension Affine.Discrete.Ratio where From == UInt, To == Bit {
    /// The number of bits per machine word (64 on 64-bit platforms).
    ///
    /// ## Example
    ///
    /// ```swift
    /// let wordOffset = Index<UInt>.Offset(2)
    /// let bitOffset = wordOffset * .bitsPerWord  // Index<Bit>.Offset(128)
    /// ```
    @inlinable
    public static var bitsPerWord: Self { .bitWidth }
}
