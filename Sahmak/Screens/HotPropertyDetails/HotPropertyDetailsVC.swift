//
//  HotPropertyDetails.swift
//  Sahmak
//
//  Created by mac on 03/07/2023.
//

import UIKit
import Toaster
import ImageSlideshow
import Alamofire
import Charts
import GoogleMaps
import GooglePlaces




class HotPropertyDetailsVC: ParentViewController , ImageSlideshowDelegate {
    
    @IBOutlet weak var parentView: UIView!

    
    @IBOutlet weak var imgSlider: ImageSlideshow!
    @IBOutlet weak var btnSave: UIButton!
    // property details
    @IBOutlet weak var lblPropertyName: UILabel!
    @IBOutlet weak var lblPropertyPrice: UILabel!
    // date
    @IBOutlet weak var viewPropertyDate: UIView!
    @IBOutlet weak var lblPropertyDate: UILabel!
    // location
    @IBOutlet weak var lblPropertyLocation: UILabel!
    // property description
    @IBOutlet weak var lblPropertyDescription: UITextView!

    // stages
    @IBOutlet weak var viewStage: UIView!
    @IBOutlet weak var lblStage: UILabel!
    @IBOutlet weak var lblCommittedFunds: UILabel!

    // deposit view
    @IBOutlet weak var viewDeposit: UIView!
    @IBOutlet weak var lblDeposit: UILabel!
    @IBOutlet weak var lbltotalInvestment: UILabel!
    
    
    @IBOutlet weak var lblStageInterest: UILabel!
    @IBOutlet weak var viewStageInterest: UIView!

    @IBOutlet weak var lblStageFunding: UILabel!
    @IBOutlet weak var viewStageFunding: UIView!

    @IBOutlet weak var lblStageClosing: UILabel!
    @IBOutlet weak var viewStageClosing: UIView!
    
    @IBOutlet weak var lblStageClosed: UILabel!
    @IBOutlet weak var viewStageClosed: UIView!
    
    @IBOutlet weak var lineChartView: LineChartViewController!
    @IBOutlet weak var mapView: GMSMapView!

    
    var property_id = ""
    var status = ""
    var isSaved: Bool?
    
    var dataPoints: [String] = []
    var values = [Double]()
    var confirmProposalParams: ConfirmProposalParams?
    
    
    var cordiator = CLLocationCoordinate2D()
    var marker = GMSMarker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLineChart()
        setMapViewAttributes()
        viewStage.onTap(action: {
            let vc = StepsVC.loadFromNib()
            vc.status = self.status
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        })
    }
    
    func setMapViewAttributes(){
        mapView.animate(toZoom: 13)
        marker.icon = UIImage(named: "location")
        marker.map = mapView
    }
    
    func setupGoogleMaps(lat: Double , long: Double){
        cordiator = CLLocationCoordinate2D(latitude: lat, longitude: long)
        mapView.animate(toLocation: cordiator)
        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
    
    func setupLineChart(){
        lineChartView.xAxis.drawGridLinesEnabled = false
        lineChartView.leftAxis.drawGridLinesEnabled = false
        lineChartView.rightAxis.drawGridLinesEnabled = false
        lineChartView.xAxis.enabled = false
        // Hide the left Y-axis and its labels
        lineChartView.leftAxis.enabled = false
        lineChartView.xAxis.labelPosition = .bottom
        // Hide the right Y-axis and its labels
        lineChartView.rightAxis.enabled = false
        lineChartView.scaleXEnabled = false
        lineChartView.scaleYEnabled = false
        lineChartView.dragEnabled = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getPropertyDetails()
    }
        
    @IBAction func btnSavePressed(_ sender: Any) {
        if isSaved == false {
            saveProperty()
        }else{
            unSaveProperty()
        }
    }
    
    @IBAction func btnProposalPressed(_ sender: Any) {
        let vc = JoinPorposalDialogVC.loadFromNib()
        vc.confirmProposalParams = self.confirmProposalParams
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc , animated: true)
        
//        30.9657974
//        31.1617591
    }
}

extension HotPropertyDetailsVC{
    
