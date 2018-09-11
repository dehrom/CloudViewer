import AppKit
import Foundation
import RxSwift

class MainViewController: NSViewController, NSCollectionViewDataSource, NSCollectionViewDelegate {
    @IBOutlet var collectionView: NSCollectionView!

    private let viewModel = ViewModel()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetch().subscribe().disposed(by: disposeBag)
    }

    func collectionView(_: NSCollectionView, numberOfItemsInSection _: Int) -> Int {
        return 0
    }

    func collectionView(_: NSCollectionView, itemForRepresentedObjectAt _: IndexPath) -> NSCollectionViewItem {
        return NSCollectionViewItem()
    }
}
