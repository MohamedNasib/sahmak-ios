//
//  Home.swift
//  Sahmak
//
//  Created by mac on 22/05/2023.
//

import Foundation
import Mapper


struct HomeResponse: Mappable {
    var code = 0
    var message = ""
    var data : HomeDataDetails?
    
    init (map: Mapper) throws {
        code = map.optionalFrom("code") ?? 0
        message = map.optionalFrom("message") ?? ""
        data = map.optionalFrom("data")
    }
}


struct HomeDataDetails: Mappable {
    var hotProperties: [HotPropertiesDetails] = []
    var count = 0
    var totalBalance: TotalBalanceDetails?
    var yourProperties: [YourPropertiesDetails] = []
    var userName = ""
    var profilePicture: FileOutput?
    
    init (map: Mapper) throws {
        hotProperties = map.optionalFrom("hotProperties") ?? []
        count = map.optionalFrom("count") ?? 0
        totalBalance = map.optionalFrom("totalBalance")
        yourProperties = map.optionalFrom("yourProperties") ?? []
        userName = map.optionalFrom("userName") ?? ""
        profilePicture = map.optionalFrom("profilePicture")
    }
}

struct HotPropertiesDetailsResponse: Mappable {
    var code = 0
    var message = ""
    var data: PropertiesDetails?

    init (map: Mapper) throws {
        code = map.optionalFrom("code") ?? 0
        message = map.optionalFrom("message") ?? ""
        data = map.optionalFrom("data")
    }
}

struct PropertiesDetails: Mappable {
    var count = 0
    var properties: [HotPropertiesDetails] = []

    init (map: Mapper) throws {
        count = map.optionalFrom("count") ?? 0
        properties = map.optionalFrom("properties") ?? []
    }
}



struct DataPropertiesDetails: Mappable {
    var property: HotPropertiesDetails?
    var investment: InvestmentDetails?
    var btnView = ""
    var priceHistory: [PriceHistoryDetails] = []

    init (map: Mapper) throws {
        property = map.optionalFrom("property")
        investment = map.optionalFrom("investment")
        btnView = map.optionalFrom("btnView") ?? ""
        priceHistory = map.optionalFrom("priceHistory") ?? []
    }
}

struct HotPropertiesDetails: Mappable {
    var mainPhoto: FileOutput?
    var englishStage = ""
    var arabicStage = ""
    var _id = ""
    var arabicName = ""
    var englishName = ""
    var arabicLocationName = ""
    var englishLocationName = ""
    var arabicDescribtion = ""
    var englishDescription = ""
    var sharePrice = 0
    var minPrice = 0
    var maxPrice = 0
    var price = 0
    var category = ""
    var totalShares = 0
    var remainingShares = 0
    var depositPercentage = 0
    var buyers: [BuyersDetails] = []
    var stage = ""
    var isDeactivated = false
    var isSaved = false
    var createdAt = ""
    var updatedAt = ""
    var __v = 0
    var lat = 0.0
    var long = 0.0
    // saved property
    var property: PropertyDetails?
    var propertyType = ""
    var user = ""
    
    var locationEnglishName = ""
    var locationArabicName = ""
    var arabicDescription = ""
    var categoryEnglishName = ""
    var categoryArabicName = ""
    var openForProposal = false
    var committedFunds = 0
    var investment : InvestmentDetails?
    
    var stageEnglishName = ""
    var stageArabicName = ""
    
    var photos: [FileOutput] = []
    // line chart
    
    init (map: Mapper) throws {
        mainPhoto = map.optionalFrom("mainPhoto")
        englishStage = map.optionalFrom("englishStage") ?? ""
        arabicStage = map.optionalFrom("arabicStage") ?? ""
        _id = map.optionalFrom("_id") ?? ""
        arabicName = map.optionalFrom("arabicName") ?? ""
        englishName = map.optionalFrom("englishName") ?? ""
        arabicLocationName = map.optionalFrom("arabicLocationName") ?? ""
        englishLocationName = map.optionalFrom("englishLocationName") ?? ""
        arabicDescribtion = map.optionalFrom("arabicDescribtion") ?? ""
        englishDescription = map.optionalFrom("englishDescription") ?? ""
        sharePrice = map.optionalFrom("sharePrice") ?? 0
        minPrice = map.optionalFrom("minPrice") ?? 0
        maxPrice = map.optionalFrom("maxPrice") ?? 0
        price = map.optionalFrom("price") ?? 0
        depositPercentage = map.optionalFrom("depositPercentage") ?? 0
        category = map.optionalFrom("category") ?? ""
        totalShares = map.optionalFrom("totalShares") ?? 0
        remainingShares = map.optionalFrom("remainingShares") ?? 0
        lat = map.optionalFrom("lat") ?? 0.0
        long = map.optionalFrom("long") ?? 0.0
        // saved properties
        property = map.optionalFrom("property")
        propertyType = map.optionalFrom("propertyType") ?? ""
        user = map.optionalFrom("user") ?? ""
        
        buyers = map.optionalFrom("buyers") ?? []
        stage = map.optionalFrom("stage") ?? ""
        isDeactivated = map.optionalFrom("isDeactivated") ?? false
        isSaved = map.optionalFrom("isSaved") ?? false
        createdAt = map.optionalFrom("createdAt") ?? ""
        updatedAt = map.optionalFrom("updatedAt") ?? ""
        __v = map.optionalFrom("__v") ?? 0
        
        locationEnglishName = map.optionalFrom("locationEnglishName") ?? ""
        locationArabicName = map.optionalFrom("locationArabicName") ?? ""
        categoryEnglishName = map.optionalFrom("categoryEnglishName") ?? ""
        categoryArabicName = map.optionalFrom("categoryArabicName") ?? ""
        arabicDescription = map.optionalFrom("arabicDescription") ?? ""
        openForProposal = map.optionalFrom("openForProposal") ?? false
        committedFunds = map.optionalFrom("committedFunds") ?? 0
        investment = map.optionalFrom("investment")
        stageEnglishName = map.optionalFrom("stageEnglishName") ?? ""
        stageArabicName = map.optionalFrom("stageArabicName") ?? ""
        photos = map.optionalFrom("photos") ?? []
        
        
    }
}

