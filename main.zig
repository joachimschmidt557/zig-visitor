const std = @import("std");

const arith = @import("arith.zig");
const Expression = arith.Expression;
const BinaryExpression = arith.BinaryExpression;

// The abstract visitor
const ExpressionVisitor = @import("visitor.zig").ExpressionVisitor;

// Implementations of the visitor
const Evaluator = @import("eval.zig").Evaluator;
const PrefixFormatter = @import("prefix.zig").PrefixFormatter;

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = &gpa.allocator;

    const a = Expression{ .Value = 12 };
    const b = Expression{ .Value = 34 };
    const c = Expression{ .Add = BinaryExpression{ .left = &a, .right = &b } };
    const d = Expression{ .Mul = BinaryExpression{ .left = &a, .right = &c } };

    // First example of a visitor: Evaluate an expression
    std.debug.warn("{}\n", .{Evaluator.visit({}, d)});

    // Second example: Print an expression in a lisp-y prefix form
    const prefix_formatted = try PrefixFormatter.visit(allocator, d);
    defer allocator.free(prefix_formatted);

    std.debug.warn("{s}\n", .{prefix_formatted});
}
