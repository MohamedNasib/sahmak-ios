//
//  RegisterVC.swift
//  Sahmak
//
//  Created by mac on 13/05/2023.
//

import UIKit
import SKCountryPicker
import Mantis
import Toaster
import Nuke
import SwiftValidator

class RegisterVC: ParentViewController, UITextFieldDelegate, ValidationDelegate {
    
    @IBOutlet weak var imgUserImage: UIImageView!
    @IBOutlet weak var viewEditUserImage: UIView!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtBirthDate: UITextField!
    @IBOutlet weak var txtCountry: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtIDNumber: UITextField!
    @IBOutlet weak var txtIdFrontImage: UITextField!
    @IBOutlet weak var txtIdBackImage: UITextField!
    @IBOutlet weak var btnMale: UIButton!
    @IBOutlet weak var btnFemale: UIButton!
    
    @IBOutlet weak var btnUploadFrontID: UIButton!
    @IBOutlet weak var btnUploadBackID: UIButton!
    
    var frontIDPhoto : UIImageView?
    var backIDPhoto : UIImageView?
    
    var userImageData : FileInput?
    var frontIDData : FileInput?
    var backIDData : FileInput?
    var gender : String?
    
    var countryCode = ""
    var governorates:[Governorate] = []
    var selectedCountry : Int?
    var presenter_doc: Data? = nil
    var pickerSelectionType: PickerSelectionType? = .userImage
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        governorate()
        createDatePicker()
        viewEditUserImage.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.viewEditUserImagePressed(_:))))
        txtBirthDate.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.viewBirthDatePressed(_:))))
        txtCountry.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.viewCountryPressed(_:))))
        txtCity.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.viewCityPressed(_:))))
        
        txtBirthDate.delegate = self
        txtIdFrontImage.delegate = self
        txtIdFrontImage.delegate = self

        
        
        
