//
//  Persistence.swift
//  bycoders
//
//  Created by Aloisio Mello on 09/06/26.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    static let preview = PersistenceController(inMemory: true)
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "bycoders")
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { _, error in
            if let error {
                fatalError("CoreData failed to load \(error)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
