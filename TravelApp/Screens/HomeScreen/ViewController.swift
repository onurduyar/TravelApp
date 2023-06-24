//
//  ViewController.swift
//  TravelApp
//
//  Created by Onur Duyar on 22.06.2023.
//

import UIKit

class ViewController: UIViewController {
    let homeViewModel = HomeViewModel()
    var currentCity: WeatherElement?{
        didSet{
            print("ssss")
            print(currentCity ?? "nilll")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        homeViewModel.delegate = self
    }
}
extension ViewController: WeatherViewModelDelegate {
    func weatherDataDidChange(_ viewModel: HomeViewModel) {
        DispatchQueue.main.async {
            self.currentCity = viewModel.city
            print(self.currentCity ?? "nillllll")
        }
    }
    
    func weatherDataFetchDidFail(_ viewModel: HomeViewModel, withError error: Error) {
        DispatchQueue.main.async {
            print("trrkrjk")
        }
    }
    
  
}
