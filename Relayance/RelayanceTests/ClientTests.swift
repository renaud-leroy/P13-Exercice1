//
//  ClientTests.swift
//  RelayanceTests
//
//  Created by Renaud Leroy on 23/12/2025.
//

import XCTest
@testable import Relayance

final class ClientTests: XCTestCase {
    
    func test_initClient_WhenWeValidData_ThenClientIsInit() {
        // GIVEN
        let nom = "JohnDoe"
        let email = "johndoe@example.com"
        let dateCreationString = "2025-12-23"
        
        // WHEN
        let client = Client(nom: nom, email: email, dateCreationString: dateCreationString)
        
        // THEN
        XCTAssertEqual(client.nom, nom)
        XCTAssertEqual(client.email, email)
        XCTAssertNotNil(client.formatDateVersString())
        XCTAssertNotNil(client.dateCreation)
    }
    
    func test_dateCreation_WhenValidStringProvided_ThenDateIsNotNil() {
        // GIVEN
        let client = Client(
            nom: "JohnDoe",
            email: "johndoe@example.com",
            dateCreationString: "2023-02-20"
        )

        // THEN
        XCTAssertNotNil(client.dateCreation)
    }
    
    func test_dateCreation_WhenInvalidStringProvided_ThenFallbackIsUsed() {
        // GIVEN
        let client = Client(
            nom: "JohnDoe",
            email: "johndoe@example.com",
            dateCreationString: "invalidDate"
        )

        // THEN
        XCTAssertNotNil(client.dateCreation)
    }
    
    func test_creerNouveauClient_WhenCalled_ThenClientHasTodayDate() {
        // GIVEN
        let nom = "JohnDoe"
        let email = "johndoe@example.com"
        
        // WHEN
        let client = Client.creerNouveauClient(nom: nom, email: email)
        
        // THEN
        XCTAssertEqual(client.nom, nom)
        XCTAssertEqual(client.email, email)
        XCTAssertTrue(client.estNouveauClient())
    }

    func test_formatDateVersString_WhenDateIsValid_ThenReturnFormattedString() {
        // GIVEN
        let client = Client(
            nom: "Test",
            email: "johndoe@example.com",
            dateCreationString: "2023-02-20"
        )

        // WHEN
        let formattedDate = client.formatDateVersString()

        // THEN
        XCTAssertFalse(formattedDate.isEmpty)
    }

//    func test_formatDateVersString_WhenDateIsInvalid_ThenReturnsOriginalString() {
//        // GIVEN
//        let invalidDate = "invalidDate"
//        let client = Client(
//            nom: "JohnDoe",
//            email: "johndoe@example.com",
//            dateCreationString: invalidDate
//        )
//
//        // WHEN
//        _ = client.formatDateVersString()
//
//        // THEN
//        XCTAssertTrue(Calendar.current.isDateInToday(client.dateCreation))  // À regarder
//    }

    func test_estNouveauClient_WhenDateIsToday_ThenReturnsTrue() {
        // GIVEN
        let client = Client.creerNouveauClient(
            nom: "JohnDoe",
            email: "johndoe@example.com"
        )

        // THEN
        XCTAssertTrue(client.estNouveauClient())
    }

    func test_estNouveauClient_WhenDateIsInPast_ThenReturnsFalse() {
        // GIVEN
        let client = Client(
            nom: "JohnDoe",
            email: "johndoe@example.com",
            dateCreationString: "2020-01-01"
        )

        // THEN
        XCTAssertFalse(client.estNouveauClient())
    }

    func test_clientExiste_WhenClientIsInList_ThenReturnsTrue() {
        // GIVEN
        let client1 = Client(
            nom: "JohnDoe",
            email: "johndoe@example.com",
            dateCreationString: "2023-02-20"
        )
        let clientsList = [client1]
        
        // WHEN
        _ = client1.clientExiste(clientsList: clientsList)

        // THEN
        XCTAssertTrue(client1.clientExiste(clientsList: clientsList))
    }

    func test_clientExiste_WhenClientIsNotInList_ThenReturnsFalse() {
        // GIVEN
        let client1 = Client(
            nom: "JohnDoe",
            email: "johndoe@example.com",
            dateCreationString: "2023-02-20"
        )
        let client2 = Client(
            nom: "JaneSmith",
            email: "janesmith@example.com",
            dateCreationString: "2023-02-20"
        )
        // WHEN
        _ = client1.clientExiste(clientsList: [client2])

        // THEN
        XCTAssertFalse(client1.clientExiste(clientsList: [client2]))
    }
   
}




