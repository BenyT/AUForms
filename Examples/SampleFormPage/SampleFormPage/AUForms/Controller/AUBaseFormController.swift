//
//  AUBaseFormController.swift
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
class AUBaseFormController : UIViewController {
    
    @IBOutlet var formContentView: UIView!
    @IBOutlet weak var formTableView: UITableView!

    
    private var formValidation : AUFormValidator = AUFormValidator()
    private(set) var formControlList: AUFormControlList =  AUFormControlList()
    
    ///Control that is focused on or is being edited by user. 
    ///For example: when you click on textfield textcontrol becomes active control
    private var activeControl : AUBaseFormView?
    
    private let accessoryView = AUInputAccessoryView()
    private var keyboardShown = false
    
    
    //MARK: Overriden members
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpFormTable()
        setUpAccessoryView()

        self.navigationController?.navigationBar.translucent = false
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.formControlList.addAccessoryView(self.accessoryView)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillBeShown:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillBeHidden:", name: UIKeyboardWillHideNotification, object: nil)
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.formControlList.endEditing()
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    
    //MARK: Public members
    
    /**
    Adds the control into the end of the form view
    
    :param: control an implemantation of AUBaseFormView
    */
    func getControlCount()->Int{
        return formControlList.count
    }
    func addControl(control : AUBaseFormView){
        control.behaviourDelegate = self
        self.formControlList.append(control)
        
        if let validator = control.controlValidation{
            formValidation.addValidator(validator)
        }
    }

    func insertControl(control:AUBaseFormView, atIndex index:Int){
        self.formControlList.insert(control, atIndex: index)
        
        if let validator = control.controlValidation{
            formValidation.addValidator(validator)
        }
    }
    
    func removeControl(control:AUBaseFormView){
        if let controlIndex = getControlIndexPath(control) {
            self.formControlList.remove(controlIndex.row)
            
            if let validator = control.controlValidation{
                formValidation.removeValidator(validator)
            }
        }
    }
    
    func validateForm()->Bool{
        return self.formValidation.validate()
    }
    
    func reloadForm(){
        self.formTableView.reloadData()
    }
    
    //MARK: Handle with notifications
    func keyboardWillBeShown(notification: NSNotification){
        if(!keyboardShown){
            if let userInfo: AnyObject = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey]{
                
                //TODO: consider about orientation(Landscape)
                let keyboardSize = userInfo.CGRectValue().size
                let contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0);
                
                self.formTableView.contentInset = contentInsets;
                self.formTableView.scrollIndicatorInsets = contentInsets;
                
                if let control = self.activeControl{
                    self.focusOnControl(control, inTable:self.formTableView)
                }
                
                self.keyboardShown = true

            }
        }
    }
    
    func keyboardWillBeHidden(notification: NSNotification){
        if(keyboardShown){
            if let userInfo: AnyObject = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey]{
                self.formTableView.contentInset = UIEdgeInsetsZero
                self.formTableView.scrollIndicatorInsets = UIEdgeInsetsZero
                
                self.keyboardShown = false
            }
        }
    }
    
    //MARK: Private members
    private func setUpFormTable(){
        self.formTableView.delegate = self;
        self.formTableView.dataSource = self;
        self.formTableView.removeSeperatorLines(.All)
        self.formTableView.allowsSelection = false
    }
    private func setUpAccessoryView(){
        self.accessoryView.delegate = self
    }
    
    private func getControlIndexPath(view:AUBaseFormView)->NSIndexPath?{
        if let controlIndex =  self.formControlList[view] {
            return NSIndexPath(forRow: controlIndex, inSection: 0)//There is no section in form pages.
        }
        
        return nil
    }
    
    
    private func focusOnControl(control: AUBaseFormView, inTable table:UITableView){
        if let activeControlIndex = getControlIndexPath(control){
            refreshAccessoryViewAppearance()

            //We use extra animation to overcome layout problem
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                table.scrollToRowAtIndexPath(activeControlIndex, atScrollPosition:  UITableViewScrollPosition.Bottom, animated: false)
            })
        }
    }
    
    private func removeControl(control:AUBaseFormView, fromTable table:UITableView){
        if let controlIndex = getControlIndexPath(control){
            removeControl(control)
            
            let reloadingRowIndexes = NSArray().arrayByAddingObject(controlIndex)
            table.deleteRowsAtIndexPaths(reloadingRowIndexes, withRowAnimation: .None)
        }
    }
    
    private func insertControl(control:AUBaseFormView, intoTable table:UITableView, atIndex index:NSIndexPath){
        insertControl(control, atIndex: index.row)
        
        let reloadingRowIndexes = NSArray().arrayByAddingObject(index)
        table.insertRowsAtIndexPaths(reloadingRowIndexes, withRowAnimation: .None)
    }

    private func reloadControl(view:AUBaseFormView, inTable table:UITableView){
        if let controlIndex = getControlIndexPath(view) {
            let reloadingRowIndexes = NSArray().arrayByAddingObject(controlIndex)
            table.reloadRowsAtIndexPaths(reloadingRowIndexes, withRowAnimation: .Fade)
        }
    }
    //MARK: Destruction
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}

//MARK: Extension for UITableViewDelegate
extension AUBaseFormController : UITableViewDelegate{
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let control = self.formControlList[indexPath.row]
        return CGFloat(control.getRowHeight())
    }
}

//MARK: Extension for UITableViewDataSource
extension AUBaseFormController : UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return formControlList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let control = self.formControlList[indexPath.row]
        
        var cell:UITableViewCell! = self.formTableView.dequeueReusableCellWithIdentifier(control.getReusableIdentifier()) as? UITableViewCell
        
        if(cell == nil){
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier:control.getReusableIdentifier())
        }
        cell.contentView.addSubview(control.view)
        control.updateUI()
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //println("You selected cell #\(indexPath.row)!")
    }
}

//MARK: Extension for AUFormViewBehaviour
extension AUBaseFormController : AUFormViewBehaviour{
    
    func formControlViewDidActivated(view:AUBaseFormView){
        self.activeControl = view
        
        if(keyboardShown){
            self.focusOnControl(view, inTable:self.formTableView)
        }
    }
}

//MARK: Extension for AccessoryViewDelegate
extension AUBaseFormController : AUCustomAccessoryViewDelegate{
    func accessoryViewPreviousAction(view:AUInputAccessoryView){
        self.formControlList.previousControl(self.activeControl!)?.becomeFirstResponder()
    }
    func accessoryViewNextAction(view:AUInputAccessoryView){
        self.formControlList.nextControl(self.activeControl!)?.becomeFirstResponder()
    }
    
    func refreshAccessoryViewAppearance(){
        
        if let activeControl = self.activeControl{
            if let nextControl = self.formControlList.nextControl(activeControl){
                self.accessoryView.setNextEnable(nextControl.hasAccessoryView())
            } else {
                self.accessoryView.setNextEnable(false)
            }
            
            if let previousControl = self.formControlList.previousControl(activeControl){
                self.accessoryView.setPreviousEnable(previousControl.hasAccessoryView())
            } else {
                self.accessoryView.setPreviousEnable(false)
            }
        }
    }
    
    func accessoryViewDoneAction(view:AUInputAccessoryView){
        self.activeControl!.endEditing(true)
    }

}
