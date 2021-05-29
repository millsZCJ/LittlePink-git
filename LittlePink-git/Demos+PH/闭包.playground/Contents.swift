import UIKit

// MARK: 使用场景1--全局函数
//直接调用
let label:UILabel = {
    let label = UILabel()
    label.text = ""
    return label
}()
//先定义，之后调用
let learn = { (lan : String) -> String in
    "学习\(lan)"
}
learn("iOS")

//和函数的区别
func learn1(_ lan : String) -> String{
    "学习\(lan)"
}
learn1("iOS")

// 定义类型
let aa:Int?
let bb:(() -> Void)?

// MARK: - 使用场景2--嵌套函数
func codingSwift(day: Int,program: () -> String){
    print("学习Swift\(day)天了，写了\(program())App")
}
//传参时直接写闭包
codingSwift(day: 40) { () -> String in
    "天气"
}
//传参时写已经写好了的闭包'名'
let appName = { () -> String in
    "Todos"
}
codingSwift(day: 60, program: appName)
//传参数写已经写好了的函数名（需参数和返回值的个数和类型完全一样）
func appName1() -> String {
    "计算器"
}
codingSwift(day: 100, program: appName1)

// MARK: - 闭包简写1 -- 尾随闭包Trailing Closure
codingSwift(day: 130){ () -> String in
    "机器学习"
}

// MARK: - 闭包简写2 -- 根据上下文推断类型
func codingSwift(day: Int, appName: String,res: (Int,String) -> String){
    print("学习Swift\(day)天了，\(res(1,"Alamofire")),做成了\(appName)App")
}

codingSwift(day: 40, appName: "天气") { (takeDay, use) -> String in
    "花了\(takeDay)天,使用了\(use)技术"
}

codingSwift(day: 50, appName: "新闻") {
    "花了\($0)天,使用了\($1)技术"
}

// MARK: - 系统函数案例--sorted
let arr = [3,5,1,2,4]
let sortedArr = arr.sorted(by: {
    $0 < $1
})
let sortedArr1 = arr.sorted(by: <)

// MARK: - 闭包捕获
func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
//    func incrementer() -> Int {
//        runningTotal += amount
//        return runningTotal
//    }
    let incrementer = { () -> Int in
        runningTotal += amount
        return runningTotal
    }
    
    return incrementer
}

let incrementByTen = makeIncrementer(forIncrement: 10)
incrementByTen()// returns a value of 10
incrementByTen()// returns a value of 20
incrementByTen()// returns a value of 30

let incrementBySeven = makeIncrementer(forIncrement: 7)
incrementBySeven()// 7
incrementByTen()// 40

// MARK: - 闭包是引用类型
let alsoIncrementByTen = incrementByTen
alsoIncrementByTen()//50

incrementByTen()//60

// MARK: - 逃逸闭包(@escaping)
var completionHandlers : [() -> ()] = []
func someFunctionWithEscapingClosure(completionHandler:@escaping () -> Void) {
    //开启某个网络耗时任务（异步），在耗时任务执行完之后需要调用闭包
    completionHandlers.append(completionHandler)
}

func someFunctionWithNonescapingClosure(closure: () -> Void) {
    closure()
}

class SomeClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure { self.x = 100 }
        someFunctionWithNonescapingClosure { x = 200 }
    }
}

let instance = SomeClass()
instance.doSomething()
print(instance.x)// Prints "200"


completionHandlers.first?()
print(instance.x)// Prints "100"

//实际应用
class SomeVC{
    func getData(finished: @escaping (String) -> ()){
        print("外层函数开始执行")
        DispatchQueue.global().async {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                finished("我是数据")
            }
        }
        print("外层函数执行结束")
    }
}

let someVC = SomeVC()
someVC.getData { (data) in
    print("逃逸执行闭包,拿到了耗时任务的数据--\(data),可以做一些其他处理了")
}

