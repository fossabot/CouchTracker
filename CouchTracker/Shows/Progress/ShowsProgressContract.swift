import RxSwift
import TraktSwift

protocol ShowsProgressRepository: class {
  func fetchWatchedShows(update: Bool, extended: Extended) -> Observable<WatchedShowEntity>
}

protocol ShowsProgressInteractor: class {
  init(repository: ShowsProgressRepository, schedulers: Schedulers)

  func fetchWatchedShowsProgress(update: Bool) -> Observable<WatchedShowEntity>
}

protocol ShowsProgressRouter: class {
  func show(tvShow entity: WatchedShowEntity)
}

protocol ShowsProgressPresenter: class {
  var dataSource: ShowsProgressViewDataSource { get }
  init(view: ShowsProgressView, interactor: ShowsProgressInteractor,
       dataSource: ShowsProgressViewDataSource, router: ShowsProgressRouter)

  func viewDidLoad()
  func updateShows()
  func handleFilter()
  func handleDirection()
  func changeSort(to index: Int, filter: Int)
  func selectedShow(at index: Int)
}

protocol ShowsProgressView: class {
  var presenter: ShowsProgressPresenter! { get set }

  func newViewModelAvailable(at index: Int)
  func updateFinished()
  func showEmptyView()
  func reloadList()
  func showOptions(for sorting: [String], for filtering: [String], currentSort: Int, currentFilter: Int)
}

protocol ShowsProgressViewDataSource: class {
  func add(viewModel: WatchedShowViewModel)
  func viewModelCount() -> Int
  func update()
  func set(viewModels: [WatchedShowViewModel])
}
