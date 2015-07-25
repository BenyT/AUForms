//
//  FormControlTests.swift
//  FormPageFramework
//
//  Created by FormPageFramework on 04/06/15.
//  Copyright (c) 2015 ... All rights reserved.
//
import UIKit
import XCTest
import SampleFormPage
class FormControlListTests:XCTestCase {
    
    var emptyList : FormControlList!
    var list : FormControlList!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        list = FormControlList()
        let control1 = CustomTextBoxView(title: "control1")
        list.append(control1)
        let control2 = CustomTextBoxView(title: "control2")
        list.append(control2)

        emptyList = FormControlList()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testControlCount() {
        
        XCTAssertEqual(emptyList.count, 0)
        
        XCTAssertEqual(list.count, 2)
        
    }
    
    func testGetIndexSubscription(){

        XCTAssertNotNil(list[0])
        XCTAssert(list[0].title == "control1")
        
        //Check if added control references true index
        let newControl = CustomTextBoxView(title:"test")
        emptyList.append(newControl)
        XCTAssertEqual(emptyList[0], newControl)
    }
    
    func testGetControlSubscription(){
        let newControl = CustomTextBoxView(title:"test")
        emptyList.append(newControl)
        
        XCTAssertNotNil(emptyList[newControl])
        XCTAssert(emptyList[newControl] == 0)
    }
    
    func testNextControl(){
        let c1 = list[0]
        let c2 = list[1]
        
        XCTAssertNotNil(list.nextControl(c1))
        XCTAssertEqual(c2, list.nextControl(c1)!)
        XCTAssertNil(list.nextControl(c2))
    }
    
    func testPreviousControl(){
        let c1 = list[0]
        let c2 = list[1]
        
        XCTAssertNotNil(list.previousControl(c2))
        XCTAssertEqual(c1, list.previousControl(c2)!)
        XCTAssertNil(list.previousControl(c1))
        
    }

}
