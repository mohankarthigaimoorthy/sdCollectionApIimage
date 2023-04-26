//
//  ViewController.swift
//  sdCollectionWebImage
//
//  Created by Mohan K on 13/02/23.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    var dogAllData:DogData?
    var dogImageAllLinks = [String]()
    
    @IBOutlet weak var myCollectionView: UICollectionView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchData()
    }
    func fetchData() {
        let url = URL(string: "https://dog.ceo/api/breed/hound/images")
        let task = URLSession.shared.dataTask(with: url!, completionHandler:{
            (data,response, error) in
            guard let data = data, error == nil else
            {
                print("Error Occured while Accessing Data")
                return
            }
            var dogObject:DogData?
            do{
                dogObject = try JSONDecoder().decode(DogData.self, from: data)
                
            }
            catch {
                print("Error While Decoding JSon into swift structure \(error)")
                
            }
            self.dogAllData = dogObject
            self.dogImageAllLinks = self.dogAllData!.message
            DispatchQueue.main.async {
                self.myCollectionView.reloadData()
            }
        })
        task.resume()
    }


}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dogImageAllLinks.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: "myCollectionViewCell", for: indexPath) as! myCollectionViewCell
        if let imageURL = URL(string: dogImageAllLinks[indexPath.row])
        {
            cell.myImg.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.myImg.sd_imageIndicator?.startAnimatingIndicator()
            cell.myImg.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "empty"), options: .continueInBackground, completed: nil)
            cell.myImg.contentMode = .scaleToFill
            cell.myImg.layer.cornerRadius = cell.myImg.layer.frame.width / 2
        }
        else {
            print ("Invalid URL - No Image")
            cell.myImg.image = UIImage(named: "empty")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.size.width-0) / 2
        return CGSize(width: size, height: size)
    }
}
