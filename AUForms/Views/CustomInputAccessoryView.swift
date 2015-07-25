//
//  CustomInputAccessoryView.swift
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

class CustomInputAccessoryView:BaseView{
   
    @IBOutlet private weak var previousButton: UIBarButtonItem!
    @IBOutlet private weak var nextButton: UIBarButtonItem!
    @IBOutlet private weak var rightMostButton: UIBarButtonItem!
    
    weak var delegate : CustomAccessoryViewDelegate?
    
    ///Owner component of accessoryview
    weak var owner : BaseView?
    
    override func getNibName()->String{
        return "CustomInputAccessoryView"
    }
    
    func setDoneTitle(title:String){
        self.rightMostButton.title = title
    }
    
    @IBAction func rightMostButtonPressed(sender: AnyObject) {
        delegate?.accessoryViewDoneAction(self)
    }
    
    @IBAction func nextButtonPressed(sender: AnyObject) {
        delegate?.accessoryViewNextAction(self)
    }
    
    @IBAction func previousButtonPressed(sender: AnyObject) {
        delegate?.accessoryViewPreviousAction(self)
    }
    
    func setNextEnable(status:Bool){
        self.nextButton.enabled = status
    }
    func setPreviousEnable(status:Bool){
        self.previousButton.enabled = status
    }
}
