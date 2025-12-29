//
//  ListClientsViewModel.swift
//  Relayance
//
//  Created by Renaud Leroy on 23/12/2025.
//

import Foundation
import Observation

@MainActor
@Observable
final class ListClientsViewModel {
    var clientsList: [Client] = []
    
    init() {
        loadClients()
    }
    
    func loadClients() {
        clientsList = ModelData.chargement("Source.json")
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func addClient(nom: String, email: String) -> Bool {
        let normalizedEmail = email.lowercased()
        guard isValidEmail(normalizedEmail) else {
            return false
        }

        let newClient = Client.creerNouveauClient(nom: nom, email: normalizedEmail)

        guard !newClient.clientExiste(clientsList: clientsList) else {
            return false
        }

        clientsList.append(newClient)
        return true
    }
    
    func deleteClient(client: Client) -> Bool {
        let initialCount = clientsList.count
        clientsList.removeAll(where: { $0.email == client.email })
        guard initialCount > clientsList.count else {
            return false
        }
        return true
    }
}
