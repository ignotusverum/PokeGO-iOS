//
//  EZSwipeController.swift
//  EZSwipeController
//
//  Created by Goktug Yilmaz on 24/10/15.
//  Copyright © 2015 Goktug Yilmaz. All rights reserved.
//
import UIKit

@objc public protocol EZSwipeControllerDataSource {
    func viewControllerData() -> [UIViewController]
    optional func indexOfStartingPage() -> Int // Defaults is 0
    optional func titlesForPages() -> [String]
    optional func navigationBarDataForPageIndex(index: Int) -> UINavigationBar
    optional func disableSwipingForLeftButtonAtPageIndex(index: Int) -> Bool
    optional func disableSwipingForRightButtonAtPageIndex(index: Int) -> Bool
    optional func clickedLeftButtonFromPageIndex(index: Int)
    optional func clickedRightButtonFromPageIndex(index: Int)
    optional func changedToPageIndex(index: Int)
}

public class EZSwipeController: UIViewController {

    public struct Constants {
        public static var Orientation: UIInterfaceOrientation {
            return UIApplication.sharedApplication().statusBarOrientation
        }
        public static var ScreenWidth: CGFloat {
            if UIInterfaceOrientationIsPortrait(Orientation) {
                return UIScreen.mainScreen().bounds.width
            } else {
                return UIScreen.mainScreen().bounds.height
            }
        }
        public static var ScreenHeight: CGFloat {
            if UIInterfaceOrientationIsPortrait(Orientation) {
                return UIScreen.mainScreen().bounds.height
            } else {
                return UIScreen.mainScreen().bounds.width
            }
        }
        public static var StatusBarHeight: CGFloat {
            return UIApplication.sharedApplication().statusBarFrame.height
        }
        public static var ScreenHeightWithoutStatusBar: CGFloat {
            if UIInterfaceOrientationIsPortrait(Orientation) {
                return UIScreen.mainScreen().bounds.height - StatusBarHeight
            } else {
                return UIScreen.mainScreen().bounds.width - StatusBarHeight
            }
        }
        public static let navigationBarHeight: CGFloat = 44
        public static let lightGrayColor = UIColor(red: 248, green: 248, blue: 248, alpha: 1)
    }

    public var stackNavBars = [UINavigationBar]()
    public var stackVC: [UIViewController]!
    public var stackPageVC: [UIViewController]!
    public var stackStartLocation: Int!

    public var bottomNavigationHeight: CGFloat = 44
    public var pageViewController: UIPageViewController!
    public var titleButton: UIButton?
    public var currentStackVC: UIViewController!
    public var currentVCIndex: Int {
        return stackPageVC.indexOf(currentStackVC)!
    }
    public var datasource: EZSwipeControllerDataSource?

    public var navigationBarShouldBeOnBottom = false
    public var navigationBarShouldNotExist = false
    public var cancelStandardButtonEvents = false

