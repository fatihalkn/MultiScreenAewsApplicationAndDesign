
import UIKit

class ExploreController: UIViewController {
    
    @IBOutlet weak var mainExpCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var recentNewsCollectionView: UICollectionView!
    @IBOutlet weak var recommendentCollectionView: UICollectionView!
    @IBOutlet weak var explorMenuCollectionView: UICollectionView!
    
    var explorMenuCollectionViewData: [MenuModel] = [
        .init(type: .tech, title: "Tech"),
        .init(type: .science, title: "Science"),
        .init(type: .education, title: "Education"),
        .init(type: .business, title: "Business")
    ]
    var recentNewsCollectionViewData = [Model]()
    var recommendentCollectionViewData = [Model]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //MARK: - SearhBar Created
        
        let imageIcon = UIImageView()
        imageIcon.image = UIImage(named: "search")
        
        let contentView = UIView()
        contentView.addSubview(imageIcon)
        
        contentView.frame = CGRect(x: 0, y: 0, width: UIImage(named: "search")!.size.width, height: UIImage(named: "search")!.size.height)
        
        imageIcon.frame = CGRect(x: 5, y: 0, width: UIImage(named: "search")!.size.width, height: UIImage(named: "search")!.size.height)
        
        searchBar.leftView = contentView
        searchBar.leftViewMode = .always
        searchBar.clearButtonMode = .whileEditing
        
        delegete()
        registerCell()
        
        //MARK: - Recent Collction View API
        
        ApıCaller.shared.getTopStories  { [weak self] result in
            switch result {
                
            case .success(let articles):
                self?.recentNewsCollectionViewData = articles.compactMap({
                    Model(title: $0.title!, subtitle: $0.description ?? "No Discription", imageURL: URL(string: $0.urlToImage ?? ""), imageData: nil, publishedAt: $0.publishedAt ?? "No Date")
                    
                })
            case .failure(let error):
                print(error)
            }
            DispatchQueue.main.async {
                self?.recentNewsCollectionView.reloadData()
            }
            
        }
        
        
        //MARK: - Recommendent CollectionView API
        ApıCaller.shared.getTopStories  { [weak self] result in
            switch result {
                
            case .success(let articles):
                self?.recommendentCollectionViewData = articles.compactMap({
                    Model(title: $0.title!, subtitle: $0.description ?? "No Discription", imageURL: URL(string: $0.urlToImage ?? ""), imageData: nil, publishedAt: $0.publishedAt ?? "No Date")
                    
                })
            case .failure(let error):
                print(error)
            }
            DispatchQueue.main.async {
                self?.recommendentCollectionView.reloadData()
            }
            
        }
        
        
        
        
    }
    
    func registerCell() {
        
        recentNewsCollectionView.register(UINib(nibName: RecentCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: RecentCollectionViewCell.identifier)
        
        recommendentCollectionView.register(UINib(nibName: RecommendetCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: RecommendetCollectionViewCell.identifier)
        
        explorMenuCollectionView.register(UINib(nibName: ExploreMenuCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ExploreMenuCollectionViewCell.identifier)
        
    }
    
    func delegete() {
        recentNewsCollectionView.dataSource = self
        recentNewsCollectionView.delegate = self
        
        recommendentCollectionView.dataSource = self
        recommendentCollectionView.delegate = self
        
        explorMenuCollectionView.dataSource = self
        explorMenuCollectionView.delegate = self
        
    }
    
    
    
}
extension ExploreController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
            
        case recentNewsCollectionView:
            return recentNewsCollectionViewData.count
            
        case recommendentCollectionView:
            return recommendentCollectionViewData.count
            
        case explorMenuCollectionView:
            return explorMenuCollectionViewData.count
        default: return 0
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
            
        case recentNewsCollectionView:
            let cell = recentNewsCollectionView.dequeueReusableCell(withReuseIdentifier: RecentCollectionViewCell.identifier, for: indexPath) as! RecentCollectionViewCell
            cell.configure(with: recentNewsCollectionViewData[indexPath.item])
            return cell
            
        case recommendentCollectionView:
            let cell = recommendentCollectionView.dequeueReusableCell(withReuseIdentifier: RecommendetCollectionViewCell.identifier, for: indexPath) as! RecommendetCollectionViewCell
            cell.configure(with: recommendentCollectionViewData[indexPath.item])
            return cell
            
        case explorMenuCollectionView:
            let cell = explorMenuCollectionView.dequeueReusableCell(withReuseIdentifier: ExploreMenuCollectionViewCell.identifier, for: indexPath) as! ExploreMenuCollectionViewCell
            let menu = explorMenuCollectionViewData[indexPath.item]
            cell.setup(menu: menu)
            return cell
            
            
        default: return .init()
            
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case explorMenuCollectionView:
            explorMenuCollectionView.deselectItem(at: indexPath, animated: true)
            let selectedMenuType = explorMenuCollectionViewData[indexPath.item].type
            ApıCaller.shared.fetchNewsByCategory(category: selectedMenuType) { [weak self] result in
                switch result {
                case .success(let articles):
                    self?.recentNewsCollectionViewData = articles.compactMap({
                        Model(title: $0.title!, subtitle: $0.description ?? "No Discription", imageURL: URL(string: $0.urlToImage ?? ""), imageData: nil, publishedAt: $0.publishedAt ?? "No Date")
                    })
                    self?.recommendentCollectionViewData = articles.compactMap({
                        Model(title: $0.title!, subtitle: $0.description ?? "No Discription", imageURL: URL(string: $0.urlToImage ?? ""), imageData: nil, publishedAt: $0.publishedAt ?? "No Date")
                    })
                    
                    DispatchQueue.main.async {
                        self?.recommendentCollectionView.reloadData()
                    }
                    
                    DispatchQueue.main.async {
                        self?.recentNewsCollectionView.reloadData()
                    }
                case .failure(let error):
                    print(error)
                }
            }
        default: break
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case recommendentCollectionView, recentNewsCollectionView:
            let cellWidth = (collectionView.frame.width - 10) / 2
            let cellHeight = collectionView.frame.height
            return CGSize(width: cellWidth, height: cellHeight)
        default:
            return CGSize.init()
        }
    }
    
}

