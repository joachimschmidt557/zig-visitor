const std = @import("std");

pub const BinaryExpression = struct {
    left: *const Expression,
    right: *const Expression,
};

pub const Expression = union(enum) {
    Value: i64,
    Add: BinaryExpression,
    Sub: BinaryExpression,
    Mul: BinaryExpression,
    Div: BinaryExpression,
};
