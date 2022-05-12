//
//  FilterViewController.swift
//  KoloApp
//
//  Created by Jefin on 12/05/22.
//

import UIKit

protocol filterComicsProtocol: AnyObject{
    func loadComicsWithFilter(type: String)
}

class FilterViewController: UITableViewController {
    
    var selectedFilterTypeIndex = -1
    weak var delegate: filterComicsProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        KoloConstants.comicsFilterTypes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let filterType = KoloConstants.comicsFilterTypes[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = filterType
        cell.selectionStyle = .none
        if indexPath.row == selectedFilterTypeIndex {
        cell.accessoryType = .checkmark
        } else {
        cell.accessoryType = .none
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedFilterTypeIndex = indexPath.row
        delegate?.loadComicsWithFilter(type: KoloConstants.comicsFilterTypes[selectedFilterTypeIndex].camelcased)
        navigationController?.popViewController(animated: true)
    }
}
