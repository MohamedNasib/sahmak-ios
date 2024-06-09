//
//  FAQsVC.swift
//  Sahmak
//
//  Created by mac on 15/04/2023.
//

import UIKit
import Toaster

class FAQsVC: TableViewController {
    
    var faqsList:[FAQDataDetails] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        faq(params: FAQInput(page: 1, filter:""))
    }
    
    @IBAction func askQuestion(_ sender : UIButton){
        let vc = AddQuestionsVC.loadFromNib()
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return faqsList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FAQCell", for: indexPath) as? FAQCell else { return UITableViewCell() }
        cell.faqDataDetails = faqsList[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        faqsList[indexPath.row].isCollapsed = !faqsList[indexPath.row].isCollapsed
        self.tableView.reloadData()
    }
}

extension FAQsVC {
    
    func faq(params: FAQInput) {
        K_Network.sendRequest(function: apiService.faq(params: params), success: { (code, msg, response)  in
            do {
                let response = try response.map(to: GetListFAQSResponse.self, keyPath: nil)
                
                if response.code == 200 {
                    self.faqsList = response.data
                    self.tableView.reloadData()
                }else {
                    Toast(text: response.message).show()
                }
                
            } catch {
            }
        }) { (code, msg, errors) in
            Toast(text: msg).show()
        }
    }
    
}
