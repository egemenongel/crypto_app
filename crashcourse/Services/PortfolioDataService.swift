//
//  PortfolioDataService.swift
//  crashcourse
//
//  Created by Egemen Öngel on 22.05.2024.
//

import Foundation
import CoreData

class PortfolioDataService {

    private let container: NSPersistentContainer
    private let containerName: String = "PortfolioContainer"
    private let entityName: String = "PortfolioEntity"

    @Published var savedEntities: [PortfolioEntity] = []

    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Error loading Core Data! \(error)")
            }
            self.getPortfolio()
        }
    }

    func updatePortfolio(coin: Coin, amount: Double) {

        if let entity = savedEntities.first(where: { $0.coinId == coin.id?.description}){
            print("id \(coin.id?.description ?? "def")")
            if amount > 0 {
                update(entity: entity, amount: amount)
            }
            else{
                delete(entity: entity)
            }
        } else {
            add(coin: coin, amount: amount)
        }
    }

    private func getPortfolio() {
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        do {
            savedEntities = try container.viewContext.fetch(request)
            print("fetched")
            print(savedEntities.count)
        } catch let error {
            print("Error fetching Portfolio Entities. \(error)")
        }
    }

    private func add(coin: Coin, amount: Double){
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinId = coin.id?.description
        print("id \(coin.id?.description ?? "def")")
        entity.amount = amount
        print("Added")
        applyChanges()
    }

    private func update(entity: PortfolioEntity, amount: Double) {
        entity.amount = amount
        applyChanges()
    }

    private func delete(entity: PortfolioEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }

    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving to Core Data. \(error)")
        }
    }

    private func applyChanges() {
        save()
        getPortfolio()
    }

}
