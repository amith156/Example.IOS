//
//  GenericTableView.swift
//  TechTest
//
//  Created by Amith Narayan on 12/08/2021.
//

import UIKit

class GenericTableView<Item, Cell: UITableViewCell>: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    
    var items: [Item]!
    var config: (Item, Cell) -> ()
    
    init(frame: CGRect, items : [Item], config: @escaping (Item, Cell) -> ()) {
        self.items = items
        self.config = config
        super.init(frame: frame, style: .plain)
        self.delegate = self
        self.dataSource = self
        self.register(Cell.self, forCellReuseIdentifier: "Cell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
        return cell
    }
    

    
    
    


}
