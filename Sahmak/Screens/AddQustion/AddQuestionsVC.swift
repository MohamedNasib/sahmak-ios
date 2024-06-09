//
//  AddQuestionsVC.swift
//  Sahmak
//
//  Created by mac on 15/04/2023.
//

import UIKit
import Toaster

class AddQuestionsVC: UIViewController {
    
    @IBOutlet weak var question : UITextField!
    @IBOutlet weak var dismissView : UIView!
    
    var vc: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dismissView.onTap(action: {
            self.dismiss(animated: true , completion: nil)
        })
    }
    
    @IBAction func askQuestion(_ sender : UIButton){
        askQuestionAPI(params: AskQuestionInput(englishQuestion: question.text ?? ""))
    }
}

extension AddQuestionsVC {
    
    func askQuestionAPI(params: AskQuestionInput) {
        K_Network.sendRequest(function: apiService.askQuestion(params: params), success: { (code, msg, response)  in
            do {
                let auth = try response.map(to: LogoutOutput.self)
                Toast(text: auth.message).show()
                self.dismiss(animated: true)
            } catch {
            }
        }) { (code, msg, errors) in
            Toast(text: msg).show()
        }
    }
}
