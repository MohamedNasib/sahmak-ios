//
//  EditProfileVC.swift
//  Sahmak
//
//  Created by Abdurrahman Alboghdady on 25/04/2023.
//

import UIKit
import SKCountryPicker
import Mantis
import Toaster
import Nuke
import SwiftValidator

enum PickerSelectionType {
    case userImage
    case frontID
    case backID
}

class EditProfileVC: ParentViewController, UITextFieldDelegate, ValidationDelegate {
        
    
    @IBOutlet weak var imgUserImage: UIImageView!
    @IBOutlet weak var viewEditUserImage: UIView!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtBirthDate: UITextField!
    @IBOutlet weak var txtCountry: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtIDNumber: UITextField!
    @IBOutlet weak var btnMale: UIButton!
    @IBOutlet weak var btnFemale: UIButton!
    @IBOutlet weak var gradientSwitch: GradientSwitch!
    
    @IBOutlet weak var lblPreferPrivte: UILabel!
    @IBOutlet weak var lblRequestToDelete: UILabel!
    
    var gender : String?
    

    var countryCode = ""
    var presenter_doc: Data? = nil
    var pickerSelectionType: PickerSelectionType? = .userImage
    var governorates:[Governorate] = []
    var selectedCountry : Int?
    var isRadioButtonSelected = true
    var defaultProfilePicture : FileOutput?
    var selectedGovernrate = ""
    var selectedCity = ""
    var imageChanged = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        governorate()
        createDatePicker()
        getprofile()
        
        viewEditUserImage.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.viewEditUserImagePressed(_:))))
        txtBirthDate.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.viewBirthDatePressed(_:))))
        txtCountry.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.viewCountryPressed(_:))))
        txtCity.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.viewCityPressed(_:))))
        
        gradientSwitch.addTarget(self, action: #selector(radioButtonTapped), for: .touchUpInside)

        txtBirthDate.delegate = self

//        if let userType = K_Defaults.string(forKey: Saved.account_type), userType == AccountType.User.rawValue {
//            btnAddDelegation.isHidden = true
//        }
        
        let isAr = K_Defaults.string(forKey: Saved.LANGUAGE) == "ar"
        if isAr {
            lblPreferPrivte.textAlignment = isAr ? .right : .left
            lblRequestToDelete.textAlignment = isAr ? .right : .left
        }
        
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
    
    @objc func radioButtonTapped() {
            // Update the state of the radio button
            isRadioButtonSelected = !isRadioButtonSelected
            
            // Perform any additional actions based on the radio button's state
            if isRadioButtonSelected {
                print("Radio button is selected")
            } else {
                print("Radio button is not selected")
            }
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
//        CountryPickerWithSectionViewController.presentController(on: self) { [weak self] (country: SKCountryPicker.Country) in
//
////            self?.lblCountryCode.text = country.dialingCode
////            self?.imgCountryLogo.image = country.flag
//            self?.countryCode = country.countryCode
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
            // If a different country is selected
            if self.txtCountry.text != text {
                // Set the country text
                self.txtCountry.text = text
                // Get the index of the selected country
                self.selectedCountry = self.governorates.map({ $0.englishName }).firstIndex(of: text ?? "") ?? 0
                self.selectedGovernrate = self.governorates[self.selectedCountry!].id
                // Reset city related values
                self.txtCity.text = nil
                self.selectedCity = ""
            }
            // else: Do nothing as the user selected the same old value
        })
    }

    @objc func viewCityPressed(_ sender: UITapGestureRecognizer) {
        if let countryIndex = selectedCountry {
            let cityNames = governorates[countryIndex].areas.map({ $0.englishName })
            DropDown(vc: self, array: cityNames).show(selecteditem: [txtCity.text ?? ""], showSearchBar: false, didSelect: { (text, selected, selectedItems) in
                self.txtCity.text = text
                let selectedCityIndex = cityNames.firstIndex(of: text ?? "")
                if let cityIndex = selectedCityIndex {
                    self.selectedCity = self.governorates[countryIndex].areas[cityIndex].id
                }
            })
        }
    }


    
    
    override func cropViewControllerDidCrop(_ cropViewController: CropViewController, cropped: UIImage, transformation: Transformation, cropInfo: CropInfo) {
        cropViewController.dismiss(animated: true, completion: nil)
        switch pickerSelectionType {
        case .userImage:
            imgUserImage.image = cropped
            imageChanged = true
        
        default:
            break
        }
    }
    
    @IBAction func btnMalePressed(_ sender: Any) {
        maleIsActiv()
    }
    
    @IBAction func btnFemalePressed(_ sender: Any) {
        femaleIsActive()

    }
    
    func maleIsActiv(){
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
        
        gender = "MALE"
    }
    
    func femaleIsActive(){
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
        
        gender = "FEMALE"
    }
    
    func normalizeFields() {
        txtName.superview?.superview?.layer.borderColor = AppColorSystem.Border.color.cgColor
        txtBirthDate.superview?.superview?.layer.borderColor = AppColorSystem.Border.color.cgColor
        txtCountry.superview?.superview?.layer.borderColor = AppColorSystem.Border.color.cgColor
        txtCity.superview?.superview?.layer.borderColor = AppColorSystem.Border.color.cgColor
        
    }



    @IBAction func continuePressed(_ sender: Any) {
        
        normalizeFields()
        
        validator.registerField(txtName, rules: [RequiredRule(message: ""), FullNameRule(message: "")])
        validator.registerField(txtBirthDate, rules: [RequiredRule(message: "")])
        validator.registerField(txtCountry, rules: [RequiredRule(message: "")])
        validator.registerField(txtCity, rules: [RequiredRule(message: "")])
        validator.validate(self)
        if genderValidation() {
            validationSuccessful()
        }
        
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
    
    func validationSuccessful() {
        if genderValidation() {
            if imageChanged == true  {
                upload(file: (imgUserImage.image?.pngData())!, type: .userImage)
            } else {
                let updateProfileInput : UpdateProfileInput = UpdateProfileInput(name: txtName.text ?? "", gender: gender ?? "", area: selectedCity, governorate: selectedGovernrate, birthday: txtBirthDate.text ?? "", profileLanguage: "en", isPrivate: isRadioButtonSelected)
                                
                updateProfile(params: updateProfileInput)

            }
        }
    }
    
    func validationFailed(_ errors: [(SwiftValidator.Validatable, SwiftValidator.ValidationError)]) {
        for (field, error) in errors {
            (field as? UIView)?.superview?.superview?.layer.borderColor = UIColor.red.cgColor
        }
    }

}



