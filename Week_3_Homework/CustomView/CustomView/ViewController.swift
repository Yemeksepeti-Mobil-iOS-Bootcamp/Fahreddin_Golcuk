//
//  ViewController.swift
//  CustomView
//
//  Created by Fahreddin Gölcük on 10.07.2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var users = [User]()
    var filteredUsers = [User]()
    var isFiltering: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let urlStr = "https://jsonplaceholder.typicode.com/users"
        guard let userURL = URL(string: urlStr) else { return }
        let userList = try? JSONDecoder().decode([User].self, from: Data(contentsOf: userURL))
        
        guard let users = userList else { return }
        self.users = users
        
        tableView.dataSource = self
    }
}
//TABLEVIEW EXTENSIONS
extension ViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering {
            if filteredUsers.count == 0 {
                print("321")
                tableView.backgroundView = ListEmpty(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
                tableView.separatorStyle = .none
            }else {
                tableView.backgroundView = nil
                tableView.separatorStyle = .singleLine
            }
            return filteredUsers.count
        }
        
        return users.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell")
        
        let user: User
        
        if isFiltering {
            user = filteredUsers[indexPath.row]
        } else {
            user = users[indexPath.row]
        }
        
        cell?.textLabel?.text = user.name
        cell?.detailTextLabel?.text = user.company.name
        
        return cell!
    }
    
}

//SEARCHBAR EXTENSIONS
extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            filteredUsers = users
        } else{
            filteredUsers = users.filter({ (user: User) -> Bool in
                return user.name.lowercased().contains(searchText.lowercased())
            })
        }
        isFiltering = true
        tableView.reloadData()
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isFiltering = false
        searchBar.text = ""
        tableView.reloadData()
    }
}

