const std = @import("std");
const Allocator = std.mem.Allocator;

const arith = @import("arith.zig");
const Expression = arith.Expression;
const BinaryExpression = arith.BinaryExpression;

const ExpressionVisitor = @import("visitor.zig").ExpressionVisitor;

pub const PrefixFormatter = ExpressionVisitor(Allocator, Allocator.Error![]u8){
    .visitValue = visitValue,
    .visitAdd = visitAdd,
    .visitSub = visitSub,
    .visitMul = visitMul,
    .visitDiv = visitDiv,
};

fn visitValue(arg: Allocator, x: i64) Allocator.Error![]u8 {
    return try std.fmt.allocPrint(arg, "{}", .{x});
}

fn visitAdd(arg: Allocator, x: BinaryExpression) Allocator.Error![]u8 {
    const left = try PrefixFormatter.visit(arg, x.left.*);
    const right = try PrefixFormatter.visit(arg, x.right.*);
    defer arg.free(left);
    defer arg.free(right);

    return try std.fmt.allocPrint(arg, "(+ {s} {s})", .{ left, right });
}

fn visitSub(arg: Allocator, x: BinaryExpression) Allocator.Error![]u8 {
    const left = try PrefixFormatter.visit(arg, x.left.*);
    const right = try PrefixFormatter.visit(arg, x.right.*);
    defer arg.free(left);
    defer arg.free(right);

    return try std.fmt.allocPrint(arg, "(- {s} {s})", .{ left, right });
}

fn visitMul(arg: Allocator, x: BinaryExpression) Allocator.Error![]u8 {
    const left = try PrefixFormatter.visit(arg, x.left.*);
    const right = try PrefixFormatter.visit(arg, x.right.*);
    defer arg.free(left);
    defer arg.free(right);

    return try std.fmt.allocPrint(arg, "(* {s} {s})", .{ left, right });
}

fn visitDiv(arg: Allocator, x: BinaryExpression) Allocator.Error![]u8 {
    const left = try PrefixFormatter.visit(arg, x.left.*);
    const right = try PrefixFormatter.visit(arg, x.right.*);
    defer arg.free(left);
    defer arg.free(right);

    return try std.fmt.allocPrint(arg, "(/ {s} {s})", .{ left, right });
}
