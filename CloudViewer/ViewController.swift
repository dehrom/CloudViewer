import Foundation
import AppKit
import RxSwift

class MainViewController: NSViewController, NSCollectionViewDataSource, NSCollectionViewDelegate {
    private let viewModel = ViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetch().subscribe().disposed(by: disposeBag)
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        return NSCollectionViewItem()
    }
}
