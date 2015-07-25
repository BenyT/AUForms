//
//  CustomTextBoxView.swift
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
import UIKit

class CustomTextBoxView : BaseFormView, UITextFieldDelegate{
    
    @IBOutlet private weak var controlNameLbl: UILabel!
    @IBOutlet private weak var controlNameTxt: UITextField!

    
    override init(title:String?){
        super.init(title:title)
        
        self.controlNameTxt.delegate = self
        self.addChangingEvent()
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    override func updateUI() {
        controlNameLbl.text = self.title
    }
    
    override func getNibName() -> String {
        return "CustomTextBoxControl"
    }
    
    override func getRowHeight() -> CGFloat {
        return 78.0
    }
    
    override func isFirstResponder() -> Bool {
        return super.isFirstResponder() || self.controlNameTxt.isFirstResponder()
    }
    override func becomeFirstResponder() -> Bool {
        return self.controlNameTxt.becomeFirstResponder()
    }
    
    //MARK: AccessoryViewLoadable implementations
    override func setInputAccessoryView(view: UIView){
        self.controlNameTxt.inputAccessoryView = view
        self.controlNameTxt.autocorrectionType = UITextAutocorrectionType.No
    }
    override func hasAccessoryView()->Bool{
        return true
    }
    
    //MARK: Validatable implementations
    override func getValidationValue() -> AnyObject?{
        return self.textValue
    }
    
    override func setValidationError(error:String){
        self.textValue = error
        paintBorder(UIColor.redColor())
    }
    
    override func setValidationSuccess() {
        clearBorderColor()
    }
    
    //MARK: UITextFieldDelegate implementations
    func textFieldDidBeginEditing(textField: UITextField){
        super.behaviourDelegate?.formControlViewDidActivated(self)
    }
    
    //MARK: public members
    var textValue: String? {
        get {
            return self.controlNameTxt.text
        }
        set(newText) {
            self.controlNameTxt.text = newText
        }
    }
    
    func nameTextChanging(){
        
    }
    
    //MARK: Private members
    private func addChangingEvent(){
        controlNameTxt.addTarget(self, action: "nameTextChanging", forControlEvents: UIControlEvents.EditingChanged)
    }
    private func paintBorder(color:UIColor){
        self.controlNameTxt.layer.borderColor = color.CGColor
        self.controlNameTxt.layer.borderWidth = 2.0
    }
    private func clearBorderColor(){
        self.controlNameTxt.layer.borderColor = UIColor.clearColor().CGColor
    }
    
}
