//
//  MenuViewController.swift
//  Unitly
//
//  Created by FGT MAC on 8/27/20.
//  Copyright © 2020 FGT MAC. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    //MARK: - Properties
    var tableView: UITableView!

    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Setup UI
    func configureTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
    }

}

    //MARK: - UITableViewDataSource
extension MenuViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
}

    //MARK: - UITableViewDelegate
extension MenuViewController: UITableViewDelegate{
    
}
