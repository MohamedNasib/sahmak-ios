//
//  DraggableViewController.swift
//  Plstka
//
//  Created by FAB LAB on 13/03/2021.
//

import UIKit
import PagedLists

class TableViewController: ParentViewController, PagedTableViewDelegate, UITableViewDataSource, UITableViewDelegate  {
    
    @IBOutlet weak var tableView: PagedTableView!
    var array:[Any] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
    }
    
    func getNextPage(for page: Int) {
        
    }
    
    
    func configureTableView() {
        tableView.elementsPerPage = pageSize
        tableView.updateDelegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "TopMarketTVC", bundle: nil), forCellReuseIdentifier: "TopMarketTVC")
        tableView.register(UINib(nibName: "BottomMarketTVC", bundle: nil), forCellReuseIdentifier: "BottomMarketTVC")
        tableView.register(UINib(nibName: "TopTVC", bundle: nil), forCellReuseIdentifier: "TopTVC")
        tableView.register(UINib(nibName: "BottomTVC", bundle: nil), forCellReuseIdentifier: "BottomTVC")
        tableView.register(UINib(nibName: "AddCardTVC", bundle: nil), forCellReuseIdentifier: "AddCardTVC")
        tableView.register(UINib(nibName: "CreditTVC", bundle: nil), forCellReuseIdentifier: "CreditTVC")
        tableView.register(UINib(nibName: "FAQCell", bundle: nil), forCellReuseIdentifier: "FAQCell")
        tableView.register(UINib(nibName: "PieChartsTVC", bundle: nil), forCellReuseIdentifier: "PieChartsTVC")
        tableView.register(UINib(nibName: "HomeTutorialTVC", bundle: nil), forCellReuseIdentifier: "HomeTutorialTVC")
        tableView.register(UINib(nibName: "CategoriesTVC", bundle: nil), forCellReuseIdentifier: "CategoriesTVC")
        tableView.register(UINib(nibName: "YourPropertiesTVC", bundle: nil), forCellReuseIdentifier: "YourPropertiesTVC")
        tableView.register(UINib(nibName: "HotPropertiesTVC", bundle: nil), forCellReuseIdentifier: "HotPropertiesTVC")
        tableView.register(UINib(nibName: "RealStateTVC", bundle: nil), forCellReuseIdentifier: "RealStateTVC")
    }
    
    func reset() {
        array.removeAll()
        tableView.reloadData()
        tableView.reset()
    }
}

extension TableViewController {
    func tableView(_ tableView: PagedTableView, needsDataForPage page: Int, completion: (Int, NSError?) -> Void) {
        // Typically request your data over network, update your data source and refresh UI
        completion(tableView.elementsPerPage, nil)
        // request here
        if tableView.hasMore {
            getNextPage(for: page)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView === tableView {
            tableView.scrollViewDidScroll(tableView)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
