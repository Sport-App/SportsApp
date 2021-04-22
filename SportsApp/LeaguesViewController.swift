//
//  LeaguesViewController.swift
//  SportsApp
//
//  Created by Abanob Wadie on 21/04/2021.
//

import UIKit
import Alamofire
import SDWebImage

class LeaguesViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var leagueTableView: UITableView!
    
    var leagues = [League]()
    var leaguesDetails = [LeagueDetails]()
    var sportName = "Soccer"
    override func viewDidLoad() {
        super.viewDidLoad()

        getleagues()
    }

    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension LeaguesViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return leaguesDetails.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "league", for: indexPath) as! LeaguesTableViewCell
        
        let detail = leaguesDetails[indexPath.section]
        
        if let badge = detail.strBadge {
            cell.leagueImageView.sd_setImage(with: URL(string: badge), placeholderImage: UIImage(named: ""), options: .allowInvalidSSLCertificates, completed: nil)
        }
        
        if let name = detail.strLeague {
            cell.leagueNameLabel.text = name
        }
        
        cell.leagueYoutubeButton.tag = indexPath.section
        cell.leagueYoutubeButton.addTarget(self, action: #selector(youtubeAction(button:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func youtubeAction(button: UIButton){
        print(button.tag)
        
        let detail = leaguesDetails[button.tag]
        
        if var url = detail.strYoutube {
            url = "https://" + url
            UIApplication.shared.open(URL(string: url)!, options: [:], completionHandler: nil)
        }
    }
}

extension LeaguesViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
    }
}

extension LeaguesViewController {
    func getleagues() {
        AF.request(URLs.getLeagues)
        .validate()
        .responseDecodable(of: LeagueList.self) { (response) in
            switch response.result{
                case .success(_):

                    if let data = response.value {

                        self.leagues = data.leagues

                        self.leaguesDetails.removeAll()
                        for item in self.leagues {
                            if item.strSport == self.sportName {
                                self.getLeagueDetailsById(leagueId: item.idLeague)
                                
                            }
                        }

                    }
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    break
            }
        }
        
//        AF.request(URLs.getLeagues).responseJSON { (response) in
//            switch response.result{
//                case .success(_):
//
//                    if let res = response.value {
//                        let data = res as! [String:Any]
//                        self.leagues = data["leagues"] as! [[String:Any]]
//
//                        self.leaguesDetails.removeAll()
//                        for item in self.leagues {
//                            if item["strSport"] as! String == self.sportName {
//                                self.getLeagueDetailsById(leagueId: item["idLeague"] as! String)
//                            }
//                        }
//
//                    }
//                    break
//                case .failure(let error):
//                    print(error.localizedDescription)
//                    break
//            }
//        }
    }
    
    func getLeagueDetailsById(leagueId: String) {
        AF.request(URLs.getLeagueDetailsById + leagueId)
        .validate()
        .responseDecodable(of: LeagueDetailsList.self) { (response) in
            switch response.result{
                case .success(_):

                    if let data = response.value {
                        let details = data.leagues[0]
                        self.leaguesDetails.append(details)
                        self.leagueTableView.reloadData()
                    }
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    break
            }
        }
        
//        AF.request(URLs.getLeagueDetailsById + leagueId).responseJSON {  (response) in
//            switch response.result{
//                case .success(_):
//
//                    if let res = response.value {
//                        let data = res as! [String:Any]
//                        let details = (data["leagues"] as! [[String:Any]])[0]
//                        self.leaguesDetails.append(details)
//                        self.leagueTableView.reloadData()
//                    }
//                    break
//                case .failure(let error):
//                    print(error.localizedDescription)
//                    break
//            }
//        }
    }
}
