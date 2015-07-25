//
//  AUBaseFormControllerTest.swift
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
import XCTest
import SampleFormPage

class AUBaseFormControllerTests:XCTestCase{

    var baseFormController : AUBaseFormController!
    var list : AUFormControlList!
    override func setUp() {
        super.setUp()
        
        
        baseFormController = AUBaseFormController()
        
        
    }
    
    func testAddControl_OneTextBoxControl(){
        
        var count = 0
        XCTAssert(baseFormController.getControlCount() == count)
        
        let control = CustomTextBoxView(title: "newControl1")
        baseFormController.addControl(control)
        
        count = count + 1
        XCTAssert(baseFormController.getControlCount() == count)
        XCTAssert(baseFormController.formControlList[0] === control)
        XCTAssertNotNil(control.behaviourDelegate)
        XCTAssert(baseFormController === control.behaviourDelegate!)
        
    }

    
    func testInsertControl_OneTextBoxControlInEmptyList(){
        
        XCTAssert(baseFormController.getControlCount() == 0)
        
        let control = CustomTextBoxView(title: "newControl1")
        baseFormController.insertControl(control, atIndex: 0)
        
        XCTAssert(baseFormController.getControlCount() ==  1)
        XCTAssert(baseFormController.formControlList[0] === control)
    }
    
    func testInsertControl_OneTextBoxControlAt1stElementInNonEmptyList(){
        
        XCTAssert(baseFormController.getControlCount() == 0)
        
        let control = CustomTextBoxView(title: "newControl1")
        baseFormController.addControl(control)
       
        
        let control2 = CustomTextBoxView(title: "newControl2")
        baseFormController.insertControl(control2, atIndex: 0)
        
        XCTAssert(baseFormController.getControlCount() == 2)
        XCTAssert(baseFormController.formControlList[0] === control2)
        
    }
    

}