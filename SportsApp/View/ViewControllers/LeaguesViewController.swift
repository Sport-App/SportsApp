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
    @IBOutlet weak var backView: UIButton!
    
    var leaguesDetails = [LeagueDetails]()
    var sportName = "Soccer"
    var viewModel: LeaguesViewModel!
    var type: ViewType = .fav
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(type == .details){
            reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(type == .fav){
            backView.isHidden = true
            
            reloadData()
        }
    }
    
    func reloadData() {
        viewModel = LeaguesViewModel(sportsName: sportName , type: type , appDelegate: UIApplication.shared.delegate as! AppDelegate)
        viewModel.bindLeaguestoView = didReceiveData
        viewModel.bindErrortoView = didReceiveError
        viewModel.getLeagues()
    }
    
    func didReceiveData() {
        leaguesDetails = viewModel.Leagues
        leagueTableView.reloadData()
    }
    
    func didReceiveError() {
        let alert = UIAlertController(title: "Error", message: viewModel.error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if Reachability.isConnectedToNetwork() {
            let vc = storyboard?.instantiateViewController(withIdentifier: "LeaguesDetailsViewController") as! LeaguesDetailsViewController
            vc.modalPresentationStyle = .fullScreen
            vc.leagueId = leaguesDetails[indexPath.section].idLeague
            vc.leagueName = leaguesDetails[indexPath.section].strLeague!
            vc.leagueDetails = leaguesDetails[indexPath.section]
            present(vc, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Sorry", message: "No internet connection", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
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
