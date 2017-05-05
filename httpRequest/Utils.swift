//
//  Utils.swift
//  httpRequest
//
//  Created by Vincent Clerissj on 25/11/2016.
//  Copyright © 2016 Vincent Clerissj. All rights reserved.
//

import UIKit

class Utils: NSObject {
    func recursiviteOptimale (data: Data, info: String) -> String {
        var result = ""
        do {
            let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
            if let infoCheck = convertedJsonIntoDict?.value(forKey: info){
                result = (infoCheck as AnyObject).description
            } else {
                for (key,_) in convertedJsonIntoDict! {
                    
                    if let parseJsonNom : [String: AnyObject] = (convertedJsonIntoDict?[key] as? [String: AnyObject]){
                        let dataSend = try JSONSerialization.data(withJSONObject: parseJsonNom, options: JSONSerialization.WritingOptions.prettyPrinted)
                        result = recursiviteOptimale(data: dataSend, info: info)
                    }
                }
            }
        }catch let error as NSError {
            print(error.localizedDescription)
        }
        return result
    }
    
    func deserealization (data: Data) -> NSDictionary {
        var convertedJsonIntoDict: NSDictionary = NSDictionary()
        do {
            convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
        }catch let error as NSError {
            print(error.localizedDescription)
        }
        return convertedJsonIntoDict
    }
    
    func getDateFromTimeStamp (timeStampSince1070: TimeInterval) -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd/MM HH:mm"
        let date = NSDate(timeIntervalSince1970: timeStampSince1070)
        return dateFormater.string(from: date as Date)
    }
}
