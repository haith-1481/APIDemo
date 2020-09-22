//
//  TableViewCell.swift
//  APIDemo
//
//  Created by trinh.hoang.hai on 9/18/20.
//  Copyright © 2020 trinh.hoang.hai. All rights reserved.
//

import UIKit
import SDWebImage

class TableViewCell: UITableViewCell {
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func updateUI(_ item: FilmResponse) {
        titleLabel.text = item.title
        descriptionTextView.text = item.description

        guard let imageUrl = GhigbliFilm(rawValue: item.title ?? "")?.imageUrl else { return }
        itemImageView?.sd_setImage(with: URL(string: imageUrl), placeholderImage: #imageLiteral(resourceName: "826333") )
        
        itemImageView.contentMode = .scaleAspectFit

    }

}