    func getPropertyDetails() {
        K_Network.sendRequest(function: apiService.propertyDetails(id: property_id), success: { (code, msg, response)  in
            do {
                let response = try response.map(to: DataPropertiesDetails.self, keyPath: "data")
                self.parentView.isHidden = false
                self.lblPropertyPrice.text = "\(response.property?.price ?? 0)\("EGP".localized())"
                self.stageSelected(arabicStage: response.property?.stageArabicName ?? "", englishStage: response.property?.stageEnglishName ?? "")
                guard let imagesURL = response.property?.photos  else {return}
                self.configureImageSlider(photos: imagesURL)
                self.lblCommittedFunds.text = "\("Committed Funds:".localized()) \(response.property?.committedFunds ?? 0) \("EGP".localized())"
                self.status = response.property?.stageEnglishName ?? ""
                self.setupGoogleMaps(lat: response.property?.lat ?? 0.0, long: response.property?.lat ?? 0.0)
                self.lblDeposit.text = "\(response.property?.investment?.investmentPercentage ?? 0)%"
                self.lbltotalInvestment.text = "\(response.property?.investment?.investmentAmount ?? 0)"
                self.confirmProposalParams = ConfirmProposalParams(property_id: self.property_id , price: response.property?.price ?? 0 , deposit: 1000 , totalInvestmentMoney: 1000)
                self.isSaved = response.property?.isSaved
                if response.property?.isSaved == true {
                    self.btnSave.setImage(UIImage(named: "7188636_love_heart_favorite_social_expression_icon"), for: .normal)
                }else {
                    self.btnSave.setImage(UIImage(named: "Frame 196"), for: .normal)
                }
                
            
//                dataPoints = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
//                values = [10.0, 20.0, 2.0, 25.0, 1.0, 12.0]
                
                if response.priceHistory.isEmpty {
                    self.lineChartView.superview?.isHidden = true
                }
                self.dataPoints = response.priceHistory.map({ $0.createdAt })
                self.values = response.priceHistory.map({ Double($0.price) })
                self.lineChartView.setData(dataPoints: self.dataPoints, values: self.values)
                
                self.confirmProposalParams = ConfirmProposalParams(property_id: self.property_id, deposit: 1000, totalInvestmentMoney: 1000)
//                let dateFormatter = DateFormatter()
//                 dateFormatter.locale = Locale.current
//                 dateFormatter.dateFormat = "dd MMM yyyy"
//                let date = dateFormatter.date(from:response.createdAt)!
//                self.lblPropertyDate.text = "\(date)"
                
                let isAr = K_Defaults.string(forKey: Saved.LANGUAGE) == "ar"
                if isAr {
                    self.lblPropertyName.text = response.property?.arabicName
                    self.lblPropertyName.textAlignment = .right
                    self.lblPropertyDescription.text = response.property?.arabicDescription.html2String
                    self.lblPropertyLocation.text = response.property?.locationArabicName
                    self.lblStage.text = response.property?.stageArabicName
                    
                } else {
                    self.lblPropertyName.text = response.property?.englishName
                    self.lblPropertyName.textAlignment = .left
                    self.lblPropertyDescription.text = response.property?.englishDescription.html2String
                    self.lblPropertyLocation.text = response.property?.locationEnglishName
                    self.lblStage.text = response.property?.stageEnglishName
                    }
                
            } catch {
            }
        }) { (code, msg, errors) in
            Toast(text: msg).show()
        }
    }
    
    func saveProperty(){
        K_Network.sendRequest(function: apiService.saveProperty(id: property_id), success: { (code, msg, response)  in
            do {
                let response = try response.map(to: HomeResponse.self, keyPath: nil)
                if response.code == 200 {
                    Toast(text: response.message).show()
                    self.btnSave.setImage(UIImage(named: "7188636_love_heart_favorite_social_expression_icon"), for: .normal)
                }else {
                    Toast(text: response.message).show()
                }
            } catch {
            }
        }) { (code, msg, errors) in
            Toast(text: msg).show()
        }
    }
    
    func unSaveProperty(){
        K_Network.sendRequest(function: apiService.unSaveProperty(id: property_id), success: { (code, msg, response)  in
            do {
                let response = try response.map(to: HomeResponse.self, keyPath: nil)
                if response.code == 200 {
                    Toast(text: response.message).show()
                    self.btnSave.setImage(UIImage(named: "Frame 196"), for: .normal)
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

extension HotPropertyDetailsVC{
    func stageSelected(arabicStage: String , englishStage: String){
        
        if arabicStage == "تمويل" || englishStage == "funding" {
            lblStageInterest.alpha = 0.2
            lblStageClosing.alpha = 0.2
            lblStageClosed.alpha = 0.2
            viewStageInterest.alpha = 0.2
            viewStageClosing.alpha = 0.2
            viewStageClosed.alpha = 0.2
        }
        else if arabicStage == "اهتمام" || englishStage == "interest" {
            lblStageFunding.alpha = 0.2
            lblStageClosing.alpha = 0.2
            lblStageClosed.alpha = 0.2
            viewStageFunding.alpha = 0.2
            viewStageClosing.alpha = 0.2
            viewStageClosed.alpha = 0.2
        }
        
        else if arabicStage == "إغلاق" || englishStage == "closing" {
            lblStageFunding.alpha = 0.2
            lblStageInterest.alpha = 0.2
            lblStageClosed.alpha = 0.2
            viewStageFunding.alpha = 0.2
            viewStageInterest.alpha = 0.2
            viewStageClosed.alpha = 0.2
        }
        else  if arabicStage == "إغلاق" || englishStage == "closed" {
            lblStageFunding.alpha = 0.2
            lblStageInterest.alpha = 0.2
            lblStageClosing.alpha = 0.2
            viewStageFunding.alpha = 0.2
            viewStageInterest.alpha = 0.2
            viewStageClosing.alpha = 0.2
        }
        else {
            viewStage.isHidden = true
        }
    }
}

extension HotPropertyDetailsVC{
    
    func configureImageSlider(photos: [FileOutput]) {
        imgSlider.slideshowInterval = 5.0
        imgSlider.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
        imgSlider.contentScaleMode = UIViewContentMode.scaleAspectFill
        //        imageSlider.pageIndicator = nil
        
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = UIColor(named: "Primary")
        pageControl.preferredIndicatorImage = UIImage(named: "Rectangle 5892")
        imgSlider.pageIndicator = pageControl
        
        // optional way to show activity indicator during image load (skipping the line will show no activity indicator)
        imgSlider.activityIndicator = DefaultActivityIndicator()
        imgSlider.delegate = self
        
        var values: [AlamofireSource] = []
        
        for item in (photos) {
            if let value = AlamofireSource(urlString: item.url) {
                values.append(value)
            }
        }
        
        // can be used with other sample sources as `afNetworkingSource`, `alamofireSource` or `sdWebImageSource` or `kingfisherSource`
        imgSlider.setImageInputs(values)
        
//        let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTap))
//        imageSlider.addGestureRecognizer(recognizer)
    }
}


struct ConfirmProposalParams{
    var property_id = ""
//    var minPrice = 0
//    var maxPrice = 0
    var price = 0
    var deposit = 0
    var totalInvestmentMoney = 0
}
