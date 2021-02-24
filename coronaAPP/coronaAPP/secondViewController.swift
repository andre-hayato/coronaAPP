//
//  secondViewController.swift
//  coronaAPP
//
//  Created by Aa Rr on 2021/02/21.
//

import UIKit

class secondViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{
    var coronaInfo2: [String] = []

    let tableView: UITableView = {
        let tv = UITableView()
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.frame.size = view.frame.size
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coronaInfo2.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel!.text = coronaInfo2[indexPath.row]
        //cell.textLabel!.textAlignment = NSTextAlignment.center
        return cell
    }
}

