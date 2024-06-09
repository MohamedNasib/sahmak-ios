//
//  Strings+Extension.swift
//
//  Created by hassan on 11/9/20.
//  Copyright © 2020 hassan. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    func dateFormat() -> String {
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"

        if let date = dateFormatterGet.date(from: self) {
            return dateFormatterPrint.string(from: date)
        }
        
        return ""
    }
    
    func localized() -> String {
            return NSLocalizedString(self, comment: "")
        }
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }

    func convertHtmlToAttributedStringWithCSS(font: UIFont?, csstextalign: String, lineheight: String = "20") -> NSAttributedString? {
            guard let font = font else {
                return htmlToAttributedString
            }
            let modifiedString =
            "<style>" +
            "body{" +
            "font-family: '\(font.fontName)'; " +
            "font-size:\(font.pointSize)px; " +
    //        "color: \(csscolor); " +
            "line-height: \(lineheight)px; " +
            "text-align: \(csstextalign); " +
            "} " +
            "</style>\(self)"
            guard let data = modifiedString.data(using: .utf8) else {
                return nil
            }
            do {
                return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
            }
        catch {
            print(error)
            return nil
        }
    }
    
    /// check if all char in string is number
    var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }

    /// validate email with email regix
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    func isEnglishLetter() -> Bool {
        let letterRegex = "^[a-zA-Z]+[ a-zA-Z-_]*$"
        let letterPred = NSPredicate(format:"SELF MATCHES %@", letterRegex)
        return letterPred.evaluate(with: self)
    }
    /// not implement it unless get regex for it
    func isValidPhone() -> Bool {
        let PHONE_REGEX = "^((\\+)|(00))[0-9]{6,14}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result = phoneTest.evaluate(with: self)
        return result
    }
    
    func isPasswordHasNumberAndCharacter() -> Bool {
        let passRegEx = "^[a-zA-Z0-9]+$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passRegEx)
        return passwordTest.evaluate(with: self)
    }

    public var asDate: Date?
    {
        let dateString = self
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "US")
        dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss z"
        if let date = dateFormatter.date(from: dateString) {
            return date
        }
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = dateFormatter.date(from: dateString) {
            return date
        }
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SS"
        if let date = dateFormatter.date(from: dateString) {
            return date
        }
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SZ"
        if let date = dateFormatter.date(from: dateString) {
            return date
        }
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = dateFormatter.date(from: dateString) {
            return date
        }
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        if let date = dateFormatter.date(from: dateString) {
            return date
        }
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        if let date = dateFormatter.date(from: dateString) {
            return date
        }
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        if let date = dateFormatter.date(from: dateString) {
            return date
        }
        dateFormatter.dateFormat = "dd/MM/yyyy"
        if let date = dateFormatter.date(from: dateString) {
            return date
        }
        dateFormatter.dateFormat = "MM/dd/yyyy"
        if let date = dateFormatter.date(from: dateString) {
            return date
        }
        dateFormatter.dateFormat = "MM-dd-yyyy"
        if let date = dateFormatter.date(from: dateString) {
            return date
        }
        dateFormatter.dateFormat = "MMM dd, yyyy"
        if let date = dateFormatter.date(from: dateString) {
            return date
        }
        dateFormatter.dateFormat = "MMM dd, yyyy HH:mm"
        if let date = dateFormatter.date(from: dateString) {
            return date
        }
        dateFormatter.dateFormat = "MMM dd, yyyy HH:mm:ss"
        if let date = dateFormatter.date(from: dateString) {
            return date
        }
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        if let date = dateFormatter.date(from: dateString) {
            return date
        }
        dateFormatter.dateFormat = "MMMM dd, yyyy HH:mm"
        if let date = dateFormatter.date(from: dateString) {
            return date
        }
        dateFormatter.dateFormat = "MMMM dd, yyyy HH:mm:ss"
        if let date = dateFormatter.date(from: dateString) {
            return date
        }
    
        return nil
    }

    func openExternalURl() -> Void {
        if let url = URL(string: self) {
            UIApplication.shared.open(url)
        }

    }

    func callNumber() -> Void {
        if let url = URL(string: "tel://\(self)") , UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }

    }
    func openWhatsApp() -> Void {
        if let url = URL(string:"https://api.whatsapp.com/send?phone=\(self)") {
            UIApplication.shared.open(url)
        }

    }
    func openSmsApp() -> Void {
        if let url = URL(string:"sms:\(self)") {
            UIApplication.shared.open(url)
        }
    }
    func openEmail() -> Void {
        if let url = URL(string: "mailto:\(self)") {
          if #available(iOS 10.0, *) {
            UIApplication.shared.open(url)
          } else {
            UIApplication.shared.openURL(url)
          }
        }
//
//        if let appURL = URL(string: "mailto:\(self)") {
//            UIApplication.shared.openURL(appURL)
//        }
    }
    
    func getLast4Digits() -> Int? {
        // Check if the credit card number is valid
        guard self.count >= 4 && Int(self) != nil else {
            return nil
        }
        
        // Extract the last 4 digits
        let last4 = self.suffix(4)
        
        // Convert to Int and return
        return Int(last4)
    }

}
