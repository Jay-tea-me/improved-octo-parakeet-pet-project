//
//  AuthPublisher.swift
//  SoulMessage
//
//  Created by Justine Wright on 2021/07/08.
//

import Combine
import FirebaseAuth

extension Publishers {
    struct AuthPublisher: Publisher {
        typealias Output = User?
        typealias Failure = Never
        
        func receive<S>(subscriber: S) where S : Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
            let authSubscription = AuthSubscription(subscriber: subscriber)
            subscriber.receive(subscription: authSubscription)
        }
    }
    
    class AuthSubscription<S: Subscriber>: Subscription where S.Input == User?, S.Failure == Never {
        
        private var subscriber: S?
        private var handler: AuthStateDidChangeListenerHandle?
        
        init(subscriber: S) {
            self.subscriber = subscriber
            print("subscribing to Auth Sub")
            handler = Auth.auth().addStateDidChangeListener { (_, user) in
                _ = subscriber.receive(user)
            }
        }
        
        func request(_ demand: Subscribers.Demand) {}
        
        func cancel() {
            print("describing to Auth Sub")
            subscriber = nil
            handler = nil
        }
    }
}
