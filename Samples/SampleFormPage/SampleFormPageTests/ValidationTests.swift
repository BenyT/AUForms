//
//  POC_Tests.swift
//  POC Tests
//
//  Created by FormPageFramework on 18/03/15.
//  Copyright (c) 2015 ... All rights reserved.
//

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
