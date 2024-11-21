//
//  PersistenceController.swift
//  WeatherTestApp
//
//  Created by Alex Gav on 20.11.2024.
//

import CoreData

final class PersistenceController {
    
    static let shared = PersistenceController(modelName: "ImageCoreData")
    
    private(set) lazy var managedObjectContext = persistentContainer.viewContext
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: modelName)
        
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        }
        
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return container
    }()
    
    private let modelName: String
    private let favoritesKey = "FavoriteCities"
    
    private init(modelName: String) {
        self.modelName = modelName
    }
}

extension PersistenceController {
    
    func saveFavoriteCities(_ cities: [City]) {
        do {
            let data = try JSONEncoder().encode(cities)
            UserDefaults.standard.set(data, forKey: favoritesKey)
        } catch {
            print("Failed to save favorite cities: \(error)")
        }
    }
    
    func loadFavoriteCities() -> [City] {
        guard let data = UserDefaults.standard.data(forKey: favoritesKey) else {
            return []
        }
        
        do {
            let cities = try JSONDecoder().decode([City].self, from: data)
            return cities
        } catch {
            return []
        }
    }
    
    func saveContext() {
        guard managedObjectContext.hasChanges else { return }
        do {
            try managedObjectContext.save()
        } catch {
            fatalError("Unresolved error \(error)")
        }
    }
    
    func fetchCatImageHistory() -> [CatImage] {
        let fetchRequest: NSFetchRequest<CatImage> = CatImage.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "viewedAt", ascending: false)]
        
        do {
            return try managedObjectContext.fetch(fetchRequest)
        } catch {
            print("Failed to fetch cat image history: \(error)")
            return []
        }
    }
}
