import UIKit

let a = 1

//内存为两个分块 1.堆-heap； 2.栈-stack
//指针(pointer)=内存地址
let b = a // b重新分配地址

struct Person{// 值类型
    var name = "小王"
    var age = 20
}

let p1 = Person()
var p2 = p1
p2.age = 30
p1.age// 20

class PersonC{
    var name = "小王"
    var age = 20
}
let p3 = PersonC()
let p4 = p3
p4.age = 30
p3.age//30
