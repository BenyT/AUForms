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
class ValidationTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testVTRequired() {
        let req = VTRequired()
        
        XCTAssertNotNil(req)
        
        XCTAssert(req.check("deneme"))
        
        XCTAssertFalse(req.check(nil))
        
        XCTAssertFalse(req.check(""))
    }
    
    func testVTMinimum(){
        let min = VTMinimum(baseValue: 1.0)
        
        XCTAssertNotNil(min)
        
        XCTAssert(min.check("2.0"))
        
        XCTAssert(min.check(1.0))
        
        XCTAssert(min.check(1))
        
        XCTAssertFalse(min.check("0.5"))
        
        XCTAssertFalse(min.check(0.5))
        
        XCTAssertFalse(min.check(0))
        
        
        
        let minWithClosure = VTMinimum { () -> (Double) in
            return 1.0
        }
        
        XCTAssertNotNil(minWithClosure)
        
        XCTAssert(minWithClosure.check("2.0"))
        
        XCTAssert(minWithClosure.check(1.0))
        
        XCTAssert(minWithClosure.check(1))
        
        XCTAssertFalse(minWithClosure.check("0.5"))
        
        XCTAssertFalse(minWithClosure.check(0.5))
        
        XCTAssertFalse(minWithClosure.check(0))

        
    }

    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
