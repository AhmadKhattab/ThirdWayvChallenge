//
//  ProductDetailsViewController.swift
//  ThirdWayvChallenge
//
//  Created by Ahmad Ashraf Khattab on 18/12/2022.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    // MARK: - Outlet(s)
    @IBOutlet private weak var productImageView: UIImageView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    // MARK: - Properties
    private let product: ProductDetailsModel
    // MARK: - Initializer(s)
    init(with product: ProductDetailsModel) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        populateViewsWithData()
    }
    /// Populate the views of ProductDetailsViewController with corresponding data model.
    private func populateViewsWithData() {
        descriptionLabel.text = product.description
        productImageView.image = product.image
    }
}
