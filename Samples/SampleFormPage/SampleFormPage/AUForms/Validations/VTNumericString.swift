//
//  VTNumeric.swift
//  FormPageFramework
//
//  Created by ykbuser on 17/02/15.
//  Copyright (c) 2015 YKB. All rights reserved.
//
import Foundation
class VTNumericString: ValidationChecking{
    
    func check(value:AnyObject?)->Bool{
        if let txtValue = value as? String{
            //TODO:Gerekirse incele 'charactersToBeSkipped'
            let scan = NSScanner(string: txtValue)
            
            return (scan.scanInteger(nil) && scan.atEnd) ||
                (scan.scanDouble(nil) && scan.atEnd) ||
                (scan.scanDecimal(nil) && scan.atEnd)
            
        }
        return false
    }
    
    func getErrorMessage()->String{
        return "Lütfen sayısal değer giriniz"
    }
}