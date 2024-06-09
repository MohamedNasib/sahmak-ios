//
//  MarketVC.swift
//  Sahmak
//
//  Created by mac on 12/04/2023.
//

import UIKit

class MarketVC: TableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TopMarketTVC", for: indexPath) as? TopMarketTVC else { return UITableViewCell() }
            cell.model = ""
            return cell
        }
        else
        {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "BottomMarketTVC", for: indexPath) as? BottomMarketTVC else { return UITableViewCell() }
            cell.model = ""
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    
    

}
