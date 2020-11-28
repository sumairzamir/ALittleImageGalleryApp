//
//  ViewController.swift
//  ALittleImageGalleryApp
//
//  Created by Sumair Zamir on 14/11/2020.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    
    let viewClass = View()
    let viewModel = ViewModel()
    let specifiedSize = StringConstants.specifiedSize.value
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = viewClass
        configureCollectionView()
        configureSearchBar()
    }
    
    func configureSearchBar() {
        viewClass.searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(getPhotos), object: searchBar)
        perform(#selector(getPhotos(_:)), with: searchBar, afterDelay: Double(FloatConstants.searchEntryDelay.value))
    }
    
    @objc func getPhotos(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            print("searchText entry error")
            return
        }
        
        if searchText == "" {
            viewModel.clearPhotoArrayData()
            viewClass.collectionView.reloadData()
        } else {
            viewModel.getPhotos(searchText: searchText, completionHandler: handlePhotosRequest(response:error:))
        }
    }
    
    func handlePhotosRequest(response: Search?, error: Error?) {
        viewModel.appendArrayIfResponseReceived(response: response, error: error)
        self.viewClass.collectionView.reloadData()
    }
    
}

extension ViewController {
    
    func configureCollectionView() {
        viewClass.collectionView.delegate = self
        viewClass.collectionView.dataSource = self
        viewClass.collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.photoDataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        let photoData = viewModel.photoDataArray[indexPath.row]
        appendImageDataToCell(photoData: photoData, cell: cell)
        return cell
    }
    
    func appendImageDataToCell(photoData: PhotoData, cell: CollectionViewCell) {
        viewModel.getSizeData(photoId: photoData.id) { (response, error) in
            guard let specifiedSizeData = self.viewModel.getSpecifiedSizeData(response: response, error: error, photoSize: self.specifiedSize) else {
                print("SpecifiedSize Data error")
                return
            }
            self.viewModel.downloadPhotoData(photoData: specifiedSizeData)
            let imageData = UIImage(data: self.viewModel.cellPhotoData)
            cell.cellImageView.image = imageData
        }
    }
    
}
