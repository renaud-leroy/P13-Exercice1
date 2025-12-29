//
//  ListClientViewModelDeleteClientIntegrationTests.swift
//  RelayanceTests
//
//  Created by Renaud Leroy on 29/12/2025.
//

import XCTest
@testable import Relayance

@MainActor
final class ListClientViewModelDeleteClientIntegrationTests: XCTestCase {

    var vm : ListClientsViewModel!
    
    override func setUp() {
        super.setUp()
        vm = ListClientsViewModel()
        vm.clientsList = []
    }
    
    override func tearDown() {
        vm = nil
        super.tearDown()
    }
    
    func test_GivenClientsList_WhenDeleteClient_ThenClientIsRemoved() {
        // GIVEN
        let client1 = Client(nom: "John Doe", email: "johndoe@example.com", dateCreationString: "2022-03-10T10:45:00Z")
        let client2 = Client(nom: "Jane Smith", email: "janesmith@example.com", dateCreationString: "2022-03-10T10:45:00Z")
        vm.clientsList = [client1, client2]
        
        // WHEN
        let success = vm.deleteClient(client: client1)
        
        // THEN
        XCTAssert(success)
        XCTAssertEqual(vm.clientsList.count, 1)
        XCTAssertEqual(vm.clientsList.first?.email, "janesmith@example.com")
    }

    func test_GivenEmptyClientsList_WhenDeleteClient_ThenNoChange() {
        // GIVEN
        
        
        // WHEN
        let success = vm.deleteClient(client: Client(nom: "John Doe", email: "johndoe@example.com", dateCreationString: "2022-03-10T10:45:00Z"))
        
        // THEN
        XCTAssertFalse(success)
        print("Nombre de clients :", vm.clientsList.count)
    }
}
