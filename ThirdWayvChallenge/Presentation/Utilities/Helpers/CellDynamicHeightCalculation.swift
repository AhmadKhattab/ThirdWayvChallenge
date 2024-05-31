//
//  CellDynamicHeightCalc.swift
//  ThirdWayvChallenge
//
//  Created by Ahmad Ashraf Khattab on 18/12/2022.
//

import UIKit

/// Calculates the hight of image that will be displayed in cell
/// - Parameters:
///   - sourceImage: image model contains width and hight returned from API
///   - scaledToWidth: used to calculate scale factor
/// - Returns: the actual hight of image after applying the scale factor
func calculateImageHeight(sourceImage : Image, scaledToWidth: CGFloat) -> CGFloat {
    let oldWidth = CGFloat(sourceImage.width)
    let scaleFactor = scaledToWidth / oldWidth
    let newHeight = CGFloat(sourceImage.height)
    return newHeight * scaleFactor
}
/// Calculates the hight of label that will be displayed in cell
/// - Parameters:
///   - text: text for label
///   - cellWidth: the width of cell
/// - Returns: the actual hight of label
func requiredHeight(text:String , cellWidth : CGFloat) -> CGFloat {
    let font = UIFont(name: "Helvetica", size: 16.0)
    let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: cellWidth, height: .greatestFiniteMagnitude))
    label.numberOfLines = 0
    label.lineBreakMode = .byWordWrapping
    label.font = font
    label.text = text
    label.sizeToFit()
    return label.frame.height
}
