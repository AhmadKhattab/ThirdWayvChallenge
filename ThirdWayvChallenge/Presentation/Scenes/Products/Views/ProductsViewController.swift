//
//  ProductsViewController.swift
//  ThirdWayvChallenge
//
//  Created by Ahmad Ashraf Khattab on 16/12/2022.
//

import UIKit

class ProductsViewController: UIViewController {
    // MARK: - Outlet(s)
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var collectionView: UICollectionView!
    // MARK: - Properties
    private let viewModel: ProductsViewModelProtocol
    private var products: [ProductDataModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    private let transition = PopAnimator()
    // MARK: - Initializer(s)
    required init(viewModel: ProductsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configureBinding()
        viewModel.fetchProducts(shouldCache: true)
    }
    private func retry() {
        viewModel.fetchProducts(shouldCache: true)
    }
    @objc func statusManager(_ notification: Notification) {
        retry()
    }
}
// MARK: - Setup
private extension ProductsViewController {
    func setup() {
        self.title = Constants.title
        configureCollectionView()
        registerCell()
    }
    func configureCollectionView() {
        let layout = ProductsLayout()
        layout.delegate = self
        collectionView.collectionViewLayout = layout
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.prefetchDataSource = self
    }
    func registerCell() {
        collectionView.register(ProductCollectionViewCell.self)
    }
}
// MARK: - Configure Binding
private extension ProductsViewController {
    func configureBinding() {
        bindOnInternetConnection()
        bindOnLoading()
        bindOnError()
        bindOnProducts()
    }
    func bindOnInternetConnection() {
        NotificationCenter
            .default
            .addObserver(self,
                         selector: #selector(statusManager),
                         name: .flagsChanged,
                         object: nil)
    }
    func bindOnLoading() {
        viewModel
            .loadingObservable
            .observe(on: self) { [weak self] isLoading in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    isLoading ? self.activityIndicator.startAnimating() : self.activityIndicator.stopAnimating()
                }
            }
    }
    func bindOnError() {
        viewModel
            .errorObservable
            .observe(on: self) { [weak self] errorMessage in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.showAlert(with: errorMessage)
                }
            }
    }
    func bindOnProducts() {
        viewModel
            .productsObservable
            .observe(on: self) { [weak self] products in
                guard let self = self else { return }
                self.products = products
            }
    }
}
// MARK: - Collection view data source and delegate
extension ProductsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ProductCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        let product = products[indexPath.row]
        cell.configureCell(with: product)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        products.count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ProductCollectionViewCell
        else { return }
        let product = cell.productDetailsModel
        let productDetailsVC = ProductDetailsViewController(with: product)
        productDetailsVC.transitioningDelegate = self
        navigationController?.present(productDetailsVC, animated: true, completion: nil)
    }
}
// MARK: - ProductsLayoutDelegate
extension ProductsViewController: ProductsLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForCellAtIndexPath indexPath: IndexPath, cellWidth: CGFloat) -> CGFloat {
        let imageHeight = calculateImageHeight(sourceImage: products[indexPath.row].image , scaledToWidth: cellWidth)
        let productPriceHeight = requiredHeight(text: products[indexPath.row].price, cellWidth: cellWidth)
        let productDescriptionTextHeight = requiredHeight(text: products[indexPath.row].description, cellWidth: cellWidth)
        let cellHeight = imageHeight + productPriceHeight + productDescriptionTextHeight
        return cellHeight
    }
}
// MARK: - UICollectionViewDataSourcePrefetching
extension ProductsViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for index in indexPaths where index.row >= products.count - Constants.prefetchingConstant {
            viewModel.fetchProducts(shouldCache: false)
            break
        }
    }
}
// MARK: - UIViewControllerTransitioningDelegate
extension ProductsViewController: UIViewControllerTransitioningDelegate {
    func animationController(
      forPresented presented: UIViewController,
      presenting: UIViewController, source: UIViewController)
        -> UIViewControllerAnimatedTransitioning? {
      return transition
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
      return nil
    }
}
// MARK: - Constants
private extension ProductsViewController {
    enum Constants {
        static let title = "Products List"
        static let prefetchingConstant = 4
    }
}
