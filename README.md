# Bit Index Primitives

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)
[![CI](https://github.com/swift-primitives/swift-bit-index-primitives/actions/workflows/ci.yml/badge.svg)](https://github.com/swift-primitives/swift-bit-index-primitives/actions/workflows/ci.yml)

`Bit.Index` — a typed position into a bit collection (`Index<Bit>`) — with byte↔bit conversions and the integer-to-bit ratios that drive them.

A bit position is a distinct type from a byte position or a raw `Int`, so the two can't be silently mixed; converting between `Index<Byte>` and `Bit.Index` goes through a typed `Affine.Discrete.Ratio` (8 bits per byte) rather than an open-coded `* 8`.

---

## Key Features

- **Typed bit position** — `Bit.Index` is `Index<Bit>`, a phantom-typed index that won't unify with `Index<Byte>` or a bare `Int`. Integer-literal friendly: `let i: Bit.Index = 5`.
- **Typed count and offset** — `Bit.Index.Count` (a `Cardinal`) carries bit counts and `Bit.Index.Offset` carries signed bit distances, each in its own type.
- **Byte → bit conversion** — `Bit.Index(Index<Byte>(1))` is bit 8; `Bit.Index(byteIndex, offset:)` adds a within-byte bit offset and throws if it overflows the byte.
- **Integer-to-bit ratios** — `Affine.Discrete.Ratio<Byte, Bit>.bitsPerByte` (factor 8), `.bitsPerWord` (`UInt.bitWidth`), and per-width `.bitWidth` (`UInt32` → 32, `UInt64` → 64).

---

## Quick Start

```swift
import Bit_Index_Primitives

// A typed bit position, plus its companion count and offset types:
let i: Bit.Index = 5
let count: Bit.Index.Count = 42
let offset: Bit.Index.Offset = 7
```

Convert a byte position to the bit it starts at — eight bits per byte:

```swift
let byteIndex: Index<Byte> = 1
Bit.Index(byteIndex)                    // bit 8

// …or to a specific bit within a byte (throws if the offset overflows):
let bit: Bit.Index = try Bit.Index(2, offset: 5)   // bit 21
```

The conversions are backed by typed ratios you can use directly:

```swift
Affine.Discrete.Ratio<Byte, Bit>.bitsPerByte.factor    // 8
Affine.Discrete.Ratio<UInt32, Bit>.bitWidth.factor     // 32
```

---

## Installation

Add the dependency to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/swift-primitives/swift-bit-index-primitives.git", branch: "main")
]
```

Add the product to your target:

```swift
.target(
    name: "App",
    dependencies: [
        .product(name: "Bit Index Primitives", package: "swift-bit-index-primitives")
    ]
)
```

Requires Swift 6.3.1 and macOS 26 / iOS 26 / tvOS 26 / watchOS 26 / visionOS 26 (or the corresponding Linux / Windows toolchain).

---

## Architecture

| Product | Contents | When to import |
|---------|----------|----------------|
| `Bit Index Primitives` | `Bit.Index` (= `Index<Bit>`), byte↔bit conversions, and the `Affine.Discrete.Ratio` bit ratios. Re-exports the `Index` and `Byte` surface it builds on. | Consumers |
| `Bit Index Primitives Test Support` | Re-exports upstream Test Support modules | Test target only |

---

## Platform Support

| Platform         | CI  | Status       |
|------------------|-----|--------------|
| macOS 26         | Yes | Full support |
| Linux            | Yes | Full support |
| Windows          | Yes | Full support |
| iOS/tvOS/watchOS | —   | Supported    |
| Swift Embedded   | —   | Supported    |

---

## Related Packages

- [`swift-index-primitives`](https://github.com/swift-primitives/swift-index-primitives) — the phantom-typed `Index<T>` / `Count` / `Offset` that `Bit.Index` specializes.
- [`swift-bit-primitives`](https://github.com/swift-primitives/swift-bit-primitives) — the `Bit` type this indexes over.
- [`swift-byte-primitives`](https://github.com/swift-primitives/swift-byte-primitives) — `Byte`, the other side of the byte↔bit conversions.
- [`swift-affine-primitives`](https://github.com/swift-primitives/swift-affine-primitives) — `Affine.Discrete.Ratio`, the typed integer ratios behind the conversions.
- [`swift-ordinal-primitives`](https://github.com/swift-primitives/swift-ordinal-primitives) — `Ordinal`, the position algebra underlying `Index`.

---

## Community

<!-- BEGIN: discussion -->
<!-- END: discussion -->

## License

Apache 2.0. See [LICENSE.md](LICENSE.md).
