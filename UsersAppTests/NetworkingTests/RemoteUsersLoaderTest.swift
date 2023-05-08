//
//  RemoteUsersLoaderTest.swift
//  UsersAppTests
//
//  Created by Michael Alexander Rodriguez Urbina on 7/05/23.
//

import XCTest
import UsersApp

class HTTPClientSpy: HTTPClient {
    
    var requestedURLs = [URL]()
    var completions = [(HTTPClientResult) -> Void]()
    
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void) {
        completions.append(completion)
        requestedURLs.append(url)
    }
    
    func complete(with error: Error, at index: Int = 0) {
        completions[index](.failure(error))
    }
    
    func complete(withStatusCode code: Int, data: Data = Data(), at index: Int = 0) {
        let response = HTTPURLResponse(url: requestedURLs[index],
                                       statusCode: code,
                                       httpVersion: nil,
                                       headerFields: nil)!
        completions[index](.success(data, response))
    }
}

final class RemoteUsersLoaderTest: XCTestCase {
    
    var sut: RemoteUsersLoader!
    var client: HTTPClientSpy!
    var url: URL!

    override func setUp() {
        super.setUp()
        url = URL(string: "https://valid-url.com")!
        client = HTTPClientSpy()
        sut = RemoteUsersLoader(url: url, client: client)
    }

    override func tearDown() {
        client = nil
        sut = nil
       super.tearDown()
    }
    
    func test_load_requestUsersFromURL() {
        sut.load() { _ in }
        
        XCTAssertEqual(client.requestedURLs, [url])
    }
    
    func test_load_deliversErrorWhenClientFails() {
        let exp = expectation(description: "wait for result")
        var capturedResults = [RemoteUsersLoader.Result]()
        sut.load() { capturedResults.append($0)
            exp.fulfill()
        }
        
        let clientError = NSError(domain: "Test", code: 0)
        client.complete(with: clientError)
        
        wait(for: [exp], timeout: 1.0)
        
        XCTAssertEqual(capturedResults, [.failure(.connectivity)])
    }
    
    func test_load_deliversErrorWhenHTTPResponseIsDiferentTo200() {
        let exp = expectation(description: "wait for result")
        var capturedResults = [RemoteUsersLoader.Result]()
        sut.load { capturedResults.append($0)
            exp.fulfill()
        }
        
        client.complete(withStatusCode: 400)
        
        wait(for: [exp], timeout: 1.0)
        
        XCTAssertEqual(capturedResults, [.failure(.invalidData)])
    }
    
    func test_load_deliversErrorWhenResponseWithInvalidJSON(){
        let exp = expectation(description: "wait for result")
        var capturedResults = [RemoteUsersLoader.Result]()
        sut.load { capturedResults.append($0)
            exp.fulfill()
        }
        
        let invalidJSON = Data(bytes: "invalid json", count: 0)
        client.complete(withStatusCode: 200, data: invalidJSON)
        
        wait(for: [exp], timeout: 1.0)
        
        XCTAssertEqual(capturedResults, [.failure(.invalidData)])
    }
    
    func test_load_deliversItemsOn200HTTPResponseWithJSONItems() {
        let user1 = makeUser()
        let user1JSON = makeJSON(user: user1)
        
        let user2 = makeUser(id: 2, name: "another name")
        let user2JSON = makeJSON(user: user2)
        
        let itemsJSON = [user1JSON, user2JSON]
        
        let exp = expectation(description: "wait for result")
        var capturedResults = [RemoteUsersLoader.Result]()
        sut.load { capturedResults.append($0)
            exp.fulfill()
        }
        
        let json = try! JSONSerialization.data(withJSONObject: itemsJSON)
        client.complete(withStatusCode: 200, data: json)
        
        wait(for: [exp], timeout: 1.0)
        
        XCTAssertEqual(capturedResults, [.success([user1, user2])])
    }
    
    func test_load_afterTheSutHasBeenDeinitializedItShouldReturnNoResult() {
        var capturedResults = [RemoteUsersLoader.Result]()
        sut?.load { capturedResults.append($0)
        }
        
        sut = nil
        client.complete(withStatusCode: 200, data: Data(_: "[{}]".utf8))
        
        XCTAssertTrue(capturedResults.isEmpty)
    }
    
    //MARK: - Helpers
    
    private func makeUser(id: Int = 1, name: String = "a name", email: String = "a email", phone: String = "a number phone") -> Users {
        Users(id: id, name: name, email: email, phone: phone)
    }
    
    private func makeJSON(user: Users) -> [String: Any] {
        [
            "id": user.id,
            "name": user.name,
            "email": user.email,
            "phone": user.phone
        ]
    }
}
