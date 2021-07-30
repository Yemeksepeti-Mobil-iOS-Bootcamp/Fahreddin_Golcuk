//
//  ViewController.swift
//  gamedb
//
//  Created by Fahreddin Gölcük on 27.07.2021.
//

import UIKit

class ViewController: UIViewController {
    var slicedList: [Game]?
    var gameList: [Game]? {
        didSet {
            //MARK: - Main thred is required for views Initialization
            DispatchQueue.main.async {
                self.initializePageController()
            }
        }
    }
    
    var filteredGameList: [Game]? {
        didSet {
            //MARK: -Page control visible control when do filter (reload and visibility just works in dispatchqueue)
            DispatchQueue.main.async {
                if(self.filteredGameList?.count ?? 0 < self.gameList?.count ?? 0) {
                    self.pageController.view.isHidden = true
                } else {
                    self.pageController.view.isHidden = false
                }
                self.collectionView.reloadData()
            }
        }
    }
    
    func filterList(searchText: String, isEmpty: Bool) {
        if(isEmpty){
            self.filteredGameList = self.gameList
        } else {
            self.filteredGameList = self.gameList?.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    private var onBoardingControllers: [UIViewController] = []
    private var pageController: UIPageViewController!
    
    //MARK: -Controller components
    let searchBar = UISearchBar(frame: CGRect(x: 0, y: 20, width: UIScreen.main.bounds.width, height: 40))
    var collectionView: UICollectionView!
    
    func setupPageViewController() {
        self.pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.pageController?.delegate = self
        self.pageController?.dataSource = self
        view.addSubview(pageController.view)
    }
    
    func initializePageController() {
        onBoardingControllers.removeAll()
        for (index, _) in gameList!.prefix(3).enumerated() {
            let vc = UIViewController()
            let imageView = UIImageView()
            let tapGestureRecognizer = GameImageViewTapRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            tapGestureRecognizer.id = gameList?[index].id ?? 0
            imageView.downloadURL(urlPath: "\(gameList?[index].background_image ?? "")")
            imageView.isUserInteractionEnabled = true
            imageView.addGestureRecognizer(tapGestureRecognizer)
            vc.view.addSubview(imageView)
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 16
            imageView.anchor(top: vc.view.topAnchor, leading: vc.view.leadingAnchor, bottom: vc.view.bottomAnchor, trailing: vc.view.trailingAnchor,padding: UIEdgeInsets(top: 8, left: 24, bottom: 8, right: 24))
            vc.view.backgroundColor = .white
            onBoardingControllers.append(vc)
        }
        self.pageController.setViewControllers([onBoardingControllers[0]], direction: .forward, animated: false)
    }
    
    @objc func imageTapped(tapGestureRecognizer: GameImageViewTapRecognizer)
    {
        let vc = GameDetailViewController()
        vc.id = tapGestureRecognizer.id
        self.navigationController?.pushViewController(vc, animated: true)
        // Your action
    }
    
    let centerBtn = UIButton.init(type: .custom)
    
    @objc func pressedCenter(){
        print("Pressed center button")
    }
    
    func customTabbarSetup() {
        let titleCenter = UILabel()
        let imageCenter = UIImageView()
        titleCenter.text = "Magic"
        titleCenter.textColor = .white
        titleCenter.font = UIFont.systemFont(ofSize: 12.0)
        titleCenter.textAlignment = .center
        imageCenter.image = UIImage(systemName: "sparkles")
        imageCenter.tintColor = .white
        imageCenter.contentMode = .scaleAspectFill
        centerBtn.addSubview(imageCenter)
        centerBtn.addSubview(titleCenter)
        imageCenter.anchor(top: centerBtn.topAnchor, leading: centerBtn.leadingAnchor, bottom: nil, trailing: centerBtn.trailingAnchor,padding: UIEdgeInsets(top: 8, left: 16, bottom: 16, right: 16))
        titleCenter.anchor(top: imageCenter.bottomAnchor, leading: centerBtn.leadingAnchor, bottom: centerBtn.bottomAnchor, trailing: centerBtn.trailingAnchor,padding: UIEdgeInsets(top: 0, left: 0, bottom: 6, right: 0))
        centerBtn.setTitleColor(.black, for: .normal)
        centerBtn.backgroundColor = .systemYellow
        centerBtn.contentHorizontalAlignment = .center
        centerBtn.contentVerticalAlignment = .fill
        centerBtn.layer.cornerRadius = 36
        centerBtn.layer.borderWidth = 0.15
        centerBtn.addTarget(self, action: #selector(pressedCenter), for: .touchUpInside)
        centerBtn.frame = CGRect(x: view.center.x - 38, y: (tabBarController?.tabBar.frame.height ?? 0) - 64, width: 76, height: 76)
        tabBarController?.tabBar.addSubview(centerBtn)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customTabbarSetup()
        getGames() { (result) in
            self.gameList = result
            self.filteredGameList = result
            self.slicedList = Array(result[3...result.count - 1])
        }
        //MARK: -SEARCH BAR
        searchBar.delegate = self
        searchBar.isTranslucent = false
        searchBar.placeholder = "Search game"
        searchBar.tintColor = UIColor(red:0.73, green:0.76, blue:0.78, alpha:1.0)
        self.view.addSubview(searchBar)
        searchBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor)
        setupPageViewController()
        
        //MARK: -COLLECTIONVIEW SETTINGS
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionView.register(GameCollectionViewCell.self, forCellWithReuseIdentifier: GameCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        
        //MARK: -STACK VIEW SETTINGS ( FOR AVOID BLANK SPACE WHEN CHANGE PAGE CONTROLLER VISIBILITY )
        let gameViewStack = UIStackView()
        view.addSubview(gameViewStack)
        gameViewStack.axis = .vertical
        gameViewStack.spacing = 20
        gameViewStack.distribution = .fillEqually

        gameViewStack.addArrangedSubview(pageController.view)
        gameViewStack.addArrangedSubview(collectionView)
        
        gameViewStack.anchor(top: searchBar.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
        
    //MARK: -Navigation top bar hide configuration
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
        title = "Main"
        tabBarItem.image = UIImage(systemName: "homekit")
    }
}

//MARK: -Collection View Delegate & Data Source
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    //MARK: -Collection View Cell Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width * 0.9, height: self.view.frame.height / 8)
    }
    
    //MARK: -Collection View Cell Count
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !searchBar.text!.isEmpty {
            if filteredGameList?.count == 0 {
                collectionView.backgroundView = ListEmpty(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
            } else {
                collectionView.backgroundView = nil
            }
            return filteredGameList?.count ?? 0
        }else {
            return slicedList?.count ?? 0
        }
    }
    
    //MARK: -CollectionView introduce to custom view cell.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameCollectionViewCell.identifier, for: indexPath) as? GameCollectionViewCell
        if !searchBar.text!.isEmpty {
            cell?.configure(with: filteredGameList![indexPath.row])
        }else {
            cell?.configure(with: slicedList![indexPath.row])
        }
        cell?.contentView.isUserInteractionEnabled = true
        return cell!
    }
    
    //MARK: -CollectionView trigger when pressed item
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("items")
        let vc = GameDetailViewController()
        if !searchBar.text!.isEmpty {
            vc.id = filteredGameList?[indexPath.row].id
        }else {
            vc.id = slicedList?[indexPath.row].id
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


//MARK: -Update list on view model via search bar
extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        var isSearchBarEmpty: Bool {
            return searchBar.text?.isEmpty ?? true
        }
        filterList(searchText: searchBar.text!,isEmpty: isSearchBarEmpty)
        collectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        initializePageController()
    }
}


//MARK: -PAGE CONTROLLER DELEGATE & DATA SOURCE

extension ViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = onBoardingControllers.firstIndex(of: viewController), index > 0 else {
            return nil
        }
        let prev = index - 1
        return onBoardingControllers[prev]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = onBoardingControllers.firstIndex(of: viewController), index < onBoardingControllers.count - 1 else {
            return nil
        }
        let next = index + 1
        return onBoardingControllers[next]
    }
}

class GameImageViewTapRecognizer: UITapGestureRecognizer {
    var id = Int()
}