//        if let userType = K_Defaults.string(forKey: Saved.account_type), userType == AccountType.User.rawValue {
//            btnAddDelegation.isHidden = true
//        }
//        getCities()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            return false
        }
    
    
    private func createDatePicker(){
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(datePicker:)), for: .valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 300)
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.maximumDate = Date()
        txtBirthDate.inputView = datePicker

        // Create a toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()

        // Create a "Done" button
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))

        // Add the "Done" button to the toolbar
        toolbar.setItems([doneButton], animated: false)

        // Set the toolbar as the input accessory view of the text field
        txtBirthDate.inputAccessoryView = toolbar
        
    }
    
    @objc func viewEditUserImagePressed(_ sender: UITapGestureRecognizer) {
        ImagePicker.shared.pickImage(viewController: self, completion: { image in
            if let image = image {
                let cropViewController = Mantis.cropViewController(image: image)
                cropViewController.delegate = self
                cropViewController.modalPresentationStyle = .fullScreen
                self.present(cropViewController, animated: true)
                self.pickerSelectionType = .userImage
            }
        })
    }
    
    @objc func viewBirthDatePressed(_ sender: UITapGestureRecognizer) {

//            self?.lblCountryCode.text = country.dialingCode
//            self?.imgCountryLogo.image = country.flag
        
        
        
    }
    
    @objc func datePickerValueChanged(datePicker: UIDatePicker) {
        
        // Do something with the selected date
        txtBirthDate.text = datePicker.date.datePickerFormat()
    }
    
    @objc func doneButtonTapped() {
        txtBirthDate.resignFirstResponder() // Dismiss the date picker
    }
    
    
    @objc func viewCountryPressed(_ sender: UITapGestureRecognizer) {
        DropDown(vc: self, array: governorates.map({ $0.englishName })).show(selecteditem: [txtCountry.text ?? ""], showSearchBar: false, didSelect: { (text, selected, selectedItems) in
            self.txtCountry.text = text
            self.selectedCountry = self.governorates.map({ $0.englishName }).firstIndex(of: text ?? "") ?? 0
            
        })
        
    }
    

    @objc func viewCityPressed(_ sender: UITapGestureRecognizer) {
        
        if selectedCountry != nil {
            DropDown(vc: self, array: governorates[selectedCountry!].areas.map({ $0.englishName })).show(selecteditem: [txtCity.text ?? ""], showSearchBar: false, didSelect: { (text, selected, selectedItems) in
                self.txtCity.text = text
                self.selectedCountry = self.governorates[self.selectedCountry!].areas.map({ $0.englishName }).firstIndex(of: text ?? "") ?? 0
                
            })
        }
        

    }
    
    func extractImageName(from image: UIImage) -> String? {
        guard let imageData = image.pngData() else {
            return nil
        }
        
        let fileName = "selectedImage.png"
        let imageURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
        
        do {
            try imageData.write(to: imageURL)
            return imageURL.lastPathComponent
        } catch {
            print("Error writing image data: \(error)")
            return nil
        }
    }
    
    override func cropViewControllerDidCrop(_ cropViewController: CropViewController, cropped: UIImage, transformation: Transformation, cropInfo: CropInfo) {
        cropViewController.dismiss(animated: true, completion: nil)
        switch pickerSelectionType {
        case .userImage:
            imgUserImage.image = cropped
        case .frontID:
            if let imageName = extractImageName(from: cropped) {
                txtIdFrontImage.text = imageName
                upload(file: cropped.pngData()!, type: .frontID)
            }
            
//            btnUploadFrontID.setTitle("Change", for: .normal)
        case .backID:
            if let imageName = extractImageName(from: cropped) {
                txtIdBackImage.text = imageName
                upload(file: cropped.pngData()!, type: .backID)
            }
//            btnUploadBackID.setTitle("Change", for: .normal)
        case .none:
            break
        }
    }
    
    @IBAction func btnMalePressed(_ sender: Any) {
        let maleGradientView = btnMale.superview as! GradientView
        let femaleGradientView = btnFemale.superview as! GradientView
        
        maleGradientView.addGradient()
        femaleGradientView.removeGradient()
        
        btnMale.setTitleColor(AppColorSystem.white.color, for: .normal)
        btnFemale.setTitleColor(AppColorSystem.LightGrey.color, for: .normal)
        
        maleGradientView.backgroundColor = UIColor(hexString: "#F2F8FF")
        femaleGradientView.backgroundColor = .clear
        
        femaleGradientView.layer.borderColor = AppColorSystem.Border.color.cgColor
        maleGradientView.layer.borderColor = AppColorSystem.Border.color.cgColor
        
        gender = "Male"
    }
    
    @IBAction func btnFemalePressed(_ sender: Any) {
        let maleGradientView = btnMale.superview as! GradientView
        let femaleGradientView = btnFemale.superview as! GradientView
        
        femaleGradientView.addGradient()
        maleGradientView.removeGradient()
        
        btnFemale.setTitleColor(AppColorSystem.white.color, for: .normal)
        btnMale.setTitleColor(AppColorSystem.LightGrey.color, for: .normal)
        
        femaleGradientView.backgroundColor = UIColor(hexString: "#F2F8FF")
        maleGradientView.backgroundColor = .clear
        
        femaleGradientView.layer.borderColor = AppColorSystem.Border.color.cgColor
        maleGradientView.layer.borderColor = AppColorSystem.Border.color.cgColor
        
        gender = "Female"
    }

    @IBAction func btnUploadFrondIDPressed(_ sender: Any) {
        ImagePicker.shared.pickImage(viewController: self, completion: { image in
            if let image = image {
                let cropViewController = Mantis.cropViewController(image: image)
                cropViewController.delegate = self
                cropViewController.modalPresentationStyle = .fullScreen
                self.present(cropViewController, animated: true)
                self.frontIDPhoto?.image = image
                self.pickerSelectionType = .frontID
            }
        })
    }
    
    @IBAction func btnUploadBackIDPressed(_ sender: Any) {
        ImagePicker.shared.pickImage(viewController: self, completion: { image in
            if let image = image {
                let cropViewController = Mantis.cropViewController(image: image)
                cropViewController.delegate = self
                cropViewController.modalPresentationStyle = .fullScreen
                self.present(cropViewController, animated: true)
                self.backIDPhoto?.image = image
                self.pickerSelectionType = .backID
                
                
            }
        })
    }

    @IBAction func continuePressed(_ sender: Any) {
        normalizeFields()
        
        validator.registerField(txtName, rules: [RequiredRule(message: ""), FullNameRule(message: "")])
        validator.registerField(txtBirthDate, rules: [RequiredRule(message: "")])
        validator.registerField(txtCountry, rules: [RequiredRule(message: "")])
        validator.registerField(txtCity, rules: [RequiredRule(message: "")])
        validator.registerField(txtIDNumber, rules: [RequiredRule(message: "")])
        validator.registerField(txtIdFrontImage, rules: [RequiredRule(message: "")])
        validator.registerField(txtIdBackImage, rules: [RequiredRule(message: "")])
        validator.validate(self)
        if genderValidation() {
            
        }
        
        
        
        self.userImageData = FileInput(url: "", publicId: "", imageName: "")
        
        let registerInput : RegisterInput = RegisterInput(name: txtName.text ?? "", phoneNumber: K_Defaults.string(forKey: Saved.PHONE_NUMBER) ?? "", gender: gender ?? "", area: txtCity.text ?? "", governorate: txtCountry.text ?? "", birthday: txtBirthDate.text ?? "", egyptianIdNumber: txtIDNumber.text ?? "", profilePicture: userImageData!, egyptianIdPhotoFront: frontIDData!, egyptianIdPhotoBack: backIDData!)



        register(params: registerInput)
        
        
        
    }
}



extension RegisterVC {
    
    func governorate() {
        K_Network.sendRequest(function: apiService.governorate, success: { (code, msg, response)  in
            do {
                let auth = try response.map(to: GovernorateResponse.self)
                if auth.code == 200 {
                    self.governorates = auth.data
                }
            } catch {
                print(error)
            }
        }) { (code, msg, errors) in
            Toast(text: msg).show()
            print(errors)
        }
    }
    