struct PropertyDetails: Mappable {
    var mainPhoto: FileOutput?
    var  _id = ""
    var  arabicName = ""
    var  englishName = ""
    var  arabicLocationName = ""
    var  englishLocationName = ""
    var  minPrice = 0
    var  maxPrice = 0
    
    init (map: Mapper) throws {
        mainPhoto = map.optionalFrom("mainPhoto")
        _id = map.optionalFrom("_id") ?? ""
        arabicName = map.optionalFrom("arabicName") ?? ""
        englishName = map.optionalFrom("englishName") ?? ""
        arabicLocationName = map.optionalFrom("arabicLocationName") ?? ""
        englishLocationName = map.optionalFrom("englishLocationName") ?? ""
        minPrice = map.optionalFrom("minPrice") ?? 0
        maxPrice = map.optionalFrom("maxPrice") ?? 0
    }
}


struct PriceHistoryDetails: Mappable {
    var  _id = ""
    var  price = 0
    var  createdAt = ""
    init (map: Mapper) throws {
        _id = map.optionalFrom("_id") ?? ""
        price = map.optionalFrom("price") ?? 0
        createdAt = map.optionalFrom("createdAt") ?? ""
    }
}




struct BuyersDetails: Mappable {
    var _id = ""
    var profilePicture :FileOutput?

    init (map: Mapper) throws {
        _id = map.optionalFrom("_id") ?? ""
        profilePicture = map.optionalFrom("profilePicture")
    }
}

struct priceHistory: Mappable {
    var _id = ""
    var createdAt = ""
    var price = 0

    init (map: Mapper) throws {
        _id = map.optionalFrom("_id") ?? ""
        createdAt = map.optionalFrom("createdAt") ?? ""
        price = map.optionalFrom("price") ?? 0
        
    }
}


struct InvestmentDetails: Mappable {
    var investmentStage = ""
    var proposalStatus = ""
    var investmentPercentage = 0
    var investmentAmount = 0
    var proposalId = ""

    init (map: Mapper) throws {
        investmentStage = map.optionalFrom("investmentStage") ?? ""
        proposalStatus = map.optionalFrom("proposalStatus") ?? ""
        investmentPercentage = map.optionalFrom("investmentPercentage") ?? 0
        investmentAmount = map.optionalFrom("investmentAmount") ?? 0
        proposalId = map.optionalFrom("proposalId") ?? ""
    }
}


struct TotalBalanceDetails: Mappable {
    var profitPrecentage = 0
    var totalInvestedBalance = 0
    var profitAmount = 0

    init (map: Mapper) throws {
        profitPrecentage = map.optionalFrom("profitPrecentage") ?? 0
        totalInvestedBalance = map.optionalFrom("totalInvestedBalance") ?? 0
        profitAmount = map.optionalFrom("profitAmount") ?? 0
    }
}

struct YourPropertiesDetails: Mappable {
    var mainPhoto: FileOutput?
    var _id = ""
    var arabicName = ""
    var englishName = ""
    var arabicLocationName = ""
    var englishLocationName = ""
    var totalInvestedBalance = 0
    var __v = 0

    init (map: Mapper) throws {
        
        mainPhoto = map.optionalFrom("mainPhoto")
        _id = map.optionalFrom("_id") ?? ""
        arabicName = map.optionalFrom("arabicName") ?? ""
        englishName = map.optionalFrom("englishName") ?? ""
        arabicLocationName = map.optionalFrom("arabicLocationName") ?? ""
        englishLocationName = map.optionalFrom("englishLocationName") ?? ""
        totalInvestedBalance = map.optionalFrom("totalInvestedBalance") ?? 0
        __v = map.optionalFrom("__v") ?? 0
    }
}

            



       
