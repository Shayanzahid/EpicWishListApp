//
//  Item+CoreDataClass.swift
//  EpicWishListApp
//
//  Created by Shayan Zahid on 07/07/2017.
//  Copyright © 2017 Shayan Zahid. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData

public class Item: NSManagedObject
{
    public override func awakeFromInsert()
    {
        super.awakeFromInsert()
        
        self.created = NSDate()
    }
}
