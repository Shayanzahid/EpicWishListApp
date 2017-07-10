//
//  ItemCell.swift
//  EpicWishListApp
//
//  Created by Shayan Zahid on 07/07/2017.
//  Copyright © 2017 Shayan Zahid. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell
{
    @IBOutlet weak var thumbImage: UIImageView!
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemDescription: UILabel!
    
    func configureCell(item: Item)
    {
        itemTitle.text = item.title
        itemPrice.text = "$\(item.price)"
        itemDescription.text = item.details
        thumbImage.image = item.toImage?.image as? UIImage
    }
    
//    var getItemTitle: String
//    {
//        if let item = item
//        {
//            return item.title!
//        }
//        return ""
//    }
}
