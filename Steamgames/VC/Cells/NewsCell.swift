//
//  NewsCell.swift
//  Steamgames
//
//  Created by Rodomil on 29.05.2023.
//

import UIKit

//MARK: - Grid
private extension Grid {
   
}

//MARK: - Appearance
private extension Appearance {

}

//MARK: - Constants
private extension Constants {
    
}

class NewsCell: UITableViewCell {
    
    static let identifier = "cell"
        
    //MARK: - UI
    private lazy var titleText = UILabel().then() {
        $0.backgroundColor = .black
        $0.textColor = .white
    }
    private lazy var date = UILabel().then() {
        $0.backgroundColor = .black
        $0.textColor = .white
    }
    private lazy var author = UILabel().then() {
        $0.backgroundColor = .black
        $0.textColor = .white
    }

    private lazy var desc = UITextView().then() {
        $0.backgroundColor = .black
        $0.textColor = .white
    }

    //MARK: - var
     
    //MARK: - Base function
    func initCell(item: OnceNews) {
        
        titleText.text = item.title
        author.text = item.author
        date.text = Date.timeIntervalConvertString(time: Double(item.date))
        desc.text = item.contents
        
        commonInit()
    }
        
    // MARK: - Private Methods
        
    private func commonInit() {
        setupStyle()
        addSubviews()
        makeConstraints()
    }
            
    private func setupStyle() {
        backgroundColor = .black
    }
            
    private func addSubviews() {
        add {
            titleText
            desc
            author
            date
        }
    }
            
    //MARK: - Snap
    private func makeConstraints() {
        titleText.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(grid.space05)
            make.height.equalTo(appearance.fontSize28)
        }
    
        desc.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(grid.space05)
            make.top.equalTo(titleText.snp_bottomMargin).offset(grid.space8)
            make.height.equalTo(50)
        }
        author.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(grid.space05)
            make.top.equalTo(desc.snp_bottomMargin).offset(grid.space8)
            make.height.equalTo(20)
        }
        date.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(grid.space05)
            make.top.equalTo(desc.snp_bottomMargin).offset(grid.space8)
            make.height.equalTo(20)
        }
    }
        
  
        
}
