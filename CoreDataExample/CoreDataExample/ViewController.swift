//
//  ViewController.swift
//  CoreDataExample
//
//  Created by Ceboolion on 18/04/2022.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    let table = UITableView()
    var data = [TabelData]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "CoreDataExample"
        loadItems()
        setupTable()
        setupNavigationBar()
    }
    
    private func setupTable() {
        view.addSubview(table)
        table.translatesAutoresizingMaskIntoConstraints = false
        
        table.delegate = self
        table.dataSource = self
        table.register(TableCell.self, forCellReuseIdentifier: TableCell.identifier)
        
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            
        ])
    }
    
    private func setupNavigationBar() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItemToTable))
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func addItemToTable() {
        print("WRC addItemToTable tapped")
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .default) { [weak self] action in
            let newItem = TabelData(context: self!.context)
            newItem.title = textField.text!
            self?.data.append(newItem)
            self?.saveItems()
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    private func saveItems() {
        do {
            try context.save()
        } catch {
            print("WRC error: \(error)")
        }
        
        self.table.reloadData()
    }
    
    private func loadItems() {
        let request: NSFetchRequest<TabelData> = TabelData.fetchRequest()
        do {
          data = try context.fetch(request)
        } catch {
            print("WRC error: \(error)")
        }
    }

}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableCell.identifier, for: indexPath) as! TableCell
        cell.textLabel?.text = data[indexPath.row].title
        
        return cell
    }
    
    
    
    
}
