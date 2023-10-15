//
//  DartMatch+CoreDataProperties.swift
//  DartChallenge
//
//  Created by thaxz on 14/10/23.
//
//

import Foundation
import CoreData

// todo: ID that starts in 0


extension DartMatch {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DartMatch> {
        return NSFetchRequest<DartMatch>(entityName: "DartMatch")
    }

    @NSManaged public var points: Int16
    @NSManaged public var timePassed: Int64
    @NSManaged public var id: Int16
    @NSManaged public var dartStatus: [NSNumber]

}

extension DartMatch : Identifiable {

}

