const std = @import("std");

const arith = @import("arith.zig");
const Expression = arith.Expression;
const BinaryExpression = arith.BinaryExpression;

pub fn ExpressionVisitor(comptime ArgTy: type, comptime RetTy: type) type {
    return struct {
        visitValue: VisitValueFn,
        visitAdd: VisitAddFn,
        visitSub: VisitSubFn,
        visitMul: VisitMulFn,
        visitDiv: VisitDivFn,

        const VisitValueFn = fn (arg: ArgTy, x: i64) RetTy;
        const VisitAddFn = fn (arg: ArgTy, x: BinaryExpression) RetTy;
        const VisitSubFn = fn (arg: ArgTy, x: BinaryExpression) RetTy;
        const VisitMulFn = fn (arg: ArgTy, x: BinaryExpression) RetTy;
        const VisitDivFn = fn (arg: ArgTy, x: BinaryExpression) RetTy;

        const Self = @This();

        pub fn visit(self: Self, arg: ArgTy, x: Expression) RetTy {
            return switch (x) {
                .Value => |val| self.visitValue(arg, val),
                .Add => |val| self.visitAdd(arg, val),
                .Sub => |val| self.visitSub(arg, val),
                .Mul => |val| self.visitMul(arg, val),
                .Div => |val| self.visitDiv(arg, val),
            };
        }
    };
}
