//
//  FormValidator.swift
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

class FormValidator{
    private var validators=[ControlValidator]()
    
    init(){}
        
    func validate() -> Bool{
        var isFormValid = true
        for validator in validators{
            if(!validator.validate()){
                isFormValid = false
            }
        }
        return isFormValid
    }
    
    func addValidator(validator:ControlValidator){
        self.validators.append(validator)
    }
    
    func removeValidator(validator:ControlValidator){       
        if let index = Swift.find(self, validator){
            self.validators.removeAtIndex(index)
        }
    }
}

extension FormValidator : CollectionType{
    typealias Index = Int
    
    var startIndex: Int {
        return 0
    }
    
    var endIndex: Int {
        return validators.count
    }
    
    subscript(i: Int) -> ControlValidator {
        return validators[i]
    }
    
    typealias Generator = GeneratorOf<ControlValidator>
    
    func generate() -> Generator {
        var index = 0
        return GeneratorOf {
            if index < self.validators.count {
                return self.validators[index++]
            }
            return nil
        }
    }
}