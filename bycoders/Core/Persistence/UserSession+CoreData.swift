//
//  UserSession+CoreData.swift
//  bycoders
//
//  Created by Aloisio Mello on 10/06/26.
//

import CoreData

@objc(UserSession)

public class UserSession: NSManagedObject {
    @NSManaged public var id: String?
    @NSManaged public var email: String?
    @NSManaged public var lastLatitude: String?
    @NSManaged public var lastLongitude: String?
}

extension UserSession {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserSession> {
        return NSFetchRequest<UserSession>(entityName: "UserSession")
    }
}
