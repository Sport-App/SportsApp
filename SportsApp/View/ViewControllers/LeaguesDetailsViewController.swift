//
//  LeaguesDetailsViewController.swift
//  SportsApp
//
//  Created by Abanob Wadie on 28/04/2021.
//

import UIKit
import SDWebImage

class LeaguesDetailsViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var upcomingCollectionView: UICollectionView!
    @IBOutlet weak var latestTableView: UITableView!
    @IBOutlet weak var teamsCollectionView: UICollectionView!
    
    var latestEvent = [Event]()
    var upcomingEvent = [Event]()
    var teams = [Team]()
    var viewModel: LeaguesDetailsViewModel!
    var leagueName = String()
    var leagueId = String()
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = LeaguesDetailsViewModel(leagueName: leagueName, leagueId: leagueId)
        viewModel.bindupcomingEventToView = didReceiveUpcomingEvent
        viewModel.bindlatestEventToView = didReceiveLatestEvent
        viewModel.bindTeamsToView = didReceiveTeams
        viewModel.bindErrortoView = didReceiveError
        viewModel.getTeams()
    }
    
    func didReceiveUpcomingEvent() {
        upcomingEvent = viewModel.upcomingEvent
        upcomingCollectionView.reloadData()
    }
    
    func didReceiveLatestEvent() {
        latestEvent = viewModel.latestEvent
        latestTableView.reloadData()
    }
    
    func didReceiveTeams() {
        viewModel.getEvents()
        
        teams = viewModel.teams
        teamsCollectionView.reloadData()
    }
    
    func didReceiveError() {
        let alert = UIAlertController(title: "Error", message: viewModel.error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func favAction(_ sender: Any) {
        if favBtn.tintColor == .red {
            favBtn.tintColor = .white
        }else{
            favBtn.tintColor = .red
        }
    }
}

extension LeaguesDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return latestEvent.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "latest", for: indexPath) as! LatestTableViewCell
        
        for item in teams {
            if item.idTeam == latestEvent[indexPath.row].idHomeTeam {
                if let badge = item.strTeamBadge {
                    cell.teamHomeImage.sd_setImage(with: URL(string: badge), completed: nil)
                }
            }
            
            else if item.idTeam == latestEvent[indexPath.row].idAwayTeam {
                if let badge = item.strTeamBadge {
                    cell.teamawayImage.sd_setImage(with: URL(string: badge), completed: nil)
                }
            }
        }
        cell.teamHomeLbl.text = latestEvent[indexPath.row].strHomeTeam
        cell.teamAwayLbl.text = latestEvent[indexPath.row].strAwayTeam
        cell.resultLbl.text = latestEvent[indexPath.row].intHomeScore! + "  VS  " + latestEvent[indexPath.row].intAwayScore!
        cell.dateLbl.text = latestEvent[indexPath.row].dateEvent
        
        return cell
    }
}

extension LeaguesDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case upcomingCollectionView:
            return upcomingEvent.count
        case teamsCollectionView:
            return teams.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case upcomingCollectionView:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upcoming", for: indexPath) as! UpcomingCollectionViewCell
            
            for item in teams {
                if item.idTeam == upcomingEvent[indexPath.row].idHomeTeam {
                    if let badge = item.strTeamBadge {
                        cell.teamHomeImage.sd_setImage(with: URL(string: badge), completed: nil)
                    }
                }
                
                else if item.idTeam == upcomingEvent[indexPath.row].idAwayTeam {
                    if let badge = item.strTeamBadge {
                        cell.teamawayImage.sd_setImage(with: URL(string: badge), completed: nil)
                    }
                }
            }
            cell.teamHomeLbl.text = upcomingEvent[indexPath.row].strHomeTeam
            cell.teamAwayLbl.text = upcomingEvent[indexPath.row].strAwayTeam
            cell.dateLbl.text = upcomingEvent[indexPath.row].dateEvent
            
            return cell
        case teamsCollectionView:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "team", for: indexPath) as! TeamsCollectionViewCell
            
            if let badge = teams[indexPath.row].strTeamBadge {
                cell.teamImage.sd_setImage(with: URL(string: badge), completed: nil)
            }
            cell.teamLbl.text = teams[indexPath.row].strTeam
            
            return cell
        default:
            return UICollectionViewCell()
        }
        
    }
}

extension LeaguesDetailsViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let d = (view.frame.width / 2) - 20
        return CGSize(width: d, height: d)
    }
}
