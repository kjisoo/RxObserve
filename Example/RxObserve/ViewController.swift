//
//  ViewController.swift
//  RxObserve
//
//  Created by kjisoo on 09/30/2018.
//  Copyright (c) 2018 kjisoo. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxObserve

@objcMembers
class ViewModel: NSObject {
  dynamic var keyword: String = "" {
    didSet {
      self.createStubList()
    }
  }
  dynamic var list: [String] = []

  private func createStubList() {
    var result: [String] = []
    for index in 0..<10 {
      result.append("\(self.keyword) - \(index)")
    }
    self.list.replaceSubrange(0..<self.list.count, with: result)
  }

  public func select(row: Int) {
    self.keyword = self.list[row]
  }
}

class ViewController: UIViewController {
  private let disposeBag = DisposeBag()
  private let viewModel = ViewModel()

  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var tableView: UITableView!

  override func viewDidLoad() {
    super.viewDidLoad()

    self.searchBar.rx.text
      .orEmpty
      .bind(to: viewModel.rx.asObserver(keyPath: \.keyword))
      .disposed(by: self.disposeBag)

    self.viewModel.rx
      .asObservable(keyPath: \.keyword)
      .bind(to: searchBar.rx.text)
      .disposed(by: self.disposeBag)

    self.viewModel.rx
      .asObservable(keyPath: \.list)
      .subscribe(onNext: { [weak self] (_) in
        self?.tableView.reloadData()
      })
      .disposed(by: self.disposeBag)
  }
}

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.viewModel.list.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    cell.textLabel?.text = self.viewModel.list[indexPath.row]
    return cell
  }
}

extension ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.viewModel.select(row: indexPath.row)
  }
}
