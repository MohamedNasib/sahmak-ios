//
//  BottomMarketTVC.swift
//  Sahmak
//
//  Created by mac on 12/04/2023.
//

import UIKit

class BottomMarketTVC: UITableViewCell, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var model: String? {
        didSet{
            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(UINib(nibName: "BottomTVC", bundle: nil), forCellReuseIdentifier: "BottomTVC")
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BottomTVC", for: indexPath) as? BottomTVC else { return UITableViewCell() }
        return cell
    }
    
    
    
    @IBAction func btnViewAllPressed(_ sender: Any) {
    }
    
}
