# zig-visitor

Trying out the visitor pattern in zig

This repository contains a concrete implementation of the [visitor
pattern](https://en.wikipedia.org/wiki/Visitor_pattern) in the zig programming
language.

As the object structure to visit, a simple arithmetic expression tree is chosen.
The rough outline of this tagged union is laid out in the file `arith.zig`. The
file `visitor.zig` describes the common functionality of Visitors for our
expression type.

Two basic Visitors are implemented: A simple expression evaluator (in
`eval.zig`) and a prefix notation outputter (`prefix.zig`).
