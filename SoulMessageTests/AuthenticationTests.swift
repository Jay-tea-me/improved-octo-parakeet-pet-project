//
//  Authentication_Tests.swift
//  SoulMessageTests
//
//  Created by Justine Wright on 2021/07/19.
//

import XCTest
import Combine

extension XCTestCase {
    func await<T: Publisher>(
        _ publisher: T,
        timeout: TimeInterval = 10,
        file: StaticString = #file,
        line: UInt = #line
    ) throws -> T.Output {
        // This time, we use Swift's Result type to keep track
        // of the result of our Combine pipeline:
        var result: Result<T.Output, Error>?
        let expectation = self.expectation(description: "Awaiting publisher")

        let cancellable = publisher.sink(
            receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    result = .failure(error)
                case .finished:
                    break
                }

                expectation.fulfill()
            },
            receiveValue: { value in
                result = .success(value)
            }
        )

        // Just like before, we await the expectation that we
        // created at the top of our test, and once done, we
        // also cancel our cancellable to avoid getting any
        // unused variable warnings:
        waitForExpectations(timeout: timeout)
        cancellable.cancel()

        // Here we pass the original file and line number that
        // our utility was called at, to tell XCTest to report
        // any encountered errors at that original call site:
        let unwrappedResult = try XCTUnwrap(
            result,
            "Awaited publisher did not produce any output",
            file: file,
            line: line
        )

        return try unwrappedResult.get()
    }
}

class AuthenticationTests: XCTestCase {
    var appState: AppState!
    var mockAuthService: MockAuthenticationService!

    override func setUp() {
        mockAuthService = MockAuthenticationService()
        appState = AppState(authenticationService: mockAuthService)
    }

    func testSignOutStateChangesToSignInStateWhenServerDetectsUserSignIn() throws {
        let changedStatePub = appState.$isSignedIn
            .collect(1)
            .first()

        mockAuthService.serverStateSub.send(User())

        let changedState = try `await`(changedStatePub)
        XCTAssertEqual(changedState.count, 1)
        XCTAssertEqual(changedState.first, true)
    }

    func testSignInStateChangesToSignOutStateWhenServerDetectsUserSignOut() throws {
        let changedStatePub = appState.$isSignedIn
            .collect(1)
            .first()

        // sign in
        mockAuthService.serverStateSub.send(User())
        var changedState = try `await`(changedStatePub)

        // sign out
        mockAuthService.serverStateSub.send(nil)
        changedState = try `await`(changedStatePub)

        XCTAssertEqual(changedState.count, 1)
        XCTAssertEqual(changedState.last, false)
    }

    func testWhenStartingUpAppAndInSignedStateOnServerThenAppIsSignedIn() throws {
        let changedStatePub = appState.$isSignedIn
            .collect(1)
            .first()

        mockAuthService.currentUserSub.send(User())
        let changedState = try `await`(changedStatePub)

        XCTAssertEqual(changedState.count, 1)
        XCTAssertEqual(changedState.first, true)
    }

    func testWhenStartingUpAppAndInSignedStateOutServerThenAppIsSignedOut() throws {
        let changedStatePub = appState.$isSignedIn
            .collect(1)
            .first()

        mockAuthService.currentUserSub.send(nil)
        let changedState = try `await`(changedStatePub)

        XCTAssertEqual(changedState.count, 1)
        XCTAssertEqual(changedState.first, false)
    }

}
