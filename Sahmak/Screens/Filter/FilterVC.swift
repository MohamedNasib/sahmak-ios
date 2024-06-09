//
//  FilterVC.swift
//  Sahmak
//
//  Created by mac on 26/05/2023.
//

import UIKit
import RangeUISlider
import Toaster
import SwiftGradientButton

class FilterVC: ParentViewController ,RangeUISliderDelegate , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var parentView: UIView!

    @IBOutlet weak var rangeUISlider: RangeUISlider!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var txtLocation: UITextField!
    
    var arrayOfCatigories: [CattegoriesDetails] = []
    var minValueSelected = 0.0
    var maxValueSelected = 0.0
    var category_id = ""
    var date = ""
    weak var delegate: SecondViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIRangeSlider()
        categoryCellRegister()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getCategoryFillter()
    }
    
    func setupUIRangeSlider(){
        rangeUISlider.delegate = self
        rangeUISlider.showKnobsLabels = true
        rangeUISlider.knobsLabelTopPosition = false
        rangeUISlider.knobsLabelNumberOfDecimal = 3
    }
    
    func rangeChangeFinished(minValueSelected: CGFloat, maxValueSelected: CGFloat, slider: RangeUISlider) {
        self.minValueSelected = minValueSelected
        self.maxValueSelected = maxValueSelected
    }
    
    func categoryCellRegister(){
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        categoryCollectionView.allowsMultipleSelection = false
        categoryCollectionView.register(UINib(nibName: "FilterCategoriesCell", bundle: nil), forCellWithReuseIdentifier: "FilterCategoriesCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfCatigories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCategoriesCell", for: indexPath) as! FilterCategoriesCell
        cell.category = arrayOfCatigories[indexPath.row]
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let isAr = K_Defaults.string(forKey: Saved.LANGUAGE) == "ar"
            var text = ""
            if isAr {
                text = arrayOfCatigories[indexPath.row].arabicName
            }else {
                text = arrayOfCatigories[indexPath.row].englishName
            }
        return CGSize(width: (text as NSString).size(withAttributes: [NSAttributedString.Key.font: AppFontSystem.medium.size(12)]).width + 32, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! FilterCategoriesCell
        switch (indexPath.row) {
        case 0 :
            setupSelectedCellUI(lblCategoryTitle: cell.lblCategoryTitle)
            category_id = self.arrayOfCatigories[indexPath.row]._id
        case 1 :
            setupSelectedCellUI(lblCategoryTitle: cell.lblCategoryTitle)
            category_id = self.arrayOfCatigories[indexPath.row]._id
        case 2 :
            setupSelectedCellUI(lblCategoryTitle: cell.lblCategoryTitle)
            category_id = self.arrayOfCatigories[indexPath.row]._id
        default:
            break
        }
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! FilterCategoriesCell
        switch (indexPath.row) {
        case 0 :
            setupDeSelectedCellUI(lblCategoryTitle: cell.lblCategoryTitle)
        case 1 :
            setupDeSelectedCellUI(lblCategoryTitle: cell.lblCategoryTitle)
        case 2 :
            setupDeSelectedCellUI(lblCategoryTitle: cell.lblCategoryTitle)
        default:
            break
        }
    }
    
    func setupSelectedCellUI(lblCategoryTitle: UILabel){
        lblCategoryTitle.textColor = UIColor(named: "Primary")
        lblCategoryTitle.superview?.backgroundColor = UIColor(named: "#DA9D88")
        lblCategoryTitle.superview?.layer.borderWidth = 1
        lblCategoryTitle.superview?.layer.borderColor = UIColor(named: "Primary")?.cgColor
    }
    
    func setupDeSelectedCellUI(lblCategoryTitle: UILabel){
        lblCategoryTitle.textColor = UIColor(named: "#828282")
        lblCategoryTitle.superview?.backgroundColor = UIColor(named: "#F1F1F1")
        lblCategoryTitle.superview?.layer.borderWidth = 0
    }
                        
    
    @IBAction func btnChooseDatePressed(_ sender: GradientButton) {
        let allButtonTags = [1, 2, 3, 4, 5, 6 , 7]
        let currentButtonTag = sender.tag
        
        allButtonTags.filter { $0 != currentButtonTag }.forEach { tag in
               if let button = self.view.viewWithTag(tag) as? GradientButton {
                   // Deselect/Disable these buttons
                   button.startColor = UIColor(named: "#F0F2F5")!
                   button.endColor = UIColor(named: "#F0F2F5")!
                   button.startPoint = CGPoint(x: 0.5, y: 0.5)
                   button.endPoint = CGPoint(x: 1.0, y: 0.5)
                   if tag == 1 {
                       button.startColor = UIColor.white
                       button.endColor = UIColor.white
                   }
                   button.setTitleColor(UIColor(named: "#262626"), for: .normal)
                   button.isSelected = false
               }
           }
        sender.startColor = UIColor(named: "Primary")!
        sender.endColor = UIColor(named: "Secondary")!
        sender.startPoint = CGPoint(x: 0.5, y: 0.5)
        sender.endPoint = CGPoint(x: 1.0, y: 0.5)
        sender.setTitleColor(UIColor.white, for: .normal)
        self.date = sender.title(for: .normal) ?? ""
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func btnShowPropertyPressed(_ sender: UIButton) {
        let params = PrpertyFilterInput(categoryId: self.category_id, date: self.date, minPrice: Int(self.minValueSelected), maxPrice: Int(self.maxValueSelected), searchText: self.txtSearch.text ?? "" , page: 1)
        
        if delegate == nil {
            let vc = SearchVC.loadFromNib()
            vc.params = params
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        } else {
            self.delegate?.didFinishTaskWithData(params)
            self.dismiss(animated: true, completion: nil)
        }
    }
}


extension FilterVC {
    
    func getCategoryFillter() {
        K_Network.sendRequest(function: apiService.categories , success: { (code, msg, response)  in
            do {
                let response = try response.map(to: FilterResponse.self, keyPath: "data")
                self.arrayOfCatigories = response.categories
                self.categoryCollectionView.reloadData()
                self.rangeUISlider.scaleMaxValue = CGFloat(response.maxPrice)
                self.rangeUISlider.scaleMinValue = CGFloat(response.minPrice)
                self.parentView.isHidden = false
            } catch {
            }
        }) { (code, msg, errors) in
            Toast(text: msg).show()
        }
    }
}
