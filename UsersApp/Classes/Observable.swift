//
//  Observable.swift
//  UsersApp
//
//  Created by Michael Alexander Rodriguez Urbina on 7/05/23.
//

import Foundation

class Observable<T> {
    
    private var listener: ((T?) -> Void)? //Each Box can have a Listener that Box notifies when the value changes.
    
    var value: T? { //Observable has a generic type value. The didSet property observer detects any changes and notifies Listener of any value update.
        didSet {
            DispatchQueue.main.async {
                self.listener?(self.value)
            }
        }
    }
    
    init( _ value: T?) {
        self.value = value //The initializer sets Observable initial value.
    }
    
    //4 When a Listener calls bind(listener:) on Observable, it becomes Listener and immediately gets notified of the Observable‘s current value.
    func bind( _ listener: @escaping ((T?) -> Void)) {
        self.listener = listener
        listener(value)
    }
}
