//
//  TableCell.swift
//  CoreDataExample
//
//  Created by Ceboolion on 18/04/2022.
//

import UIKit

class TableCell: UITableViewCell {
    
    class var identifier: String { "Cell" }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
