//
//  CatImage+CoreData.swift
//  WeatherTestApp
//
//  Created by Alex Gav on 20.11.2024.
//
//

import CoreData

public final class CatImage: NSManagedObject {}

extension CatImage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CatImage> {
        NSFetchRequest<CatImage>(entityName: "CatImage")
    }

    @NSManaged public var viewedAt: Date?
    @NSManaged public var id: String?
    @NSManaged public var imageData: Data?
}

extension CatImage: Identifiable {}
