//
//  BaseCollectionViewCell.swift
//  M-Movie
//
//  Created by Aung Kyaw Mon on 12/10/2567 BE.
//

import UIKit
import RxSwift

class BaseCollectionViewCell: UICollectionViewCell {
    
    let disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bindData()
        setupUI()
    }
    
    func bindData() {
        
    }
    
    func setupUI() {
       
    }
    
}
