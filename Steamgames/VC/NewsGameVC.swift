//
//  NewsGameVC.swift
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
    var title: String { "Новости" }
}

class NewsGameVC: UIViewController {
        
    //MARK: - UI
    private lazy var table = UITableView().then() {
        $0.register(NewsCell.self, forCellReuseIdentifier: NewsCell.identifier)
        $0.backgroundColor = .black
    }
    
    private lazy var dataRefresher = UIRefreshControl().then() {
            $0.attributedTitle = NSAttributedString(string: "Refresh")
            $0.tintColor = .white
            $0.addTarget(self, action: #selector(update), for: .valueChanged)
        }

    //MARK: - var
    var id = 0
    private lazy var dataTabel = [OnceNews]()
    private lazy var interactor = GameInteractor()
     
    //MARK: - Base function
    override func viewDidLoad() {
        super.viewDidLoad()

        commonInit()
    }
        
    // MARK: - Private Methods
        
    private func commonInit() {
        setupStyle()
        addSubviews()
        makeConstraints()
        
        table.dataSource = self
        table.delegate = self
        table.refreshControl = dataRefresher
        
        interactor.loadNew(id: id)
        interactor.delegateGameList = self
    }
            
    private func setupStyle() {
        view.backgroundColor = .black
        title = constants.title
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
    }
            
    private func addSubviews() {
        view.add { table }
    }
            
    //MARK: - Snap
    private func makeConstraints() {
        table.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview().inset(grid.space16)
            make.top.equalToSuperview().offset(100)
        }
    }
    
    //MARK: - Action
    @objc private func update() {
        interactor.loadNew(id: id)
    }
}

extension NewsGameVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataTabel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.identifier) as! NewsCell
        cell.initCell(item: dataTabel[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dest = WebVC()
        dest.urlStr = dataTabel[indexPath.row].url
        navigationController?.pushViewController(dest, animated: true)
        table.deselectRow(at: indexPath, animated: true)
    }
    
}

extension NewsGameVC: GameListProtocol {
    func news(data: [OnceNews]) {
        dataTabel = data
        table.reloadData()
    }
    
    func noData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.dismiss(animated: true)
            self.navigationController?.popViewController(animated: true)
        }
    }
}
