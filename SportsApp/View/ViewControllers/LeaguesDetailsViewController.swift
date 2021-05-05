//
//  LeaguesDetailsViewController.swift
//  SportsApp
//
//  Created by Abanob Wadie on 28/04/2021.
//

import UIKit
import SDWebImage

class LeaguesDetailsViewController: UIViewController {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var upcomingLbl: UILabel!
    @IBOutlet weak var upcomingCollectionView: UICollectionView!
    @IBOutlet weak var latestLbl: UILabel!
    @IBOutlet weak var latestTableView: UITableView!
    @IBOutlet weak var teamsLbl: UILabel!
    @IBOutlet weak var teamsCollectionView: UICollectionView!
    
    var latestEvent = [Event]()
    var upcomingEvent = [Event]()
    var teams = [Teams]()
    var viewModel: LeaguesDetailsViewModel!
    var leagueName = String()
    var leagueId = String()
    var leagueDetails: LeagueDetails!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLbl.text = leagueName

        viewModel = LeaguesDetailsViewModel(leagueName: leagueName, leagueId: leagueId, appDelegate: UIApplication.shared.delegate as! AppDelegate)
        viewModel.bindupcomingEventToView = didReceiveUpcomingEvent
        viewModel.bindlatestEventToView = didReceiveLatestEvent
        viewModel.bindTeamsToView = didReceiveTeams
        viewModel.bindErrortoView = didReceiveError
        viewModel.getTeams()
        
        if viewModel.isFav(leaguesName: leagueName) {
            favBtn.tintColor = .red
        }else{
            favBtn.tintColor = .white
        }
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
            
            viewModel.deleteLeague(leagueName: leagueName)
        }else{
            favBtn.tintColor = .red
            
            viewModel.addLeague(league: leagueDetails)
        }
    }
}

extension LeaguesDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if latestEvent.count == 0 {
            latestTableView.isHidden = true
            latestLbl.isHidden = true
        }else{
            latestTableView.isHidden = false
            latestLbl.isHidden = false
        }
        
        return latestEvent.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "latest", for: indexPath) as! LatestTableViewCell
        
        for item in teams {
            if item.idTeam == latestEvent[indexPath.section].idHomeTeam {
                if let badge = item.strTeamBadge {
                    cell.teamHomeImage.sd_setImage(with: URL(string: badge), completed: nil)
                }
            }
            
            else if item.idTeam == latestEvent[indexPath.section].idAwayTeam {
                if let badge = item.strTeamBadge {
                    cell.teamawayImage.sd_setImage(with: URL(string: badge), completed: nil)
                }
            }
        }
        
        if let homeTeam = latestEvent[indexPath.section].strHomeTeam {
            cell.teamHomeLbl.text = homeTeam
        }
        
        if let teamAway = latestEvent[indexPath.section].strAwayTeam {
            cell.teamAwayLbl.text = teamAway
        }
        
        if let homeScore = latestEvent[indexPath.section].intHomeScore, let awayScore = latestEvent[indexPath.section].intAwayScore {
            cell.resultLbl.text = homeScore + "  VS  " + awayScore
        }
        
        cell.dateLbl.text = latestEvent[indexPath.section].dateEvent
        
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
            
            if upcomingEvent.count == 0 {
                upcomingCollectionView.isHidden = true
                upcomingLbl.isHidden = true
            }else{
                upcomingCollectionView.isHidden = false
                upcomingLbl.isHidden = false
            }
            
            return upcomingEvent.count
        case teamsCollectionView:
            
            if teams.count == 0 {
                teamsCollectionView.isHidden = true
                teamsLbl.isHidden = true
            }else{
                teamsCollectionView.isHidden = false
                teamsLbl.isHidden = false
            }
            
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
            
            if let homeTeam = upcomingEvent[indexPath.row].strHomeTeam {
                cell.teamHomeLbl.text = homeTeam
            }
            
            if let teamAway = upcomingEvent[indexPath.row].strAwayTeam {
                cell.teamAwayLbl.text = teamAway
            }
            
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case teamsCollectionView:
            let vc = storyboard?.instantiateViewController(withIdentifier: "TeamDetailsViewController") as! TeamDetailsViewController
            vc.modalPresentationStyle = .fullScreen
            vc.teamId = teams[indexPath.row].idTeam
            present(vc, animated: true, completion: nil)
            break
            
        default:
            break
        }
    }
}

extension LeaguesDetailsViewController : UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let d = (view.frame.width / 2) - 20
//        return CGSize(width: d, height: d)
//    }
}
