//
//  FormControlList.swift
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

class FormControlList{
    private var controlList = [BaseFormView]()
    
    func append(item:BaseFormView){
        self.controlList.append(item)
    }
    
    func insert(item:BaseFormView, atIndex index:Int){
        self.controlList.insert(item, atIndex: index)
    }
    
    func remove(index:Int){
        self.controlList.removeAtIndex(index)
    }
    
    
    
    var count:Int{
        return self.controlList.count
    }
    
    ///Resign first responder of all controls
    func endEditing(){
        for control in self{
            control.endEditing(true)
        }
    }
    
    ///Adds given accessory view for all controls
    func addAccessoryView(accessoryView:CustomInputAccessoryView){
        for control in self{
            accessoryView.owner = control
            control.setInputAccessoryView(accessoryView.view)
        }
    }
    
    ///Returns index of given control
    subscript(control:BaseFormView) -> Int?{
        return Swift.find(self, control)
    }
    
    ///Returns next control of currently active control
    func nextControl(control:BaseFormView)->BaseFormView?{
        if let index = self[control] {
            let nextControlIndex = index + 1
            if (self.count > nextControlIndex ){
                return self[nextControlIndex]
            }
        }
        
        return nil
    }
    
    ///Returns previous control of currently active control
    func previousControl(control:BaseFormView)->BaseFormView?{
        if let index = self[control] {
            let previousControlIndex = index - 1
            if (previousControlIndex >= 0){
                return self[previousControlIndex]
            }
        }
        
        return nil
    }

}

extension FormControlList : CollectionType{
    typealias Index = Int
    
    var startIndex: Int {
        return 0
    }
    
    var endIndex: Int {
        return controlList.count
    }
    
    subscript(i: Int) -> BaseFormView {
        return controlList[i]
    }
    
    typealias Generator = GeneratorOf<BaseFormView>
    
    func generate() -> Generator {
        var index = 0
        return GeneratorOf {
            if index < self.controlList.count {
                return self.controlList[index++]
            }
            return nil
        }
    }
}