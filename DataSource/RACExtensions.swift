//
//  RACExtensions.swift
//  DataSource
//
//  Created by Vadim Yelagin on 16/07/15.
//  Copyright (c) 2015 Fueled. All rights reserved.
//

import Foundation
import ReactiveCocoa

public protocol Disposing: AnyObject {

	var disposable: CompositeDisposable { get }

}

public extension SignalProducerType {

	public func start<O: Disposing>(target: O, _ method: O -> Value -> ()) -> Disposable {
		let disposable = self.startWithNext {
			[weak target] value in
			if let target = target {
				method(target)(value)
			}
		}
		target.disposable += disposable
		return disposable
	}

}
