import UIKit

// MARK: - 语法
enum CompassPoint {
    case north
    case south
    case east
    case west
}

var directionToHead: CompassPoint = .east
directionToHead = .north

// MARK: - 编辑
enum Beverage:CaseIterable {
    case coffee,tea,juice
}

let numberOfChoice = Beverage.allCases.count
print("\(numberOfChoice) beverages available")

for beverage in Beverage.allCases {
    print(beverage)
}

// MARK: - 原始值 Raw Vaules
enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}
ASCIIControlCharacter.tab.rawValue

//隐式给原始值
enum Planet: Int{
    case mercury = 1,venus,earth,mars,jupiter, saturn,uranus,neptune
}
Planet.earth.rawValue


enum CompassPoint1 : String {
    case north
    case south
    case east
    case west
}
CompassPoint1.north.rawValue

Planet.uranus
Planet(rawValue: 7)

// MARK: - 关联值 Assciated Values

enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}

var productBarcode = Barcode.upc(8, 85909, 51226, 3)
productBarcode = .qrCode("xxx")

switch productBarcode {
case .upc(let numberSystem, let manufacturer, let product, let check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
case .qrCode(let productCode):
    print("QR code: \(productCode).")
}

//判断并去除关联值的简写
if case let .qrCode(productCode) = productBarcode {
    print(productCode)
    
}
