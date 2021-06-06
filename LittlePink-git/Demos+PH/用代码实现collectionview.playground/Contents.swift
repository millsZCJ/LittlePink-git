//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

// MARK: - 若playground无法运行,则复制进空项目,删掉loadView函数,并把除了首尾两行代码之外的代码复制进viewdidload

class MyViewController : UIViewController, UICollectionViewDataSource {
    
    private let photos = [UIImage(named: "1"), UIImage(named: "2")]
    
    private lazy var cv: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 90, height: 90)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .systemBackground
        
        //元类型(类型的类型)-metatype
        //let x: Int = 1
        //let xx: Int.Type = Int.self
        cv.register(CVCell.self, forCellWithReuseIdentifier: "CVCellID")
        cv.dataSource = self
        
        return cv
    }()
    
    override func loadView() {
        let view = UIView()

        view.addSubview(cv)
        setUI()
        
        self.view = view
    }
    
    private func setUI(){
        cv.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        cv.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        cv.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        cv.heightAnchor.constraint(equalToConstant: 90).isActive = true
        
//        NSLayoutConstraint.activate([
//            cv.heightAnchor.constraint(equalToConstant: 90)
//        ])
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVCellID", for: indexPath) as! CVCell
        cell.imageView.image = photos[indexPath.item]
        return cell
    }
    
}

class CVCell: UICollectionViewCell{
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI(){
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    }
}


// Present the view controller in the Live View window
//因一运行这句话就红圈报错,故注释掉,扫清视野.等日后playground修复好后可去掉注释
//PlaygroundPage.current.liveView = MyViewController()
