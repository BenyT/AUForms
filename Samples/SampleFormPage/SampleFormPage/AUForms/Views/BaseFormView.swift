//
//  BaseFormView.swift
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

class BaseFormView : BaseView, TableCellLoadable, Validatable, AccessoryViewLoadable{

    var title : String?
    
    var controlValidation:ControlValidator?{
        didSet {
            controlValidation?.delegate = self
        }
    }
    
    weak var behaviourDelegate: FormViewBehaviour?
    
    //MARK: initializations
    override init(){
        super.init()
    }
    
    init(title: String?){
        super.init(frame: CGRectZero)
        self.title = title
        self.loadNib()
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    override func endEditing(force: Bool) -> Bool {
        return self.view.endEditing(force)
    }
    override func isFirstResponder() -> Bool {
        return self.view.isFirstResponder()
    }
    
    //MARK: AccessoryViewLoadable implementations
    func setInputAccessoryView(view: UIView){
        
    }
    
    func hasAccessoryView()->Bool{
        return false
    }
    
    //MARK: Abstract methods
    func getReusableIdentifier()->String{
        return getNibName()
    }
    
    func getRowHeight() -> CGFloat{
        assert(false, "This method must be overriden")
        return 0.0
    }
    
    //Update custom form control
    func updateUI(){
    }
    
    //MARK: Validatable implementations
    func getValidationValue() -> AnyObject?{
        return ""
    }
    func setValidationError(error:String){
        
    }
    func setValidationSuccess(){
        
    }
}

