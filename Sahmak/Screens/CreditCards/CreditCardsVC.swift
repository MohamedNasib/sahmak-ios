//
//  CreditCardsVC.swift
//  Sahmak
//
//  Created by mac on 13/04/2023.
//

import UIKit
import Toaster
import AcceptSDK

class CreditCardsVC: TableViewController {
    
    @IBOutlet weak var noDataView: UIView!
    
    var cardsArray : [CreditCards] = []
    let accept = AcceptSDK()
    var paymentData : PaymentData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllCards(params: GetCardInput(page: "\(1)"))
        accept.delegate = self
        
        accept.customization?.buttonText = "Add Card"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        hiddenAndAppearViews()
    }
    
    func hiddenAndAppearViews(){
        if cardsArray.isEmpty {
            noDataView.isHidden = false
        }else {
            noDataView.isHidden = true
            tableView.isHidden = false
        }
    }
    
    
    @IBAction func addCard(_ sender : UIButton){
        //        self.firstPayment()
        Toast(text: "Payment integration not implemented yet").show()
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == cardsArray.count {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddCardTVC", for: indexPath) as! AddCardTVC
            
            cell.addCardAction = { [weak self] in
                self?.firstPayment()
            }
            
            return cell
            
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CreditTVC", for: indexPath) as? CreditTVC else { return UITableViewCell() }
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardsArray.count + 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == cardsArray.count {
            self.firstPayment()
        }
    }
    
}

extension CreditCardsVC: AcceptSDKDelegate{
    func userDidCancel() {
        print("User Did Cancel")
    }
    
    func paymentAttemptFailed(_ error: AcceptSDKError, detailedDescription: String) {
        print("Payment Failed")
        print(error)
        print(detailedDescription)
    }
    
    func transactionRejected(_ payData: PayResponse) {
        print("Transaction Rejected")
        print(payData)
        
    }
    
    func transactionAccepted(_ payData: PayResponse) {
        print("Transaction Accepted")
        print(payData)
    }
    
    func transactionAccepted(_ payData: PayResponse, savedCardData: SaveCardResponse) {
        print("Transaction Accepted with saved Card")
        print(payData)
        print(savedCardData)
        
        addCard(params: AddCardInput(creditCardNumber: savedCardData.masked_pan.getLast4Digits() ?? 0, cardId: paymentData?.cardId ?? "", payMobOrderId: paymentData?.payMobOrderId ?? 0, cardType: savedCardData.card_subtype, cardToken: savedCardData.token))
    }
    
    func userDidCancel3dSecurePayment(_ pendingPayData: PayResponse) {
        print("User Cancelled 3D Secure Payment")
        
    }
}

extension CreditCardsVC {
    
    func getAllCards(params: GetCardInput) {
        K_Network.sendRequest(function: apiService.getCards(params: params), success: { (code, msg, response)  in
            do {
                var response  = try response.map(to: Card.self, keyPath: nil)
                
                if response.code == 200 {
                    response.data?.creditCards = self.cardsArray
                    print(response)
                    self.hiddenAndAppearViews()
                }else{
                    print("message" , "\(response.message)")
                }
                self.tableView.reloadData()
            } catch {
                
            }
        }) { (code, msg, errors) in
            Toast(text: msg).show()
        }
    }
    
    func firstPayment() {
        K_Network.sendRequest(function: apiService.firstPayment, success: { (code, msg, response)  in
            do {
                let auth = try response.map(to: PaymentData.self, keyPath: "data")
                self.paymentData = auth
                self.accept.customization?.buttonsColor = AppColorSystem.primary.color
                
                do {
                    let KEY: String = auth.paymentToken
                    try self.accept.presentPayVC(vC: self, paymentKey: KEY, saveCardDefault:
                                                    true, showSaveCard: false, showAlerts: true)
                } catch AcceptSDKError.MissingArgumentError(let errorMessage) {
                    print(errorMessage)
                }  catch let error {
                    print(error.localizedDescription)
                }
                
            } catch {
            }
        }) { (code, msg, errors) in
            Toast(text: msg).show()
        }
    }
    
    func addCard(params: AddCardInput) {
        K_Network.sendRequest(function: apiService.addCard(params: params), success: { (code, msg, response)  in
            do {
                print(code, msg, response)
                self.tableView.reloadData()
            } catch {
                print(code, msg, response)
            }
        }) { (code, msg, errors) in
            Toast(text: msg).show()
            print(code, msg)
        }
    }
    
    func deleteCard(params: DeleteCardInput) {
        K_Network.sendRequest(function: apiService.deleteCard(params: params), success: { (code, msg, response)  in
            do {
                self.tableView.reloadData()
            } catch {
                
            }
        }) { (code, msg, errors) in
            Toast(text: msg).show()
        }
    }
    
}
