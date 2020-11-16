//
//  Model.swift
//  ALittleImageGalleryApp
//
//  Created by Sumair Zamir on 14/11/2020.
//

import Foundation

struct Search: Codable {
    let photos: Photos
    let stat: String
}

struct Photos: Codable {
    let page: Int
    let pages: Int
    let perpage: Int
    let total: String
    let photo: [PhotoData]
}

struct PhotoData: Codable {
    let id: String
    let owner: String
    let secret: String
    let server: String
    let farm: Int
    let title: String
    let ispublic: Int
    let isfriend: Int
    let isfamily: Int
}

struct GetSizes: Codable {
    let sizes: Sizes
    let stat: String
}

struct Sizes: Codable {
    let canblog: Int
    let canprint: Int
    let candownload: Int
    let size: [Photosize]
}

struct Photosize: Codable {
    let label: String
    let width: Int
    let height: Int
    let source: String
    let url: String
    let media: String
}
