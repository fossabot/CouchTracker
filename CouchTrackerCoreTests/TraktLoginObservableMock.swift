import RxSwift
@testable import CouchTrackerCore

final class TraktLoginObservableMock: TraktLoginObservable {
	private let stateSubject: BehaviorSubject<TraktLoginState>

	init(state: TraktLoginState) {
		self.stateSubject = BehaviorSubject(value: state)
	}

	func observe() -> Observable<TraktLoginState> {
		return stateSubject.asObservable()
	}

	func changeTo(state: TraktLoginState) {
		stateSubject.onNext(state)
	}
}