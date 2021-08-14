const std = @import("std");

const arith = @import("arith.zig");
const Expression = arith.Expression;
const BinaryExpression = arith.BinaryExpression;

const ExpressionVisitor = @import("visitor.zig").ExpressionVisitor;

pub const Evaluator = ExpressionVisitor(void, i64){
    .visitValue = visitValue,
    .visitAdd = visitAdd,
    .visitSub = visitSub,
    .visitMul = visitMul,
    .visitDiv = visitDiv,
};

fn visitValue(arg: void, x: i64) i64 {
    _ = arg;
    return x;
}

fn visitAdd(arg: void, x: BinaryExpression) i64 {
    _ = arg;
    return Evaluator.visit({}, x.left.*) + Evaluator.visit({}, x.right.*);
}

fn visitSub(arg: void, x: BinaryExpression) i64 {
    _ = arg;
    return Evaluator.visit({}, x.left.*) - Evaluator.visit({}, x.right.*);
}

fn visitMul(arg: void, x: BinaryExpression) i64 {
    _ = arg;
    return Evaluator.visit({}, x.left.*) * Evaluator.visit({}, x.right.*);
}

fn visitDiv(arg: void, x: BinaryExpression) i64 {
    _ = arg;
    return @divTrunc(Evaluator.visit({}, x.left.*), Evaluator.visit({}, x.right.*));
}
