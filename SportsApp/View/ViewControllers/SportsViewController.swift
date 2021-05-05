//
//  SportsViewController.swift
//  SportsApp
//
//  Created by ahmed on 4/21/21.
//

import UIKit
import Alamofire
import SDWebImage
import Lottie
class SportsViewController: UIViewController {
    
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var animationView: AnimationView!
    
    var sports = [Sport]()
    var viewModel = SportsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.getSports()
        viewModel.bindSportstoView = didReceiveData
        viewModel.bindErrortoView = didReceiveError
        collection.layer.cornerRadius = 15
       
    }
    override func viewWillAppear(_ animated: Bool) {
        animationView.contentMode = .scaleAspectFit
         animationView.loopMode = .loop
         animationView.animationSpeed = 3
         animationView.play()
    }
    func didReceiveData() {
        sports = viewModel.sports
        collection.reloadData()
    }
    
    func didReceiveError() {
        let alert = UIAlertController(title: "Error", message: viewModel.error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension SportsViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
       // #warning Incomplete implementation, return the number of sections
       return 1
   }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       // #warning Incomplete implementation, return the number of items
        return sports.count
   }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomSportsCollectionViewCell
        let  sport = sports[indexPath.item]
        
        cell.name.text = sport.name
        
        cell.image.sd_setImage(with: URL(string: sport.image), placeholderImage: UIImage(named: ""))
        cell.image.layer.cornerRadius = 15
        cell.layer.cornerRadius = 15
        
       return cell
   }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "LeaguesViewController") as! LeaguesViewController
        vc.modalPresentationStyle = .fullScreen
        vc.sportName = sports[indexPath.item].name
        vc.type = .details
        present(vc, animated: true, completion: nil)
    }
    
}
extension SportsViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let d = (view.frame.width / 2) - 20
        return CGSize(width: d, height: d)
    }
}
