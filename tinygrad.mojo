from math import tanh

@value
@register_passable("trivial")
struct Val:
    var left: Pointer[Int]
    var right: Pointer[Int]
    var data: Float64
    var grad: Float64
    var op: StringLiteral

    fn __init__(data: Float64) -> Val:
        return Val(Pointer[Int].get_null(), Pointer[Int].get_null(), data, 0.0, "")

    fn __add__(self, other: Val) -> Val:
        return self.new(self.data + other.data, other, "+")

    fn __add__(self, other: Float64) -> Val:
        return self + Val(other)

    fn __neg__(self) -> Val:
        return self * -1

    fn __sub__(self, other: Val) -> Val:
        return self + (-other)

    fn __sub__(self, other: Float64) -> Val:
        return self + (-Val(other))

    fn __radd__(self, other: Float64) -> Val:
        return self + Val(other)

    fn __mul__(self, other: Val) -> Val:
        return self.new(self.data * other.data, other, "*")

    fn __mul__(self, other: Float64) -> Val:
        return self * Val(other)

    fn __rmul__(self, other: Float64) -> Val:
        return self * Val(other)

    fn tanh(self) -> Val:
        return self.new(tanh(self.data), "tanh")

    fn new(self, data: Float64, op: StringLiteral) -> Val:
        let l = Pointer[Val].alloc(1)
        l.store(self)
        return Val(l.bitcast[Int](), Pointer[Int].get_null(), data, 0.0, op)

    fn new(self, data: Float64, right: Val, op: StringLiteral) -> Val:
        let l = Pointer[Val].alloc(1)
        l.store(self)
        let r = Pointer[Val].alloc(1)
        r.store(right)
        return Val(l.bitcast[Int](), r.bitcast[Int](), data, 0.0, op)

    fn backward_prop(inout self):
        self.grad = 1
        self.backward(self)

    fn print_all(self):
        self.print_backward(self)

    @staticmethod
    fn print_backward(node: Val):
        if node.left and node.right:
            let left = node.left.bitcast[Val]().load(0)
            let right = node.right.bitcast[Val]().load(0)
            print(left.data, "(", left.grad, ")", node.op, right.data, "(", right.grad, ")", "=", node.data)
        elif node.left:
            let left = node.left.bitcast[Val]().load(0)
            print(left.data, "(", left.grad, ")", node.op, "=", node.data)

        if node.left:
            let left = node.left.bitcast[Val]().load(0)
            Val.print_backward(left)

        if node.right:
            let right = node.right.bitcast[Val]().load(0)
            Val.print_backward(right)

    @staticmethod
    fn backward(inout node: Val):
        if node.op == "":
            return
        if node.op == "+":
            var left = node.left.bitcast[Val]().load(0)
            var right = node.right.bitcast[Val]().load(0)
            left.grad += node.grad
            right.grad += node.grad
            node.left.bitcast[Val]().store(0, left)
            node.right.bitcast[Val]().store(0, right)
            Val.backward(left)
            Val.backward(right)
        elif node.op == "*":
            var left = node.left.bitcast[Val]().load(0)
            var right = node.right.bitcast[Val]().load(0)
            left.grad += right.data * node.grad
            right.grad += left.data * node.grad
            node.left.bitcast[Val]().store(0, left)
            node.right.bitcast[Val]().store(0, right)
            Val.backward(left)
            Val.backward(right)
        elif node.op == "tanh":
            var left = node.left.bitcast[Val]().load(0)
            left.grad += (1 - tanh(left.data)**2) * node.grad
            node.left.bitcast[Val]().store(0, left)
            Val.backward(left)
        else:
            print("unknown operator:", node.op)
            return

fn main():
    # inputs
    let x1 = Val(2.0)
    let x2 = Val(0.0)

    # weights
    let w1 = Val(-3.0)
    let w2 = Val(1.0)

    # #bias
    let b = Val(6.8813735870195432)

    let x1w1 = x1 * w1
    let x2w2 = x2 * w2

    let x1w1x2w2 = x1w1 + x2w2

    let n = x1w1x2w2 + b

    var o = n.tanh()

    o.backward_prop()
    o.print_all()
