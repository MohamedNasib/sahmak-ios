//
//  SearchVC.swift
//  Sahmak
//
//  Created by mac on 25/05/2023.
//

import UIKit
import Toaster

protocol SecondViewControllerDelegate: AnyObject {
    func didFinishTaskWithData(_ params: PrpertyFilterInput)
}

class SearchVC: TableViewController, SecondViewControllerDelegate {

    @IBOutlet weak var noDataview: UIView!
    @IBOutlet weak var lblResultCount: UILabel!
    var params: PrpertyFilterInput?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        noDataview.isHidden = !array.isEmpty
        tableView.isHidden = array.isEmpty
        lblResultCount.text = "\(array.count) \("resulte".localized())"
        
        if let params = params {
            getPropertyFillter(params: params)
        }
    }
    
    func didFinishTaskWithData(_ params: PrpertyFilterInput) {
        reset()
        self.params = params
        getPropertyFillter(params: params)
    }
    
    override func getNextPage(for page: Int) {
        params?.page = page
        guard let params else {
            return
        }
        getPropertyFillter(params: params)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RealStateTVC", for: indexPath) as? RealStateTVC else { return UITableViewCell() }
        cell.hotProperty = array[indexPath.row] as? HotPropertiesDetails
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = HotPropertyDetailsVC.loadFromNib()
        vc.property_id = (array[indexPath.row] as? HotPropertiesDetails)?._id ?? ""
        vc.modalPresentationStyle = .fullScreen
        self.present(vc , animated: true)
    }
    
    @IBAction func btnFillterPressed(_ sender: Any) {
        let vc = FilterVC.loadFromNib()
        vc.delegate = self
        vc.modalPresentationStyle = .fullScreen
        self.present(vc , animated: true)
    }
}

extension SearchVC {
    func getPropertyFillter(params: PrpertyFilterInput) {
        K_Network.sendRequest(function: apiService.propertyFilter(params: params), success: { (code, msg, response)  in
            do {
                let response = try response.map(to: HotPropertiesDetailsResponse.self, keyPath: nil)
                if self.array.isEmpty {
                    self.array = response.data?.properties ?? []
                } else {
                    self.array.append(contentsOf: response.data?.properties ?? [])
                }
                self.tableView.hasMore = response.data?.count == self.params?.page
                self.tableView.reloadData()
                self.noDataview.isHidden = !self.array.isEmpty
                self.tableView.isHidden = self.array.isEmpty
                self.lblResultCount.text = "\(self.array.count) \("resulte".localized())"
            } catch {
            }
        }) { (code, msg, errors) in
            Toast(text: msg).show()
        }
    }
}
