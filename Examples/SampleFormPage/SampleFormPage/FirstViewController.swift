//
//  FirstViewController.swift
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

class FirstViewController:BaseFormController{
    
    var pageFlow : FirstPageFlow!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let numberControl = CustomTextBoxView(title: "Number:")
        let stringControl = CustomTextBoxView(title: "String:")
        let button = CustomSimpleButtonView(title: "Submit", buttonPressCallback: {[weak self] in self!.formSubmitted()})
        
        var numberValidator = ControlValidator()
            .addRule(VTRequired())
            .addRule(VTMinimum(baseValue: 5))
        var stringValidator = ControlValidator().addRule(VTRequired())
        
        numberControl.controlValidation = numberValidator
        stringControl.controlValidation = stringValidator
        
        addControl(numberControl)
        addControl(stringControl)
        addControl(button)
    }
    
    func formSubmitted(){
        if(super.validateForm()){
            println("Form validation succeed")
            pageFlow.openSecondPage()
        } else {
            println("Form validation failed")
        }
    }
}
