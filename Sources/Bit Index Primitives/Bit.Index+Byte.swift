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
public import Index_Primitives

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
    /// - Parameter index: The byte index to convert.
    @inlinable
    public init(
        _ index: Index_Primitives.Index<UInt8>
    ) {
        self = Self(Index<UInt8>.Count(index) * .bitsPerByte)
    }

    /// Creates a bit index from a byte index and bit offset within that byte.
    ///
    /// - Parameters:
    ///   - index: The byte index.
    ///   - offset: The bit offset within the byte (0..<8).
    /// - Throws: `Ordinal.Error` if the offset causes underflow.
    @inlinable
    public init(
        _ index: Index<UInt8>,
        offset: Index<Bit>.Offset
    ) throws(Ordinal.Error) {
        self = try Self(Index<UInt8>.Count(index) * .bitsPerByte) + offset
    }
}
