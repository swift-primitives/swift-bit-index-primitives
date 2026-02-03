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
    /// This uses the affine decomposition: convert position to offset from
    /// origin, scale, then translate back. This is mathematically correct
    /// because positions cannot be scaled directly in affine geometry.
    ///
    /// - Parameter index: The byte index to convert.
    @inlinable
    public init(_ byteIndex: Index_Primitives.Index<UInt8>) {
        // Affine decomposition: position as offset from origin, scale, translate back
        let byteOffset = Index<UInt8>.Offset(Affine.Discrete.Vector(Int(bitPattern: byteIndex.position)))
        let bitOffset = byteOffset * .bitsPerByte
        self.init(__unchecked: (), Ordinal(UInt(bitOffset.rawValue.rawValue)))
    }

    /// Creates a bit index from a byte index and bit offset within that byte.
    ///
    /// - Parameters:
    ///   - byteIndex: The byte index.
    ///   - bitOffset: The bit offset within the byte (0..<8).
    @inlinable
    public init(
        _ byteIndex: Index_Primitives.Index<UInt8>,
        bitOffset: Index<Bit>.Offset
    ) {
        // Scale byte offset to bit offset, then add bit offset within byte
        let byteAsOffset = Index<UInt8>.Offset(Affine.Discrete.Vector(Int(bitPattern: byteIndex.position)))
        let baseBitOffset = byteAsOffset * .bitsPerByte
        let totalBitOffset = baseBitOffset.rawValue.rawValue + bitOffset.rawValue.rawValue
        self.init(__unchecked: (), Ordinal(UInt(totalBitOffset)))
    }
}
