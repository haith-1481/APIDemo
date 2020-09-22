//
//  ViewController.swift
//  APIDemo
//
//  Created by trinh.hoang.hai on 9/16/20.
//  Copyright © 2020 trinh.hoang.hai. All rights reserved.
//

import UIKit
import RxSwift

private struct Constants {
    static let tableViewCellID = "TableViewCell"
}

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var filmCollection = [FilmResponse]()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
//        basicRequest(headers: API.imgurlApi.header, url: API.imgurlApi.url)
//        basicRequest(headers: API.ghibliApi.header, url: API.ghibliApi.url)
    }
    
    func setupUI() {
        tableView.register(UINib(nibName: Constants.tableViewCellID, bundle: nil), forCellReuseIdentifier: Constants.tableViewCellID)
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filmCollection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.updateUI(filmCollection[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
}

extension ViewController {
    
}
