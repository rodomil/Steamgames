//
//  WebVC.swift
//  Steamgames
//
//  Created by Rodomil on 29.05.2023.
//

import UIKit
import WebKit

class WebVC: UIViewController {
    
    private lazy var web = WKWebView().then() {
        $0.backgroundColor = .black
        $0.contentMode = .scaleAspectFit
    }
    
    var urlStr = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = URL(string: urlStr) {
            let request = URLRequest(url: url)
            web.load(request)
        }
        
        view.backgroundColor = .black
        navigationController?.navigationBar.tintColor = .white
        
        view.add { web }
        web.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview().inset(grid.space05)
            make.top.equalToSuperview().inset(100)
        }
    }
    

}
