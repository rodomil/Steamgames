//
//  GamesVC.swift
//  Steamgames
//
//  Created by Rodomil on 29.05.2023.
//

import UIKit
import Then
import SnapKit

//MARK: - Grid
private extension Grid {
   
}

//MARK: - Appearance
private extension Appearance {

}

//MARK: - Constants
private extension Constants {
    var title: String { "Список игр" }
    
}

class GamesVC: UIViewController {
        
    //MARK: - UI
    private lazy var table = UITableView().then() {
        $0.register(GameCell.self, forCellReuseIdentifier: GameCell.identifier)
        $0.backgroundColor = .black
    }
    
    private lazy var search = UISearchBar().then() {
        $0.barTintColor = .black
        $0.backgroundColor = .white
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    private lazy var dataRefresher = UIRefreshControl().then() {
        $0.attributedTitle = NSAttributedString(string: "Refresh")
        $0.tintColor = .white
        $0.addTarget(self, action: #selector(update), for: .valueChanged)
    }

    //MARK: - var
    private lazy var dataTabel = [GameOneStruct]()
    private lazy var filtered = [GameOneStruct]()
    private lazy var interactor = GameInteractor()
    private lazy var searchActive = false
     
    //MARK: - Base function
    override func viewDidLoad() {
        super.viewDidLoad()

        commonInit()
        
        table.dataSource = self
        table.delegate = self
        
        table.refreshControl = dataRefresher
        
        search.delegate = self
        
        interactor.delegateGameList = self
        interactor.loadGameList()
        
    }
        
    // MARK: - Private Methods
        
    private func commonInit() {
        setupStyle()
        addSubviews()
        makeConstraints()
        
        addKeyboardWillShowObserver()
    }
            
    private func setupStyle() {
        view.backgroundColor = .black
        title = constants.title
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
            
    private func addSubviews() {
        view.add {
            search
            table
        }
    }
            
    //MARK: - Snap
    private func makeConstraints() {
        search.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(grid.space16)
            make.top.equalToSuperview().inset(100)
        }
        table.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview().inset(grid.space16)
            make.top.equalTo(search.snp_bottomMargin).offset(grid.space16)
        }
    }
        
    //MARK: - Action
    @objc private func update() {
        interactor.loadGameList()
    }
    
    //MARK: - Work with keyboard

    private func addKeyboardWillShowObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardDidAppear(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillAppear(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyBoardDidAppear(notification: NSNotification) {
        table.snp.updateConstraints { make in
            make.bottom.equalToSuperview().inset(keyboardWillShow(notification: notification))
        }
    }
    
    @objc func keyBoardWillAppear(notification: NSNotification) {
        table.snp.updateConstraints { make in
            make.bottom.equalToSuperview().inset(grid.space16)
        }
    }
        
}

extension GamesVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return filtered.count
        }
        return dataTabel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GameCell.identifier) as! GameCell
        searchActive ? cell.initCell(name: filtered[indexPath.row].name) : cell.initCell(name: dataTabel[indexPath.row].name)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dest = NewsGameVC()
        dest.id = dataTabel[indexPath.row].appid
        navigationController?.pushViewController(dest, animated: true)
        table.deselectRow(at: indexPath, animated: true)
    }
}

extension GamesVC: GameListProtocol {
    func gameList(data: [GameOneStruct]) {
        dataTabel = data
        table.reloadData()
        dataRefresher.endRefreshing()
    }
}

extension GamesVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filtered = dataTabel.filter { item in
            let tmp = item.name
            return   tmp.lowercased().contains(searchText.lowercased())
        }

        if searchText.isEmpty {
            searchActive = false;
            view.endEditing(true)
        } else {
            searchActive = true;
        }
        self.table.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
}


extension UIViewController: GridCompatible {}
extension UIViewController: AppearanceCompatible {}
extension UIViewController: ConstantsCompatible {}
