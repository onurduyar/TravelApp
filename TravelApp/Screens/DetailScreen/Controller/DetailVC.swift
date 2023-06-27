//
//  DetailVC.swift
//  TravelApp
//
//  Created by Onur Duyar on 27.06.2023.
//

import UIKit

final class DetailVC: UIViewController {
    let detailView = DetailView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view = detailView
        detailView.tableView.delegate = self
        detailView.tableView.dataSource = self
    }
}
// MARK: - UITableViewDelegate
extension DetailVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
}
// MARK: - UITableViewDataSource
extension DetailVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! DetailCell
        cell.detailText = "sasa\(indexPath.row)"
        cell.image = UIImage(named: "restaurant_icon")
        return cell
    }
    
    
}
