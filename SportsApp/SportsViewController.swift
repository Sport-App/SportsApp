//
//  SportsViewController.swift
//  SportsApp
//
//  Created by ahmed on 4/21/21.
//

import UIKit
import Alamofire
import SDWebImage
class SportsViewController: UIViewController {
    private let reuseIdentifier = "Cell"
    var sports : [Sport] = []
    @IBOutlet weak var collection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getSports()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func getSports() {
        AF.request("https://www.thesportsdb.com/api/v1/json/1/all_sports.php")
            .validate()
            .responseDecodable(of: Sports.self) { (response) in
                switch response.result {
                
                case .success( _):
                    
                    guard let data = response.value else { return }
                    
                    self.sports = data.sports
                    self.collection.reloadData()
                case .failure(let error):
                    print(error)
                    
                }
            }
    }
    
    
}
extension SportsViewController : UICollectionViewDelegate {
}

extension SportsViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
       // #warning Incomplete implementation, return the number of sections
       return 1
   }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       // #warning Incomplete implementation, return the number of items
        return sports.count
   }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CustomSportsCollectionViewCell
        let  sport = sports[indexPath.item]
        
        cell.name.text = sport.name
        
        cell.image.sd_setImage(with: URL(string: sport.image), placeholderImage: UIImage(named: ""))
        cell.image.layer.cornerRadius = 15
        cell.layer.cornerRadius = 15
        
       return cell
   }
    
    
}
extension SportsViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let d = (view.frame.width / 2) - 20
        return CGSize(width: d, height: d)
    }
}
