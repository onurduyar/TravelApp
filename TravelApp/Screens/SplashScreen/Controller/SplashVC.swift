//
//  SplashVC.swift
//  TravelApp
//
//  Created by Onur Duyar on 24.06.2023.
//

import UIKit

class SplashVC: UIViewController {
    let splashView = SplashView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = splashView
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let mainViewController = ViewController()
            mainViewController.modalTransitionStyle = .flipHorizontal
            mainViewController.modalPresentationStyle = .fullScreen
            
            let navigationController = UINavigationController(rootViewController: mainViewController)
            
            navigationController.modalTransitionStyle = .flipHorizontal
            navigationController.modalPresentationStyle = .fullScreen
            self.present(navigationController, animated: true)
        }
    }
}
