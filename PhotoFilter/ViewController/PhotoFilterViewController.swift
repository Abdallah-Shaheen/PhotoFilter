//
//  PhotoFilterViewController.swift
//  PhotoFilter
//
//  Created by Abdallah Shaheen on 6/3/18.
//  Copyright © 2018 Me. All rights reserved.
//

import UIKit

class PhotoFilterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var headerViewTitle: UILabel!
    @IBOutlet weak var photosTableView: UITableView!
    @IBOutlet weak var filterDoneButton: UIButton!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    var filterDone = false
    
    var photosUrl = "https://jsonplaceholder.typicode.com/photos"
    var photosArray: [Photo] = []
    
    var selectedPhotosArray: [Photo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filterDoneButton.layer.cornerRadius = filterDoneButton.frame.height / 2
        loader.startAnimating()
        getPhotos()
    }
    
    //MARK:- Status bar prefer status
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK:- filter action
    @IBAction func filter(_ sender: UIButton) {
        headerViewTitle.text = "Filtered"
        filterDone = true
        filterDoneButton.isHidden = true
        photosArray = selectedPhotosArray
        photosTableView.reloadData()
    }
    
    
    //MARK:- get photos
    func getPhotos() {
        Service.sharedInstance.fetchData(url: photosUrl, success: { data in

            do {
                self.photosArray = try JSONDecoder().decode([Photo].self, from: data)
            }
            catch let error {
                print(error.localizedDescription)
            }
            
            DispatchQueue.main.async {
                self.loader.stopAnimating()
                self.loader.isHidden = true
                self.photosTableView.reloadData()
            }
        }, fail: { error in
            print("error")
            self.loader.stopAnimating()
            self.loader.isHidden = true
            self.photosTableView.reloadData()
        })
    }
    
    
    //MARK:- TableView data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photosArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PhotoCell.self)) as! PhotoCell
        
        let photo = photosArray[indexPath.row]
        let stateimage = photo.isSelected ? #imageLiteral(resourceName: "selected") : #imageLiteral(resourceName: "unselected")
        cell.configure(thumbnilUrl: photo.thumbnailUrl, title: photo.title, albumId: String(photo.albumId), stateImage: stateimage, filterDone: filterDone)
        return cell
    }
    
    //MARK:- TableView delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var photo = photosArray[indexPath.row]

        if photo.isSelected || selectedPhotosArray.count < 10{
            photo.isSelected =  !photo.isSelected
            photosArray.remove(at: indexPath.row)
            photosArray.insert(photo, at: indexPath.row)
            tableView.reloadRows(at: [indexPath], with: .fade)
            photoSelected(photo: photo)
        }
        else {
            let alert = UIAlertController(title: "", message: "the maxmum photos to select is ten", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: .default))
            self.present(alert, animated: true)
        }
        
        
    }
    
    
    //MARK:- Selected Photos
    func photoSelected(photo: Photo) {
        for (index, element) in selectedPhotosArray.enumerated() {
            if element.id == photo.id {
                selectedPhotosArray.remove(at: index)
                return
            }
        }
        selectedPhotosArray.append(photo)
    }
}

