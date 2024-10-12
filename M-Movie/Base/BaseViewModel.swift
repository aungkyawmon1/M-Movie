//
//  BaseViewModel.swift
//  M-Movie
//
//  Created by Aung Kyaw Mon on 12/10/2567 BE.
//

import Foundation
import RxSwift
import RxRelay

class BaseViewModel {
    let disposeBag = DisposeBag()
    var viewController : BaseViewController?
    
    let loadingPublishRelay = PublishRelay<Bool>()
    
    let errorPublishRelay = PublishRelay<String>()
    
    func bindViewModel(in viewController: BaseViewController? = nil ) {
        self.viewController = viewController
        
        
        // Subscribe to loadingPublishRelay
        loadingPublishRelay.subscribe(onNext: { [weak self] isLoading in
            if isLoading {
                self?.viewController?.showLoading()
            } else {
                self?.viewController?.hideLoading()
            }
        }).disposed(by: disposeBag)
        
        // Subscribe to errorPublishRelay
        errorPublishRelay.subscribe(onNext: { [weak self] errorMessage in
            self?.viewController?.showAlert(title: "Info", message: errorMessage)
        }).disposed(by: disposeBag)
    }
}

