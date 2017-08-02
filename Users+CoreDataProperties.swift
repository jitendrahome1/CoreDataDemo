//
//  Users+CoreDataProperties.swift
//  CoreDataDM
//
//  Created by Jitendra on 8/2/17.
//  Copyright © 2017 Jitendra. All rights reserved.
//

import Foundation
import CoreData


extension Users {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Users> {
        return NSFetchRequest<Users>(entityName: "Users")
    }

    @NSManaged public var name: String?
    @NSManaged public var email: String?
    @NSManaged public var phone: Int64
    @NSManaged public var aboutUS: String?
    @NSManaged public var pin: Int64

}
