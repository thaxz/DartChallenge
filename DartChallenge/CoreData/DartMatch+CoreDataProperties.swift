//
//  DartMatch+CoreDataProperties.swift
//  DartChallenge
//
//  Created by thaxz on 14/10/23.
//
//

import Foundation
import CoreData


extension DartMatch {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DartMatch> {
        return NSFetchRequest<DartMatch>(entityName: "DartMatch")
    }

    @NSManaged public var dartStatus: NSObject?
    @NSManaged public var points: Int16
    @NSManaged public var timePassed: Int64

}

extension DartMatch : Identifiable {

}
