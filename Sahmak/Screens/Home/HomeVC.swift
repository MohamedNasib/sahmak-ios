//
//  HomeVC.swift
//  Sahmak
//
//  Created by mac on 11/05/2023.
//

import UIKit
import PieCharts
import Toaster

class HomeVC: TableViewController {
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var imgUserPictuer: UIImageView!
    
    @IBOutlet weak var txtSearch: UITextField!

    var totalBalance: TotalBalanceDetails?
    var hotPropertiesArray: [HotPropertiesDetails]?
    var yourPropertiesArray: [YourPropertiesDetails]?
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        getHomeData()
        NotificationCenter.default.addObserver(self, selector: #selector(fetchUserData), name: Notification.Name("UserDataUpdated"), object: nil)
    }
    
    @objc func fetchUserData() {
        // Call your API to fetch the updated user data
        getHomeData()
    }
    
    deinit {
            NotificationCenter.default.removeObserver(self, name: Notification.Name("UserDataUpdated"), object: nil)
        }
    
    @IBAction func filterBtn(_ sender : UIButton){
        presentFull(FilterVC.loadFromNib(), animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath.row) {
        case 0 :
            guard let cellPieChartsTVC = tableView.dequeueReusableCell(withIdentifier: "PieChartsTVC", for: indexPath) as? PieChartsTVC else { return UITableViewCell() }
            cellPieChartsTVC.configurPieChartsTVC(totalBalance: self.totalBalance)
            return cellPieChartsTVC
        case 1 :
            guard let cellHomeTutorialTVC = tableView.dequeueReusableCell(withIdentifier: "HomeTutorialTVC", for: indexPath) as? HomeTutorialTVC else { return UITableViewCell() }
            cellHomeTutorialTVC.configurHomeTutorialTVC()
            return cellHomeTutorialTVC
        case 2 :
            guard let cellCategoriesTVC = tableView.dequeueReusableCell(withIdentifier: "CategoriesTVC", for: indexPath) as? CategoriesTVC else { return UITableViewCell() }
            cellCategoriesTVC.categoryCellRegister()
            return cellCategoriesTVC
        case 3 :
            guard let cellYourPropertiesTVC = tableView.dequeueReusableCell(withIdentifier: "YourPropertiesTVC", for: indexPath) as? YourPropertiesTVC else { return UITableViewCell() }
            cellYourPropertiesTVC.yourPropertiesCellConfigur(yourPropertiesArray: self.yourPropertiesArray ?? [])
            return cellYourPropertiesTVC
        case 4 :
            guard let cellHotPropertiesTVC = tableView.dequeueReusableCell(withIdentifier: "HotPropertiesTVC", for: indexPath) as? HotPropertiesTVC else { return UITableViewCell() }
            cellHotPropertiesTVC.hotPropertiesCellConfigur(hotPropertiesArray: self.hotPropertiesArray ?? [])
            cellHotPropertiesTVC.context = self
            return cellHotPropertiesTVC
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == 3 && yourPropertiesArray?.count == 0) ||
            (indexPath.row == 1 && K_Defaults.bool(forKey: Saved.TUTORIAL_SKIPPED)) ||
            (indexPath.row == 4 && hotPropertiesArray?.count == 0) {
            return 0
        } else {
            return UITableView.automaticDimension
        }
    }
    
}

extension HomeVC{
    
    func getHomeData() {
        K_Network.sendRequest(function: apiService.home, success: { (code, msg, response)  in
            do {
                let response = try response.map(to: HomeResponse.self, keyPath: nil)
                if response.code == 200 {
                    K_Defaults.set(response.data?.profilePicture?.url, forKey: Saved.USER_PHOTO)
                    K_Defaults.set(response.data?.userName, forKey: Saved.USER_NAME)
                    self.lblUserName.text = "\("hello".localized()), \(response.data?.userName ?? "")"
                    self.loadImage(stringUrl: response.data?.profilePicture?.url ?? "", placeHolder: UIImage(named: "male"), imgView: self.imgUserPictuer)
                    self.totalBalance = response.data?.totalBalance
                    self.hotPropertiesArray = response.data?.hotProperties
                    self.yourPropertiesArray = response.data?.yourProperties
                    self.tableView.reloadData()
                }else{
                    
                }
            } catch {
            }
        }) { (code, msg, errors) in
            Toast(text: msg).show()
        }
    }
}
