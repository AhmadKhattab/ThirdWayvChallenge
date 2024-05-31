//
//  ProductCollectionViewCell.swift
//  ThirdWayvChallenge
//
//  Created by Ahmad Ashraf Khattab on 17/12/2022.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell, NibLoadable {
    // MARK: - Outlet(s)
    @IBOutlet private weak var productImageView: UIImageView!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    // MARK: - Properties
    var productDetailsModel: ProductDetailsModel {
        let fallbackProductImage = UIImage(named: "product_placeholder") ?? UIImage()
        return ProductDetailsModel(image: productImageView.image ?? fallbackProductImage, description: descriptionLabel.text ?? "")
    }
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    /// Setup the views' appearance of ProductCollectionViewCell.
    func setup() {
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = Constants.borderWidth
    }
    // MARK: - Configure cell data
    
    /// Configure views of cell with corresponding data model.
    /// - Parameter product: data model which is used to populate views of cell
    func configureCell(with product: ProductDataModel) {
        priceLabel.text = product.price
        descriptionLabel.text = product.description
        productImageView.downloaded(from: product.image.url, contentMode: .scaleAspectFill)
    }
}
// MARK: - Constants
private extension ProductCollectionViewCell {
    struct Constants {
        static let borderWidth: CGFloat = 1
    }
}