    public init() {
        super.init(nibName: nil, bundle: nil)
        setupView()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    private func setupDefaultNavigationBars(pageTitles: [String]) {
        guard !navigationBarShouldNotExist else { return }

        var navBars = [UINavigationBar]()
        pageTitles.forEach { title in
            let navigationBarSize = CGSize(width: Constants.ScreenWidth, height: Constants.navigationBarHeight)
            let navigationBar = UINavigationBar(frame: CGRect(origin: CGPoint.zero, size: navigationBarSize))
            navigationBar.barStyle = .Default
            navigationBar.barTintColor = Constants.lightGrayColor

            let navigationItem = UINavigationItem(title: title)
            navigationItem.hidesBackButton = true
            navigationItem.leftBarButtonItem = nil
            navigationItem.rightBarButtonItem = nil

            navigationBar.pushNavigationItem(navigationItem, animated: false)
            navBars.append(navigationBar)
        }
        stackNavBars = navBars
    }

    private func setupNavigationBar() {
        guard stackNavBars.isEmpty else { return }
        guard !navigationBarShouldNotExist else { return }

        guard let _ = datasource?.navigationBarDataForPageIndex?(0) else {
            if let titles = datasource?.titlesForPages?() {
                setupDefaultNavigationBars(titles)
            }
            return
        }

        for index in 0..<stackVC.count {
            let navigationBar = datasource?.navigationBarDataForPageIndex?(index)

            if let nav = navigationBar {
                if navigationBarShouldBeOnBottom {
                    nav.frame = CGRect(x: 0, y: Constants.ScreenHeightWithoutStatusBar - Constants.navigationBarHeight, width: Constants.ScreenWidth, height: Constants.navigationBarHeight)
                } else {
                    nav.frame = CGRect(x: 0, y: 0, width: Constants.ScreenWidth, height: Constants.navigationBarHeight)
                }
                
                if let items = nav.items where !cancelStandardButtonEvents {
                    items.forEach { item in
                        if let leftButton = item.leftBarButtonItem {
                            leftButton.target = self
                            leftButton.action = #selector(leftButtonAction)
                        }
                        if let rightButton = item.rightBarButtonItem {
                            rightButton.target = self
                            rightButton.action = #selector(rightButtonAction)
                        }
                    }
                }
                stackNavBars.append(nav)
            }
        }
    }

    private func setupViewControllers() {
        stackPageVC = [UIViewController]()
        stackVC.enumerate().forEach { index, viewController in
            let pageViewController = UIViewController()
            if !navigationBarShouldBeOnBottom && !navigationBarShouldNotExist {
                viewController.view.frame.origin.y += Constants.navigationBarHeight
            }
            pageViewController.addChildViewController(viewController)
            pageViewController.view.addSubview(viewController.view)
            viewController.didMoveToParentViewController(pageViewController)
            if !stackNavBars.isEmpty {
                pageViewController.view.addSubview(stackNavBars[index])
            }
            stackPageVC.append(pageViewController)
        }
        
        currentStackVC = stackPageVC[stackStartLocation]
    }

    private func setupPageViewController() {
        pageViewController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        pageViewController.dataSource = self
        pageViewController.delegate = self
        pageViewController.setViewControllers([stackPageVC[stackStartLocation]], direction: .Forward, animated: true, completion: nil)
        var pageViewControllerY: CGFloat = 0
        var pageViewControllerH: CGFloat = 0
        if navigationBarShouldNotExist {
            pageViewControllerY = 0
            pageViewControllerH = Constants.ScreenHeight
        } else {
            pageViewControllerY = Constants.StatusBarHeight
            pageViewControllerH = Constants.ScreenHeightWithoutStatusBar
        }
        pageViewController.view.frame = CGRect(x: 0, y: pageViewControllerY, width: Constants.ScreenWidth, height: pageViewControllerH)
        pageViewController.view.backgroundColor = UIColor.clearColor()
        addChildViewController(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMoveToParentViewController(self)
    }

    public func setupView() {

    }

    override public func loadView() {
        super.loadView()
        stackVC = datasource?.viewControllerData()
        stackStartLocation = datasource?.indexOfStartingPage?() ?? 0
        guard stackVC != nil else {
            print("Problem: EZSwipeController needs ViewController Data, please implement EZSwipeControllerDataSource")
            return
        }
        setupNavigationBar()
        setupViewControllers()
        setupPageViewController()
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
    }

    @objc public func leftButtonAction() {
        let currentIndex = stackPageVC.indexOf(currentStackVC)!
        datasource?.clickedLeftButtonFromPageIndex?(currentIndex)

        let shouldDisableSwipe = datasource?.disableSwipingForLeftButtonAtPageIndex?(currentIndex) ?? false
        if shouldDisableSwipe {
            return
        }

        if currentStackVC == stackPageVC.first {
            return
        }
        
        let newVCIndex = currentIndex - 1
        datasource?.changedToPageIndex?(newVCIndex)
        currentStackVC = stackPageVC[newVCIndex]
        pageViewController.setViewControllers([currentStackVC], direction: UIPageViewControllerNavigationDirection.Reverse, animated: true, completion: nil)
    }

    @objc public func rightButtonAction() {
        let currentIndex = stackPageVC.indexOf(currentStackVC)!
        datasource?.clickedRightButtonFromPageIndex?(currentIndex)

        let shouldDisableSwipe = datasource?.disableSwipingForRightButtonAtPageIndex?(currentIndex) ?? false
        if shouldDisableSwipe {
            return
        }

        if currentStackVC == stackPageVC.last {
            return
        }
        
        let newVCIndex = currentIndex + 1
        datasource?.changedToPageIndex?(newVCIndex)

        currentStackVC = stackPageVC[newVCIndex]
        pageViewController.setViewControllers([currentStackVC], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
    }
    
    public func moveToPage(index: Int) {
        let currentIndex = stackPageVC.indexOf(currentStackVC)!
        
        var direction: UIPageViewControllerNavigationDirection = .Reverse
        
        if index > currentIndex {
            direction = .Forward
        }
        
        datasource?.changedToPageIndex?(index)
        currentStackVC = stackPageVC[index]
        
        pageViewController.setViewControllers([currentStackVC], direction: direction, animated: true, completion: nil)
    }
}

extension EZSwipeController: UIPageViewControllerDataSource {

    public func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        if viewController == stackPageVC.first {
            return nil
        }
        return stackPageVC[stackPageVC.indexOf(viewController)! - 1]
    }

    public func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        if viewController == stackPageVC.last {
            return nil
        }
        return stackPageVC[stackPageVC.indexOf(viewController)! + 1]
    }
}

extension EZSwipeController: UIPageViewControllerDelegate {

    public func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if !completed {
            return
        }
        
        let newVCIndex = stackPageVC.indexOf(pageViewController.viewControllers!.first!)!
        
        datasource?.changedToPageIndex?(newVCIndex)
        
        currentStackVC = stackPageVC[newVCIndex]
    }
}

