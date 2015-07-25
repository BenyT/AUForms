//
//  SampleFormPageTests.swift
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
class AUFormControlListTests:XCTestCase {
    
    var emptyList : AUFormControlList!
    var list : AUFormControlList!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        list = AUFormControlList()
        let control1 = CustomTextBoxView(title: "control1")
        list.append(control1)
        let control2 = CustomTextBoxView(title: "control2")
        list.append(control2)

        emptyList = AUFormControlList()
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
