# Quaternion

Quaternions, much like [complex][complex] numbers, form a number system that extends the real numbers. They are defined by a real component, and three imaginary components. The real component is commonly called the scalar part, while the imaginary components are called the vector part. Although not limited to, quaternions are frequently used as a representation of the rotation of an object in three dimensions – such as in simulations, computer graphics, computer vision and more.

This module provides a `Quaternion` type generic over an underlying `RealType`:

```swift
1> import QuaternionModule
2> let q = Quaternion(real: 1, imaginary: 1,1,1) // q = 1 + i + j + k
```

The usual [arithmetic](#arithmetic) operators are provided for Quaternions, many useful properties, as well as conversion to and from other [transformation](#transformation) representations such as angle-axis, rotation vectors and polar decomposition. Quaternions conform to the usual protocols: `Equatable`, `Hashable`, `Codable` (if the underlying `RealType` is); but also `AdditiveArithmetic`, `Numeric`, `SignedNumeric` and `AlgebraicField`.

## Arithmetic

The module defines protocol conformance on `Quaternion` for `AdditiveArithmetic`, `SignedNumeric` and `AlgebraicField`. Additionally, the module provides a `normalized` property on `Quaternion`. For any finite and non-zero quaternion `normalized` produces its norm.

The module, however, does not provide operators for mixed real-quaternion arithmetic. They are not provided for two reasons: 

- Swift generally avoids heterogenous arithmetic operators
- They lead to counter-intuitive behavior of type inference

For a concrete example of the second point, suppose that heterogeneous arithmetic operators existed, suppose that we're in a Quaternion type context and consider the following snippet:

```swift
extension Quaternion {
  static func doSomething() {
    let a: RealType = 1
    let b = 2*a // type is inferred as Quaternion 🤪
  }
}
```

This is a show-stopper for heterogeneous arithmetic operators in the short term ([#12][i12]).

For additional information on arithmetics, consult [Arithmetic](Arithmetic.md).

## Norms

Quaternions define a normed vector space over the real numbers with 4 dimensions. When viewed as a vector space, many [different norms][norms] can be defined on Quaternion.

The `Numeric` protocol requires a `.magnitude` property, but (deliberately) does not fully specify the semantics.
While the most obvious choice for `Quaternion` would be to use the Euclidean norm (aka the "2-norm", given by `sqrt(ix*ix + iy*iy + iz*iz + r*r)`), in practice there are good reasons to use something else instead. Quaternion binds `.magnitude` to the ∞-norm (aka the maximum norm, given by `max(abs(ix) + abs(iy) + abs(iz) + abs(r))`). For discussion of this choice, as well as background information on norms, consult [Norms.md](Norms.md).

## Transformation

In computer science, quaternions are frequently used to represent three-dimensional rotations; as quaternions have some advantages over other representations.

This module provides conversion to and from other three-dimensional rotation representations, namely angle-axis, rotation vectors and polar decomposition. Additionally, the module provides an optimized method to rotate arbitrary vectors by a quaternion. For additional information on transformations and other forms of transformation representations, consult [Transformation](Transformation.md)

---

## Design notes

### Infinity and nan

`Quaternion`, much like [`Complex`][complex], does not assign any semantic meaning to the sign of zero and infinity; `(±0,±0,±0,±0)`, are all considered to be encodings of the value zero.
Similarly, all quaternions with either value being `±inf` or `nan` are all to be encodings of a single exceptional value with infinite magnitude and an undefined angle as well as an undefined axis.

Because angle and axis are undefined, the `real` and `imaginary` properties return `.nan` for non-finite values.
This decision might be revisited once users gain some experience working with the type to make sure that it's a tradeoff that we're happy with, but early experiments show that it greatly simplifies the implementation of some operations without significant tradeoffs in usability.

[complex]: ../ComplexModule/README.md
[i12]: https://github.com/apple/swift-numerics/issues/12
[norms]: https://en.wikipedia.org/wiki/Norm_(mathematics)
[gimbal]: https://en.wikipedia.org/wiki/Gimbal_lock