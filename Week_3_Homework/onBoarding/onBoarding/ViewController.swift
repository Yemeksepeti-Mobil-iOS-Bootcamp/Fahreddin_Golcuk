//
//  ViewController.swift
//  onBoarding
//
//  Created by Fahreddin Gölcük on 7.07.2021.
//

import UIKit

let ONBOARDING_ITEM_COUNT = 4

struct BoardingItem {
    var title: String
    var description: String
    var image: String
}

class ViewController: UIViewController {
    
    func chooseBoardingItem(index: Int) -> BoardingItem {
        switch index {
        case 0:
            return BoardingItem(title: "He can fly", description: "deneme", image: "superman")
        case 1:
            return BoardingItem(title: "She can swim", description: "deneme", image: "swimmer")
        case 2:
            return BoardingItem(title: "He can fight", description: "deneme", image: "warrior")
        case 3:
            return BoardingItem(title: "He can go to moon", description: "deneme", image: "astronot")
        default:
            return BoardingItem(title: "", description: "", image: "superman")
        }
    }
    
    private var onBoardingControllers: [UIViewController] = []
    private var pageController: UIPageViewController!
    private var pageControl : UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupPageViewController()
        self.setupPageControl()
    }
    
    func setupPageControl(){
        self.pageControl =  UIPageControl(frame: CGRect(x:self.view.center.x / 2, y: self.view.bounds.height - 70, width:200, height:50))
        self.pageControl.numberOfPages = ONBOARDING_ITEM_COUNT
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.red
        self.pageControl.pageIndicatorTintColor = UIColor.black
        self.pageControl.currentPageIndicatorTintColor = UIColor.blue
        self.pageControl.addTarget(self, action: #selector(pageControlSelection(_:)), for: .touchUpInside)
        self.view.addSubview(pageControl)
    }
    
    @objc func pageControlSelection(_ sender: UIPageControl) {
        let page: Int? = sender.currentPage
        pageController.setViewControllers([onBoardingControllers[page!]], direction: .forward, animated: true, completion: nil)
    }
    
    func setupPageViewController() {
        self.pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.pageController?.delegate = self
        self.pageController?.dataSource = self
        addChild(self.pageController)
        view.addSubview(pageController.view)
        let views = ["pageController": pageController.view] as [String: AnyObject]
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[pageController]|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[pageController]|", options: [], metrics: nil, views: views))
        for index in 0 ... (ONBOARDING_ITEM_COUNT - 1 ){
            let onboardingItem: BoardingItem = chooseBoardingItem(index: index)
            let vc = UIViewController()
            let image = UIImage(named: onboardingItem.image)
            let imageView = UIImageView()
            imageView.contentMode = UIView.ContentMode.scaleAspectFit
            imageView.frame.size.width = 200
            imageView.frame.size.height = 200
            imageView.center = self.view.center
            imageView.image = image
            vc.view.addSubview(imageView)
            let label = UILabel(frame: CGRect(x: 0, y: 90, width: self.view.bounds.width, height: 90))
            label.text = onboardingItem.title
            label.textAlignment = .center
            label.font = UIFont(name: "systemFont", size: 45)
            label.textColor = .white
            vc.view.addSubview(label)
            vc.view.backgroundColor = randomColor()
            onBoardingControllers.append(vc)
        }
        self.pageController.setViewControllers([onBoardingControllers[0]], direction: .forward, animated: false)
    }
    
    func randomCGFloat() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
    
    func randomColor() -> UIColor {
        return UIColor(red: randomCGFloat(), green: randomCGFloat(), blue: randomCGFloat(), alpha: 1)
    }
    
}

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
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool,       previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        self.pageControl.currentPage = onBoardingControllers.firstIndex(of: pageViewController.viewControllers![0])!
    }
}
