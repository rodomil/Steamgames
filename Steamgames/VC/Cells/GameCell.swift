//
//  GameCell.swift
//  Steamgames
//
//  Created by Rodomil on 29.05.2023.
//

import UIKit

class GameCell: UITableViewCell {
    
    static let identifier = "Cell"
        
    //MARK: - UI
    private lazy var name = UILabel().then() {
        $0.textColor = .white
        $0.backgroundColor = .black
    }
     
    //MARK: - Base function
    
    func initCell(name: String) {
        self.name.text = name
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
        contentView.add { name }
    }
            
    //MARK: - Snap
    private func makeConstraints() {
        name.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(grid.space16)
            make.centerY.equalToSuperview()
            make.height.equalTo(30)
        }
    }

}