    func register(params: RegisterInput) {
        K_Network.sendRequest(function: apiService.register(params: params), success: { (code, msg, response)  in
            do {
                let auth = try response.map(to: User.self, keyPath: "data")
                K_Defaults.set(auth.token, forKey: Saved.TOKEN)
                K_Defaults.set(auth.isVerified, forKey: Saved.IS_VERIFIED)
                // add firebase token
                let token = K_Defaults.string(forKey: Saved.FCM_TOKEN) ?? ""
                let deviceId = K_Defaults.string(forKey: Saved.DEVICE_TOKEN) ?? ""
//                let isVerified = K_Defaults.bool(forKey: Saved.IS_VERIFIED)
                self.addDevice(params: AddDeviceInput(token: token, deviceId: deviceId, type: "IOS"))
                K_Defaults.set(params.phoneNumber, forKey: Saved.PHONE_NUMBER)
            } catch {
            }
        }) { (code, msg, errors) in
            Toast(text: msg).show()
        }
    }
    
    func upload(file: Data, type : PickerSelectionType) {
        K_Network.sendRequest(function: apiService.upload(file: file), success: { (code, msg, response)  in
            do {
                let auth = try response.map(to: FileOutput.self, keyPath: "data")
                switch type {
                case .userImage:
                    self.userImageData = FileInput(url: auth.url, publicId: auth.publicId, imageName: auth.imageName)
                    
                    let registerInput : RegisterInput = RegisterInput(name: self.txtName.text ?? "", phoneNumber: K_Defaults.string(forKey: Saved.PHONE_NUMBER) ?? "", gender: self.gender ?? "", area: self.txtCity.text ?? "", governorate: self.txtCountry.text ?? "", birthday: self.txtBirthDate.text ?? "", egyptianIdNumber: self.txtIDNumber.text ?? "", profilePicture: self.userImageData!, egyptianIdPhotoFront: self.frontIDData!, egyptianIdPhotoBack: self.backIDData!)

                    self.register(params: registerInput)

                    
                case .frontID:
                    self.frontIDData = FileInput(url: auth.url, publicId: auth.publicId, imageName: auth.imageName)
                case .backID:
                    self.backIDData = FileInput(url: auth.url, publicId: auth.publicId, imageName: auth.imageName)
                }
                
            } catch {
            }
        }) { (code, msg, errors) in
            Toast(text: msg).show()
        }
    }
    
}

extension RegisterVC {
    
    func validationSuccessful() {
        if genderValidation() {
            if userImageData != nil {
                upload(file: (imgUserImage.image?.pngData())!, type: .userImage)
            } else {
                let registerInput : RegisterInput = RegisterInput(name: txtName.text ?? "", phoneNumber: K_Defaults.string(forKey: Saved.PHONE_NUMBER) ?? "", gender: gender ?? "", area: txtCity.text ?? "", governorate: txtCountry.text ?? "", birthday: txtBirthDate.text ?? "", egyptianIdNumber: txtIDNumber.text ?? "", profilePicture: userImageData!, egyptianIdPhotoFront: frontIDData!, egyptianIdPhotoBack: backIDData!)

                register(params: registerInput)

            }
        }
    }
    
    func addDevice(params: AddDeviceInput) {
        K_Network.sendRequest(function: apiService.addDevice(params: params), success: { (code, msg, response)  in
            K_AppDelegate.redirectToHome()
        }) { (code, msg, errors) in
            Toast(text: msg).show()
        }
    }
    
    func validationFailed(_ errors:[(Validatable ,ValidationError)]) {
        // turn the fields to red
        for (field, error) in errors {
            (field as? UIView)?.superview?.superview?.layer.borderColor = UIColor.red.cgColor
        }
    }
    
    func normalizeFields() {
        txtName.superview?.superview?.layer.borderColor = AppColorSystem.Border.color.cgColor
        txtBirthDate.superview?.superview?.layer.borderColor = AppColorSystem.Border.color.cgColor
        txtCountry.superview?.superview?.layer.borderColor = AppColorSystem.Border.color.cgColor
        txtCity.superview?.superview?.layer.borderColor = AppColorSystem.Border.color.cgColor
        txtIDNumber.superview?.superview?.layer.borderColor = AppColorSystem.Border.color.cgColor
        txtIdFrontImage.superview?.superview?.layer.borderColor = AppColorSystem.Border.color.cgColor
        txtIdBackImage.superview?.superview?.layer.borderColor = AppColorSystem.Border.color.cgColor
        
    }
    
    func genderValidation() -> Bool{
        if gender == nil {
            
            let femaleGradientView = btnFemale.superview as! GradientView
            femaleGradientView.removeGradient()
            btnFemale.setTitleColor(AppColorSystem.LightGrey.color, for: .normal)
            femaleGradientView.backgroundColor = .clear
            femaleGradientView.layer.borderColor = UIColor.red.cgColor
            
            let maleGradientView = btnMale.superview as! GradientView
            maleGradientView.removeGradient()
            btnMale.setTitleColor(AppColorSystem.LightGrey.color, for: .normal)
            maleGradientView.backgroundColor = .clear
            maleGradientView.layer.borderColor = UIColor.red.cgColor
            
            
            return false
        }
        return true
    }
}

