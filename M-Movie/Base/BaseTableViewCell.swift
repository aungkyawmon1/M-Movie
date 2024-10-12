//
//  BaseTableViewCell.swift
//  M-Movie
//
//  Created by Aung Kyaw Mon on 12/10/2567 BE.
//

import UIKit
import RxSwift

class BaseTableViewCell: UITableViewCell {

    let disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
        
        bindData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI() {
        
    }
    
    func bindData() {
        
    }

}

