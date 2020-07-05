//
//  JTFeedUIInfoTests.swift
//  JetTravelTests
//
//  Created by Nishant Kumbhare on 05/07/20.
//  Copyright © 2020 DimpalBhendarkar. All rights reserved.
//

import XCTest

class JTFeedUIInfoTests: XCTestCase {

    var feedUIInfos: [JTFeedUIInfo] = []
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        if let path = Bundle(for: type(of: self)).path(forResource: "JTFeedResponse", ofType: "json") {
            do {
                let responseData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let utf8String = String(data: responseData, encoding: String.Encoding.utf8)
                guard let utf8Data = utf8String?.data(using: .utf8) else { return }
                let feed = try JSONDecoder().decode([JTFeed].self, from: utf8Data)
                let jsonArray = feed.compactMap{ JTFeedUIInfo.init(withFeed: $0) }
                self.feedUIInfos = jsonArray
            } catch let error {
                print(error)
            }
        }
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.feedUIInfos = []
    }

    func testGetLikes() {
        let object = self.feedUIInfos[0]
        XCTAssertEqual(object.getLikes(), "62.6K")
    }
    
    func testGetComments() {
        let object = self.feedUIInfos[0]
        XCTAssertEqual(object.getComments(), "8.2K")
    }
    
    func testGetTime() {
        let object = self.feedUIInfos[0]
        XCTAssertEqual(object.getTime(), "17 Apr 20")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
