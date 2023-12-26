//
//  DataCleaningTest.swift
//  GiphyAppTests
//
//  Created by Denis Chernovs on 26/12/2023.
//

import XCTest
@testable import GiphyApp

final class DataCleaningTest: XCTestCase {
    
    var vm: GiphyViewModel!
    
    override func setUp() {
        super.setUp()
        vm = GiphyViewModel()
        var data1 = Datum(id: "Test", username: "Test", title: "Test", images: Images(original: FixedHeight(height: "Test", width: "Test", url: "Test")), import_datetime: "Test", url: "Test")
        var data2 = Datum(id: "Test", username: "Test", title: "Test", images: Images(original: FixedHeight(height: "Test", width: "Test", url: "Test")), import_datetime: "Test", url: "Test")
        var data3 = Datum(id: "Test", username: "Test", title: "Test", images: Images(original: FixedHeight(height: "Test", width: "Test", url: "Test")), import_datetime: "Test", url: "Test")
        
        vm.giphyData = [data1, data2, data3]
    }
    
    func testCleanGiphy() {
        XCTAssertFalse(vm.giphyData.isEmpty, "giphyData should not be empty before cleaning")
        vm.cleanGiphy()
        XCTAssertTrue(vm.giphyData.isEmpty, "giphyData should be empty after cleaning")
    }
    
}
