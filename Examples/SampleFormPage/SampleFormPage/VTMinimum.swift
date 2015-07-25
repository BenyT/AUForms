//
//  VTMinValidator.swift
//  FormPageFramework
//  Copyright (c) 2015 Anıl Uygun
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
import Foundation
class VTMinimum: AUValidationChecking{
    var baseValue:Double=0
    var baseValueCallback:(()->(Double))?
    
    init(baseValue:Double){
        self.baseValue = baseValue
    }
    
    init(baseValueCallback:()->(Double)){
        self.baseValueCallback = baseValueCallback
    }
    
    func check(value:AnyObject?)->Bool{
        
        assert(value != nil, "")
        
        var dblValue = baseValue - 1
        if let value = value as? String{
            dblValue = (value as NSString).doubleValue
        } else if let value = value as? Double{
            dblValue = value
        }
        
        if (baseValueCallback != nil){
            baseValue = baseValueCallback!()
        }
        
        return dblValue >= baseValue
    }
    
    func getErrorMessage()->String{
        return "Minimum \(baseValue) required"
    }
}
