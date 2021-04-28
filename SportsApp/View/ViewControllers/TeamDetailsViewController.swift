//
//  TeamDetailsViewController.swift
//  SportsApp
//
//  Created by ahmed on 4/28/21.
//

import UIKit
import SDWebImage

class TeamDetailsViewController: UIViewController {
    @IBOutlet weak var youtube: UIButton!
    @IBOutlet weak var tw: UIButton!
    @IBOutlet weak var fb: UIButton!
    @IBOutlet weak var secondIm: UIImageView!
    @IBOutlet weak var mainIm: UIImageView!
    @IBOutlet weak var teamTitle: UILabel!
    @IBOutlet weak var descData: UITextView!
    @IBOutlet weak var descTitle: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var stadium: UILabel!
    @IBOutlet weak var league: UILabel!
    @IBOutlet weak var stackv: UIStackView!
    @IBOutlet weak var indec: UIActivityIndicatorView!
    var team : Team?
    var teamId = "133604"
    var viewModel = TeamViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        teamTitle.isHidden = true
        descTitle.isHidden = true
        stackv.isHidden = true
        youtube.isHidden = true
        tw.isHidden = true
        fb.isHidden = true
        viewModel.getTeam(id: teamId)
        viewModel.bindTeamtoView = didReceiveData
        viewModel.bindErrortoView = didReceiveError
        // Do any additional setup after loading the view.
    }
    
    func didReceiveData() {
        teamTitle.isHidden = false
        descTitle.isHidden = false
        stackv.isHidden = false
        youtube.isHidden = false
        tw.isHidden = false
        fb.isHidden = false
        indec.stopAnimating()
        self.team = viewModel.team
        teamTitle.text = team?.name
        descData.text = team?.description
        league.text = team?.league
        stadium.text = team?.stadium
        country.text = team?.country
        mainIm.sd_setImage(with: URL(string: team!.imageMain), placeholderImage: UIImage(named: ""))
        secondIm.sd_setImage(with: URL(string: team!.imageSecond), placeholderImage: UIImage(named: ""))

    }
    
    @IBAction func youtubeAction(_ sender: Any) {
        if var url = team?.youtube{
            url = "https://" + url
            UIApplication.shared.open(URL(string: url)!, options: [:], completionHandler: nil)
        }
    }
    @IBAction func twAction(_ sender: Any) {
        if var url = team?.tw{
            url = "https://" + url
            UIApplication.shared.open(URL(string: url)!, options: [:], completionHandler: nil)
        }
    }
    @IBAction func fbAction(_ sender: Any) {
        if var url = team?.fb{
            url = "https://" + url
            UIApplication.shared.open(URL(string: url)!, options: [:], completionHandler: nil)
        }
        
    }
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    func didReceiveError() {
        indec.stopAnimating()
        let alert = UIAlertController(title: "Error", message: viewModel.error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
