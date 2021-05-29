import UIKit

// ARC(Automatic Reference Counting) - 自动引用计数
// 内存管理机制

// Reference Cycle - 循环引用,从而导致内存泄露（memory leak）
// 解决方法：weak(弱引用)和unowned(无主引用)

class Author{
    var name:String
    weak var video: Video?
    init(name: String) {
        self.name = name
    }
    deinit {
        print("Author对象被销毁了")
    }
}

class Video{
    unowned var author:Author
    init(author: Author) {
        self.author = author
    }
    deinit {
        print("Video对象被销毁了")
    }
}

// 互相引用了对方
var author : Author? = Author(name: "Lebus")
var video : Video? = Video(author: author!)
author?.video = video

author = nil
video = nil

class vc :UIViewController,UITableViewDelegate{
    var tableView:UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
    }
}
