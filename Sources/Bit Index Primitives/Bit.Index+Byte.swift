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
public import Index_Primitives
import Ordinal_Primitives

extension Bit.Index {

    /// Creates a bit index from a byte index (first bit of that byte).
    ///
    /// Converts a byte-aligned position to the corresponding bit position.
    /// Byte 0 → Bit 0, Byte 1 → Bit 8, etc.
    ///
    /// Uses the count chain: position N means "N bytes precede this position",
    /// which scales to "N×8 bits precede this position". All operations are
    /// total (non-throwing) because both position and ratio are non-negative.
    ///
    /// `Byte` (not `UInt8`) tags the source domain per the institute's
    /// byte-domain convention (`byte-protocol-capability-marker.md` Q1).
    ///
    /// - Parameter index: The byte index to convert.
    @inlinable
    public init(
        _ index: Index_Primitives.Index<Byte>
    ) {
        self = .zero + Index_Primitives.Index<Byte>.Count(index) * .bitsPerByte
    }

    /// Creates a bit index from a byte index plus a bit offset within
    /// (or beyond) that byte.
    ///
    /// Composes the byte-to-bit base position (byte N → bit N×8) with
    /// a signed bit displacement. The displacement may be negative or
    /// extend past the byte boundary; the result is clamped only by
    /// `Ordinal.Error.underflow` / `.overflow` on the final addition.
    ///
    /// ```swift
    /// // byte 2 + 5 bits = bit 21 (= 2×8 + 5)
    /// let bitIndex = try Bit.Index(byteIndex, offset: bitOffset)
    /// ```
    ///
    /// - Parameters:
    ///   - byteIndex: The byte-aligned base position.
    ///   - offset: A signed bit displacement from the byte's first bit.
    /// - Throws: `Ordinal.Error.underflow` if the composed position
    ///   would be negative; `.overflow` if it would exceed `UInt.max`.
    @inlinable
    public init(
        _ byteIndex: Index_Primitives.Index<Byte>,
        offset: Index_Primitives.Index<Bit>.Offset
    ) throws(Ordinal.Error) {
        self = try (.zero + Index_Primitives.Index<Byte>.Count(byteIndex) * .bitsPerByte) + offset
    }
}
