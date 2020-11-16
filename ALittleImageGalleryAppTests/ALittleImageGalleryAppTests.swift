//
//  ALittleImageGalleryAppTests.swift
//  ALittleImageGalleryAppTests
//
//  Created by Sumair Zamir on 15/11/2020.
//

import XCTest
@testable import ALittleImageGalleryApp

class ALittleImageGalleryAppTests: XCTestCase {
    
    let viewModel = ViewModel()
    
    override func setUpWithError() throws {
        super.setUp()
    }
    
    override func tearDownWithError() throws {
        super.tearDown()
    }
    
    func testLargeSizeDataResponseReceived() throws {
        let photoSize = "Large Square"
        let mockPhotoSize = Photosize(label: "Large Square", width: 0, height: 0, source: "xxx", url: "xxx", media: "xxx")
        let mockSizes = Sizes(canblog: 0, canprint: 0, candownload: 0, size: [mockPhotoSize])
        let mockGetSizes = GetSizes(sizes: mockSizes, stat: "xxx")
        
        let photoSizeLabel = viewModel.getSpecifiedSizeData(response: mockGetSizes, error: nil, photoSize: photoSize)?.label
        
        XCTAssertTrue(photoSizeLabel == photoSize)
    }
    
    func testInvalidSizeDataResponseReceived() throws {
        let photoSize = "Invalid size"
        let mockPhotoSize = Photosize(label: "Large Square", width: 0, height: 0, source: "xxx", url: "xxx", media: "xxx")
        let mockSizes = Sizes(canblog: 0, canprint: 0, candownload: 0, size: [mockPhotoSize])
        let mockGetSizes = GetSizes(sizes: mockSizes, stat: "xxx")
        
        let photoSizeLabel = viewModel.getSpecifiedSizeData(response: mockGetSizes, error: nil, photoSize: photoSize)?.label
        
        XCTAssertFalse(photoSizeLabel == photoSize)
    }
    
    func testGetPhotosResponseReceived() throws {
        let expect = expectation(description: "No JSON response received")
        let searchText = "Kittens"
        
        viewModel.getPhotos(searchText: searchText) { (response, error) in
            guard let response = response else {
                print("Error code 1: \(error.debugDescription)")
                return
            }
            XCTAssertNotNil(response)
            expect.fulfill()
        }
        wait(for: [expect], timeout: 5)
    }
    
    func testGetSizeDataResponseReceived() throws {
        let expect = expectation(description: "No JSON response received")
        let photoId = "50604768641"
        
        viewModel.getSizeData(photoId: photoId) { (response, error) in
            guard let response = response else {
                print("Error code 1: \(error.debugDescription)")
                return
            }
            XCTAssertNotNil(response)
            expect.fulfill()
        }
        wait(for: [expect], timeout: 5)
    }
    
}
