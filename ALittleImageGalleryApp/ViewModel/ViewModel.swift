//
//  ViewModel.swift
//  ALittleImageGalleryApp
//
//  Created by Sumair Zamir on 14/11/2020.
//

import Foundation

class ViewModel {
    
    var photoDataArray = [PhotoData]()
    var largeSquareArray = [Photosize]()
    var cellPhotoData = Data()
    
    enum Endpoints {
        static let base = "https://www.flickr.com/services/rest/?method="
        static let search = "flickr.photos.search"
        static let getSizes = "flickr.photos.getSizes"
        static let apiKey = "xxx"
        static let format = "&format=json&nojsoncallback=1"
        
        case searchPhotos(String)
        case getPhotoSizes(String)
        
        var urlString: String {
            switch self {
            case .searchPhotos(let searchText):
                return Endpoints.base + Endpoints.search + "&api_key=\(Endpoints.apiKey)" + "&tags=\(searchText)" + Endpoints.format
            case .getPhotoSizes(let photoId):
                return Endpoints.base + Endpoints.getSizes + "&api_key=\(Endpoints.apiKey)" + "&photo_id=\(photoId)" + Endpoints.format
            }
        }
        
        var url: URL {
            return URL.init(string: urlString)!
        }
    }
    
    func clearPhotoArrayData() {
        photoDataArray = []
        largeSquareArray = []
    }
    
    func appendArrayIfResponseReceived(response: Search?, error: Error?) {
        guard let response = response else {
            print("handlePhotosRequest error: \(error.debugDescription)")
            return
        }
        photoDataArray = response.photos.photo
    }
    
    func getSpecifiedSizeData(response: GetSizes?, error: Error?, photoSize: String) -> Photosize? {
        guard let response = response else {
            print("getSizeData error: \(error.debugDescription)")
            return nil
        }
        
        guard let photoData = response.sizes.size.first(where: {$0.label == photoSize}) else {
            print("Photo size reference not found")
            return nil
        }
        return photoData
    }
    
    func downloadPhotoData(photoData: Photosize) {
        do {
            cellPhotoData = try Data(contentsOf: URL.init(string: photoData.source)!)
        } catch {
            print("Download data error")
        }
    }
    
    func genericGETrequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completionHandler: @escaping (ResponseType?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    print("Error type 1: \(error.debugDescription)")
                    completionHandler(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let response = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completionHandler(response, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    print("Error type 2: \(error.localizedDescription)")
                    completionHandler(nil, error)
                }
            }
        }
        task.resume()
    }
    
    func getPhotos(searchText: String, completionHandler: @escaping (Search?, Error?) -> Void) {
        genericGETrequest(url: Endpoints.searchPhotos(searchText).url, responseType: Search.self) { (response, error) in
            guard let response = response else {
                print("getPhotos Error: \(error.debugDescription)")
                completionHandler(nil, error)
                return
            }
            completionHandler(response, nil)
        }
    }
    
    func getSizeData(photoId: String, completionHandler: @escaping (GetSizes?, Error?) -> Void) {
        genericGETrequest(url: Endpoints.getPhotoSizes(photoId).url, responseType: GetSizes.self) { (response, error) in
            guard let response = response else {
                print("getPhotos Error: \(error.debugDescription)")
                completionHandler(nil, error)
                return
            }
            completionHandler(response, nil)
        }
    }
    
}
