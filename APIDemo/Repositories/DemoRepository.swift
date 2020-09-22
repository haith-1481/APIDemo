//
//  DemoRepository.swift
//  APIDemo
//
//  Created by trinh.hoang.hai on 9/17/20.
//  Copyright © 2020 trinh.hoang.hai. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class DemoRepository {
    let api = APIService()
    
    func getItem() -> Single<APIResponse<ItemResponse>> {
        return api.request(router: .getItem)
    }
    
    func getFilmCollection() -> Single<[FilmResponse]> {
        return api.request(router: .getFilmCollection)
    }
    
    func uploadItem(item: FilmResponse) -> Single<FilmResponse> {
        return api.upload(router: .postItem(item: item))
    }
}
