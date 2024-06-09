//
//  TutorialVC.swift
//  Sahmak
//
//  Created by mac on 17/05/2023.
//

import UIKit

class TutorialVC: UIPageViewController , UIPageViewControllerDelegate , UIPageViewControllerDataSource {
    
    var arrContainers = [UIViewController]()
    var pageControler = UIPageControl()
//    var btnGotIt = UIButton()
//    var lastPageName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let vc1 = storyboard?.instantiateViewController(identifier: "page1")
        let vc2 = storyboard?.instantiateViewController(identifier: "page2")
        let vc3 = storyboard?.instantiateViewController(identifier: "page3")
        let vc4 = storyboard?.instantiateViewController(identifier: "page4")
        let vc5 = storyboard?.instantiateViewController(identifier: "page5")
        let vc6 = storyboard?.instantiateViewController(identifier: "page6")
        let vc7 = storyboard?.instantiateViewController(identifier: "page7")
        let vc8 = storyboard?.instantiateViewController(identifier: "page8")
        let vc9 = storyboard?.instantiateViewController(identifier: "page9")
        let vc10 = storyboard?.instantiateViewController(identifier: "page10")
        let vc11 = storyboard?.instantiateViewController(identifier: "page11")
        arrContainers.append(vc1!)
        arrContainers.append(vc2!)
        arrContainers.append(vc3!)
        arrContainers.append(vc4!)
        arrContainers.append(vc5!)
        arrContainers.append(vc6!)
        arrContainers.append(vc7!)
        arrContainers.append(vc8!)
        arrContainers.append(vc9!)
        arrContainers.append(vc10!)
        arrContainers.append(vc11!)
        delegate = self
        dataSource = self
        
        if let firstVC = arrContainers.first {
            setViewControllers([firstVC], direction: .forward, animated: true)
        }
        
        addPageControler()
        addGotItBtn()
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = arrContainers.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = currentIndex - 1
        guard previousIndex >= 0 else {
            return nil
        }
        
        return arrContainers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = arrContainers.firstIndex(of: viewController) else {
            return nil
        }
        
        let affterIndex = currentIndex + 1
        guard affterIndex < arrContainers.count else {
            return nil
        }
        
        return arrContainers[affterIndex]
    }
    
    
    func addPageControler(){
        pageControler = UIPageControl(frame: CGRect(x: 0 ,y: UIScreen.main.bounds.minY + 62, width:UIScreen.main.bounds.width, height:50))
        self.pageControler.numberOfPages = arrContainers.count
        self.pageControler.currentPage = 0
        self.pageControler.pageIndicatorTintColor = UIColor(named: "#424242")
        self.pageControler.currentPageIndicatorTintColor = UIColor(named: "Primary")
        self.view.addSubview(pageControler)
    }
    
    func addGotItBtn(){
        var btnGotIt = UIButton(frame: CGRect(x: UIScreen.main.bounds.maxX, y: UIScreen.main.bounds.minY + 60, width: -60, height: 50))
        btnGotIt.setTitle("Got It".localized(), for: .normal)
        btnGotIt.tintColor = UIColor(named: "#424242")
        btnGotIt.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(btnGotIt)
    }
    
    @objc func buttonAction(sender: UIButton!) {
//        pageControler.currentPage = pageControler.currentPage + 1
//        goToNextPage()
//        if lastPageName == "vrk-cZ-bDC-view-huJ-V7-Dh0" {
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let vc = storyboard.instantiateViewController(withIdentifier: "tabController")
//            vc.modalPresentationStyle = .fullScreen
//            self.present(vc, animated: true, completion: nil)
//        }
//        if (pageControler.currentPage + 1) == arrContainers.count {
//            lastPageName = "vrk-cZ-bDC-view-huJ-V7-Dh0"
//        }
        dismiss(animated: true)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let page = pageViewController.viewControllers![0]
        self.pageControler.currentPage = arrContainers.firstIndex(of: page)!
//        lastPageName = pageViewController.viewControllers![0].nibName ?? ""
    }
}
