//
//  shadowview.swift
//  RideShare
//
//  Created by Muhammad Usman on 02/06/1441 AH.
//  Copyright © 1441 Macbook. All rights reserved.
//

import Foundation
import UIKit


extension UIView {
    func shadow() {
        
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 1
        self.layer.cornerRadius = 30
        layer.shadowOffset = CGSize(width: 0.1, height: 0.3)
        self.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    }
    func shadowTop() {
        
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 8
        layer.borderWidth = 1
        layer.borderColor = #colorLiteral(red: 0.8926324248, green: 0.8926534057, blue: 0.8926420808, alpha: 1)
        layer.shadowOffset = CGSize(width: 0.1, height: 3.0)
        
    }
    func shadowWithLessCornerRadius() {
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 1
        self.layer.cornerRadius = 10
        layer.shadowOffset = CGSize(width: 0.1, height: 0.3)
        
    }
  
      
    
    func borderColorGrey() {
        self.layer.cornerRadius = 14
        self.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.layer.borderWidth = 1
        
    }
    func borderColorGrey8() {
           self.layer.cornerRadius = 8
           self.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
           self.layer.borderWidth = 1
           
       }
    func borderColor1() {
           self.layer.cornerRadius = 30
           self.layer.borderColor = #colorLiteral(red: 0.9333333333, green: 0.2980392157, blue: 0.2274509804, alpha: 1)
           self.layer.borderWidth = 1
           
       }
    func imageround() {
             self.layer.cornerRadius = 8
             self.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
             self.layer.borderWidth = 2
             
         }
    
    func RoundSpecificTopCorner() {
        self.layer.cornerRadius = 25
        self.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.layer.borderWidth = 1
        // self.layer.clipsToBounds = true
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        //self.layer.borderWidth = 0
    }
    func RoundSpecificBottomCorner () {
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 0.5
        self.layer.cornerRadius = 14
        layer.shadowOffset = CGSize(width: 0.2, height: 0.2)
        self.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        // self.layer.clipsToBounds = true
        self.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
        //self.layer.borderWidth = 0
    }
    func RoundSpecificBottomCornerR () {
//           self.layer.shadowOpacity = 0.5
//           self.layer.shadowRadius = 0.5
           self.layer.cornerRadius = 8
          // layer.shadowOffset = CGSize(width: 0.2, height: 0.2)
           self.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
           // self.layer.clipsToBounds = true
           self.layer.maskedCorners = [.layerMaxXMaxYCorner]
           //self.layer.borderWidth = 0
       }
    func RoundSpecificBottomCornerL () {
//           self.layer.shadowOpacity = 0.5
//           self.layer.shadowRadius = 0.5
           self.layer.cornerRadius = 8
           //layer.shadowOffset = CGSize(width: 0.2, height: 0.2)
           self.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
           // self.layer.clipsToBounds = true
           self.layer.maskedCorners = [.layerMinXMaxYCorner]
           //self.layer.borderWidth = 0
       }
     func RoundSpecificBottomCornerLR () {
    //           self.layer.shadowOpacity = 0.5
    //           self.layer.shadowRadius = 0.5
               self.layer.cornerRadius = 8
               //layer.shadowOffset = CGSize(width: 0.2, height: 0.2)
               self.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
               // self.layer.clipsToBounds = true
               self.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
               //self.layer.borderWidth = 0
           }
    
}

extension UILabel {
    func shadowLblBorderColor () {
        self.layer.cornerRadius = 6
        self.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.layer.borderWidth = 1
        layer.shadowOffset = CGSize(width: 0.1, height: 0.3)
        self.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
}

extension UITextView {
    
    func  textViewRound () {
        
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
    }
    
}
extension UIButton {
    
    func ButtonShadow() {
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 1
        self.layer.cornerRadius = 6
        layer.shadowOffset = CGSize(width: 0.1, height: 0.3)
        self.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    }
    
    func whitecornerBtn() {
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 1
        self.layer.cornerRadius = 6
        layer.shadowOffset = CGSize(width: 0.1, height: 0.3)
        self.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.layer.borderWidth = 1
    }
}
//TODO:- For converting the Local Time to the server time Zone
extension String {
    //MARK:- Convert UTC To Local Date by passing date formats value
    func UTCToLocal(incomingFormat: String, outGoingFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = incomingFormat
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let dt = dateFormatter.date(from: self)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = outGoingFormat
        
        return dateFormatter.string(from: dt ?? Date())
    }
    
    //MARK:- Convert Local To UTC Date by passing date formats value
    func localToUTC(incomingFormat: String, outGoingFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = incomingFormat
        dateFormatter.calendar = NSCalendar.current
        dateFormatter.timeZone = TimeZone.current
        
        let dt = dateFormatter.date(from: self)
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = outGoingFormat
        
        return dateFormatter.string(from: dt ?? Date())
    }
    
    
}

