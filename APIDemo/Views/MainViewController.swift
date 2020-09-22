//
//  MainViewController.swift
//  APIDemo
//
//  Created by trinh.hoang.hai on 9/21/20.
//  Copyright © 2020 trinh.hoang.hai. All rights reserved.
//

import UIKit
import RxSwift

class MainViewController: UIViewController {
    @IBOutlet weak var basicRequestButton: UIButton!
    @IBOutlet weak var apiRequestButton: UIButton!
    
    private let repo = DemoRepository()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func toBasicRequestAction(_ sender: Any) {
        basicRequest(headers: API.ghibliApi.header, url: API.ghibliApi.url, httpMethod: "GET")
    }
    
    @IBAction func toAPIRequestAction(_ sender: Any) {
        getFilmCollection()
    }
}

extension MainViewController {
    func basicRequest(headers: [String : String], url: String, httpMethod: String) {

        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = httpMethod
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { [weak self] (data, response, error) -> Void in
            if let error = error {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse!)
                if let data = data {
                    if let decodedResponse = try? JSONDecoder().decode([FilmResponse].self, from: data) {
                        DispatchQueue.main.async {
                            self?.navigateCollectionScreen(decodedResponse)
                        }
                        return
                    }
                }
            }
        })

        dataTask.resume()
    }
    
    func getFilmCollection() {
        repo.getFilmCollection().subscribe(
            onSuccess: { [weak self] result in
                self?.navigateCollectionScreen(result)
            }, onError: { [weak self] error in
                self?.handleAPIError(error: error)
            }
        ).disposed(by: disposeBag)
    }
    
    func handleAPIError(error: Error) {
        if let error = error as? APIErrorResponse {
            print(error.errorMessage!)
        }
    }
    
    func navigateCollectionScreen(_ data: [FilmResponse]) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ViewController") as? ViewController
        vc?.filmCollection = data
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
