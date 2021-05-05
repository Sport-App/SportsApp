//
//  ViewController.swift
//  SportsApp
//
//  Created by Abanob Wadie on 19/04/2021.
//

import UIKit
import Lottie
class ViewController: UIViewController {

    @IBOutlet var animationView: AnimationView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        animationView.contentMode = .scaleAspectFit
         animationView.loopMode = .loop
         animationView.animationSpeed = 1
         animationView.play()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainScrean")
            vc!.modalPresentationStyle = .fullScreen
            self.present(vc!, animated: true, completion: nil)
        }
       
    }


}

