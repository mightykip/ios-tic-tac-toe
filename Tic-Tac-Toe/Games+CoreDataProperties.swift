//
//  Games+CoreDataProperties.swift
//  Tic-Tac-Toe
//
//  Created by Kip Lawrence on 11/16/16.
//  Copyright © 2016 Kip Lawrence. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Games {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Games> {
        return NSFetchRequest<Games>(entityName: "Games");
    }

    @NSManaged public var player: Int16
    @NSManaged public var winner: Bool

}
