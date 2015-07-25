//
//  BaseFormControllerTest.swift
//  FormPageFramework
//
//  Created by FormPageFramework on 28/06/15.
//  Copyright (c) 2015 ... All rights reserved.
//

import UIKit
import XCTest
import SampleFormPage

class BaseFormControllerTests:XCTestCase{

    var baseFormController : BaseFormController!
    var list : FormControlList!
    override func setUp() {
        super.setUp()
        
        
        baseFormController = BaseFormController()
        
        
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