extension EditProfileVC {
    
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

    func getprofile() {
        K_Network.sendRequest(function: apiService.getProfile, success: { (code, msg, response)  in
            do {
                let data = try response.map(to: User.self, keyPath: "data")
                self.defaultProfilePicture = data.profilePicture
                self.txtName.text = data.name
                self.txtBirthDate.text = data.birthday
                self.txtCountry.text = data.governorate?.englishName
                self.selectedGovernrate = data.governorate?._id ?? ""
                if let governorateName = data.governorate?.englishName {
                    if let matchingIndex = self.governorates.firstIndex(where: { $0.englishName == governorateName }) {
                        print("Found at index:", matchingIndex)
                        self.selectedCountry = matchingIndex
                    } else {
                        print("No matching governorate found")
                    }
                }
                self.txtCity.text = data.city?.englishName
                self.selectedCity = data.city?._id ?? ""
                self.loadImage(stringUrl: data.profilePicture?.url ?? "", placeHolder: UIImage(named: "userProfile"), imgView: self.imgUserImage)
                if data.gender == "MALE"{
                    self.maleIsActiv()
                }else{
                    self.femaleIsActive()
                }
            } catch {
            }
        }) { (code, msg, errors) in
            Toast(text: msg).show()
        }
    }
    
    func upload(file: Data, type : PickerSelectionType) {
        K_Network.sendRequest(function: apiService.upload(file: file), success: { [self] (code, msg, response)  in
            do {
                let auth = try response.map(to: FileOutput.self, keyPath: "data")
                print(auth)
                switch type {
                case .userImage:
                    let userImageData = FileInput(url: auth.url, publicId: auth.publicId, imageName: auth.imageName)
                    
                    let updateProfileInput : UpdateProfileInput = UpdateProfileInput(name: txtName.text ?? "", gender: gender ?? "", area: selectedCity, governorate: selectedGovernrate, birthday: txtBirthDate.text ?? "", profilePicture: userImageData, profileLanguage: "EN", isPrivate: isRadioButtonSelected)
                    updateProfile(params: updateProfileInput)
                    
                default:
                    return
                }
                
            } catch {
            }
        }) { (code, msg, errors) in
            Toast(text: msg).show()
        }
    }
    
    
    
    func updateProfile(params: UpdateProfileInput) {
        K_Network.sendRequest(function: apiService.updateProfile(params: params), success: { (code, msg, response)  in
            do {
                let auth = try response.map(to: User.self, keyPath: "data")
                K_Defaults.set(auth.profilePicture?.url, forKey: Saved.USER_PHOTO)
                K_Defaults.set(auth.name, forKey: Saved.USER_NAME)
                NotificationCenter.default.post(name: Notification.Name("UserDataUpdated"), object: nil)

            } catch {
                print(msg, code, response)
            }
        }) { (code, msg, errors) in
            Toast(text: msg).show()
        }
    }
    
}
