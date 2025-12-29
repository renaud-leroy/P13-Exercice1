//
//  ListClientViewModelAddClientIntegrationTests.swift
//  RelayanceTests
//
//  Created by Renaud Leroy on 28/12/2025.
//

import XCTest
@testable import Relayance

@MainActor
final class ListClientViewModelAddClientIntegrationTests: XCTestCase {

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
    
    func test_GivenValidEmail_WhenAddingClient_ThenClientIsAddedToList() {
        // GIVEN
        let name = "John Doe"
        let email = "johndoe@example.com"
        
        // WHEN
        let success = vm.addClient(nom: name, email: email)
        
        // THEN
        XCTAssert(success)
        XCTAssertEqual(vm.clientsList.count, 1)
        XCTAssertEqual(vm.clientsList.first?.email, email)
    }
    
    func test_GivenExistingClient_WhenAddingClientWithSameEmail_ThenAddFails() {
        // GIVEN
        let existingClient = Client(nom: "John Doe", email: "johndoe@example.com", dateCreationString: "2022-03-10T10:45:00Z")
        let sameEmail = existingClient.email
        vm.clientsList = [existingClient]
        
        // WHEN
        let success = vm.addClient(nom: "Jane Smith", email: sameEmail)
        
        // THEN
        XCTAssertFalse(success)
    }
    
    func test_GivenInvalidEmail_WhenAddingClient_ThenNoClientIsAddedToList() {
        let name = "John Doe"
        let email = "invalid-email"
        
        let success = vm.addClient(nom: name, email: email)
        
        XCTAssertFalse(success)
    }
}
