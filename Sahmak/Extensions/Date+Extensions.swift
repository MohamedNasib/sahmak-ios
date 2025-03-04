//
//  Date+Extensions.swift
//
//  Created by hassan on 11/15/20.
//  Copyright © 2020 hassan. All rights reserved.
//

import Foundation

extension Date {
    
    func datePickerFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd / MM / YYYY"
        return formatter.string(from: self)
    }
    
    func getDayAndWeek() ->(date : Date ,day : String , week : String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat  = "dd,EE" // "EE" to get short style
        let dayInWeek = dateFormatter.string(from: self) // "Sunday"
        let splitedDate = dayInWeek.components(separatedBy: ",")
        return (self,splitedDate.first! , splitedDate.last!)

    }
    func toYYYY() -> String {
        return toString(format: "yyyy")
    }
    func toMM() -> String {
        return toString(format: "MM")
    }
    func toStringddMMyyyySlashed() -> String {
        return toString(format: "dd/MM/yyyy")
    }
    func toDefaultWebString(format: String = "yyyy-MM-dd HH:mm:ss") -> String {
         let formatter = DateFormatter()
         formatter.dateStyle = .short
         formatter.dateFormat = format
         return formatter.string(from: self)
     }
    func toString(format: String = "yyyy-MM-dd") -> String {
         let formatter = DateFormatter()
         formatter.dateStyle = .short
         formatter.dateFormat = format
         return formatter.string(from: self)
     }
     
     func dateAndTimetoString(format: String = "yyyy-MM-dd HH:mm") -> String {
         let formatter = DateFormatter()
         formatter.dateStyle = .short
         formatter.dateFormat = format
         return formatter.string(from: self)
     }
    
     func timeIn24HourFormat() -> String {
         let formatter = DateFormatter()
         formatter.dateStyle = .none
         formatter.dateFormat = "HH:mm"
         return formatter.string(from: self)
     }
     
     func startOfMonth() -> Date {
         var components = Calendar.current.dateComponents([.year,.month], from: self)
         components.day = 1
         let firstDateOfMonth: Date = Calendar.current.date(from: components)!
         return firstDateOfMonth
     }
     
     func endOfMonth() -> Date {
         return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
     }
     
     func nextDate() -> Date {
         let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: self)
         return nextDate ?? Date()
     }
    func nextHour(number : Int) -> Date {
        let nextDate = Calendar.current.date(byAdding: .hour, value: number, to: self)
        return nextDate ?? Date()
    }

     func previousDate() -> Date {
         let previousDate = Calendar.current.date(byAdding: .day, value: -1, to: self)
         return previousDate ?? Date()
     }
     
     func addMonths(numberOfMonths: Int) -> Date {
         let endDate = Calendar.current.date(byAdding: .month, value: numberOfMonths, to: self)
         return endDate ?? Date()
     }
     
     func removeMonths(numberOfMonths: Int) -> Date {
         let endDate = Calendar.current.date(byAdding: .month, value: -numberOfMonths, to: self)
         return endDate ?? Date()
     }
     
     func removeYears(numberOfYears: Int) -> Date {
         let endDate = Calendar.current.date(byAdding: .year, value: -numberOfYears, to: self)
         return endDate ?? Date()
     }
     
     func getHumanReadableDayString() -> String {
         let weekdays = [
             "Sunday",
             "Monday",
             "Tuesday",
             "Wednesday",
             "Thursday",
             "Friday",
             "Saturday"
         ]
         
         let calendar = Calendar.current.component(.weekday, from: self)
         return weekdays[calendar - 1]
     }
     
     
     func timeSinceDate(fromDate: Date) -> String {
         let earliest = self < fromDate ? self  : fromDate
         let latest = (earliest == self) ? fromDate : self
     
         let components:DateComponents = Calendar.current.dateComponents([.minute,.hour,.day,.weekOfYear,.month,.year,.second], from: earliest, to: latest)
         let year = components.year  ?? 0
         let month = components.month  ?? 0
         let week = components.weekOfYear  ?? 0
         let day = components.day ?? 0
         let hours = components.hour ?? 0
         let minutes = components.minute ?? 0
         let seconds = components.second ?? 0
         
         
         if year >= 2{
             return "\(year) years ago"
         }else if (year >= 1){
             return "1 year ago"
         }else if (month >= 2) {
              return "\(month) months ago"
         }else if (month >= 1) {
          return "1 month ago"
         }else  if (week >= 2) {
             return "\(week) weeks ago"
         } else if (week >= 1){
             return "1 week ago"
         } else if (day >= 2) {
             return "\(day) days ago"
         } else if (day >= 1){
            return "1 day ago"
         } else if (hours >= 2) {
             return "\(hours) hours ago"
         } else if (hours >= 1){
             return "1 hour ago"
         } else if (minutes >= 2) {
             return "\(minutes) minutes ago"
         } else if (minutes >= 1){
             return "1 minute ago"
         } else if (seconds >= 3) {
             return "\(seconds) seconds ago"
         } else {
             return "Just now"
         }
         
     }
    
    
}
