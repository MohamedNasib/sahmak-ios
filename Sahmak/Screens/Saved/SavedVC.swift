//
//  SavedVC.swift
//  Sahmak
//
//  Created by mac on 01/05/2023.
//

import UIKit
import Toaster

class SavedVC: TableViewController {
    
    @IBOutlet weak var noDataview: UIView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        noDataview.isHidden = !array.isEmpty
        tableView.isHidden = array.isEmpty
        // call api
        getNextPage(for: 1)
    }
    
    override func getNextPage(for page: Int) {
        // call api
        savedproperty(params: SavedPrpertyInput(page: page))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RealStateTVC", for: indexPath) as? RealStateTVC else { return UITableViewCell() }
        cell.property = array[indexPath.row] as? HotPropertiesDetails
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = HotPropertyDetailsVC.loadFromNib()
        vc.property_id = (array[indexPath.row] as? HotPropertiesDetails)?._id ?? ""
        print("property_id" , (array[indexPath.row] as? HotPropertiesDetails)?._id ?? "")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc , animated: true)
    }
}

extension SavedVC {
    func savedproperty(params: SavedPrpertyInput) {
        K_Network.sendRequest(function: apiService.savedproperty(params: params), success: { (code, msg, response)  in
            do {
                let response = try response.map(to: [HotPropertiesDetails].self, keyPath: "data")
                if self.array.isEmpty {
                    self.array = response
                } else {
                    self.array.append(contentsOf: response)
                }
//                self.tableView.hasMore = response.data?.count == self.params?.page ===> (until backend send count) <===
                self.tableView.hasMore = 1 == self.pageSize
                self.tableView.reloadData()
                self.noDataview.isHidden = !self.array.isEmpty
                self.tableView.isHidden = self.array.isEmpty
            } catch {
            }
        }) { (code, msg, errors) in
            Toast(text: msg).show()
        }
    }
}
