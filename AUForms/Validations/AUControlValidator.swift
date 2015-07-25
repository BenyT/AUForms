//
//  AUControlValidator.swift
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
class AUControlValidator:Equatable{
    private var validationTypes = [AUValidationChecking]()
    
    weak var delegate : AUValidatable?
    
    init(){
        
    }
    
    func validate() -> Bool{
        
        let AUValidatableValue: AnyObject? = delegate?.getValidationValue()
        for type in validationTypes{
            if !type.check(AUValidatableValue){
                let errorMsg = type.getErrorMessage()
                delegate?.setValidationError(errorMsg)
                
                return false
            } else{
                delegate?.setValidationSuccess()
            }
        }
        return true
    }
    
    //Fluent interface for readability
    func addRule(newRule:AUValidationChecking)->AUControlValidator{
        self.validationTypes.append(newRule)
        return self
    }
}

//TODO: Use indexof() func instead of this in swift 2.0
func == (lhs: AUControlValidator, rhs: AUControlValidator) -> Bool {
    return lhs === rhs
}
