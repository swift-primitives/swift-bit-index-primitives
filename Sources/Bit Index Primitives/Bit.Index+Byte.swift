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
public import Ordinal_Primitives

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
        self = .zero + Index<UInt8>.Count(index) * .bitsPerByte
    }
}
