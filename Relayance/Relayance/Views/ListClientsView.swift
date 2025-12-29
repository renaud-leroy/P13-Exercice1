//
//  ListClientsView.swift
//  Relayance
//
//  Created by Amandine Cousin on 10/07/2024.
//

import SwiftUI

struct ListClientsView: View {
    let vm: ListClientsViewModel
    @State private var showModal: Bool = false
    
    var body: some View {
        NavigationStack {
            List(vm.clientsList, id: \.self) { client in
                NavigationLink {
                    DetailClientView(vm: vm, client: client)
                } label: {
                    Text(client.nom)
                        .font(.title3)
                }
            }
            .navigationTitle("Liste des clients")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Ajouter un client") {
                        showModal.toggle()
                    }
                    .foregroundStyle(.orange)
                    .bold()
                }
            }
            .sheet(isPresented: $showModal, content: {
                AjoutClientView(vm: vm, dismissModal: $showModal)
            })
        }
    }

}

#Preview {
    ListClientsView(vm: .init())
}
