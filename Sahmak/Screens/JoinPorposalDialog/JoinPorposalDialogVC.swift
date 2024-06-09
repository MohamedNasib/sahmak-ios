//
//  JoinPorposalDialogVC.swift
//  Sahmak
//
//  Created by mac on 06/07/2023.
//

import UIKit
import Toaster

class JoinPorposalDialogVC: ParentViewController {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var viewTop: UIView!
    
    @IBOutlet weak var viewConfirmProposal: UIView!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var txtPay: UITextField!
    @IBOutlet weak var lblRequierdDeposit: UILabel!

    @IBOutlet weak var viewNotCompletedProfille: UIView!
    
    @IBOutlet weak var btnConfirm: UIButton!
    
    
    var confirmProposalParams: ConfirmProposalParams?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        viewTop.onTap(action: {
            self.dismiss(animated: true , completion: nil)
        })
        
    }
    
    func setupUI(){
        viewNotCompletedProfille.isHidden = K_Defaults.bool(forKey: Saved.IS_VERIFIED)
        viewConfirmProposal.isHidden = !K_Defaults.bool(forKey: Saved.IS_VERIFIED)
        lblPrice.text = "\(confirmProposalParams?.price ?? 0) \("EGP".localized())"
//        txtPay.text =
        lblRequierdDeposit.text = "\("require_deposit_range".localized()) \(confirmProposalParams?.deposit ?? 0) \("EGP".localized())"
        
        if K_Defaults.bool(forKey: Saved.IS_VERIFIED) == false {
            btnConfirm.setTitle("Complete_your_profile".localized(), for: .normal)
            lblTitle.text = "Complete_your_profile".localized()
        }else{
            btnConfirm.setTitle("Confirm_Proposal".localized(), for: .normal)
            lblTitle.text = "Confirm_Proposal".localized()
        }
    }
    
    @IBAction func btnConfirmPressed(_ sender: Any) {
        if K_Defaults.bool(forKey: Saved.IS_VERIFIED) == false {
            let vc = EditProfileVC.loadFromNib()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc , animated: true)
        }else{
            sendProposal()
        }
    }
}

extension JoinPorposalDialogVC {
    
    func sendProposal(){
        K_Network.sendRequest(function: apiService.sendProposal(id: confirmProposalParams?.property_id ?? "", params: SendProposalInput(deposit: 1000, totalInvestmentMoney: 1000)), success: { (code, msg, response)  in
            do {
                let response = try response.map(to: HomeResponse.self, keyPath: nil)
                if response.code == 200 {
                    Toast(text: response.message).show()
                    self.dismiss(animated: true , completion: nil)
                }else {
                    Toast(text: response.message).show()
                }
            }
            catch {
            }
        }) { (code, msg, errors) in
            Toast(text: msg).show()
        }
    }
    
}
