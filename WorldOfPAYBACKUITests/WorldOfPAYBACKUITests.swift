//
//  WorldOfPAYBACKUITests.swift
//  WorldOfPAYBACKUITests
//
//  Created by Aliaksei Piatrynich on 16/04/2024.
//

import XCTest

final class WorldOfPAYBACKUITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTransactionFailing() throws {
        app.launchEnvironment = ["fail" : "1"]
        app.launch()
        
        sleep(5)
        
        XCTAssertTrue(app.staticTexts["error"].exists, "Expect error")
    }
    
    func testTransactionsSucceed() {
        app.launch()
        
        sleep(5)
        
        XCTAssertTrue(app.staticTexts["transaction"].exists, "Expect table of transactions")
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
