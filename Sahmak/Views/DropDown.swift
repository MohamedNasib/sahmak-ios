//
//  DropDown.swift
//  Jobzy
//
//  Created by ADEL ELGAZAR on 12/17/18.
//  Copyright © 2018 ADEL ELGAZAR. All rights reserved.
//

import Foundation
import RSSelectionMenu

class DropDown {
    let selectionMenu:RSSelectionMenu<String>
    let array:[String]
    let VC:UIViewController

    init(vc:UIViewController, array:[String]) {
        self.VC = vc
        self.array = array
        selectionMenu =  RSSelectionMenu(dataSource: array) { (cell, object, indexPath) in
            cell.textLabel?.text = object
            cell.textLabel?.textAlignment = .left//object
        }
        selectionMenu.dismissAutomatically = true
    }
    
    func show(selecteditem:[String], showSearchBar:Bool, didSelect:@escaping (_ text:String?, _ selected:Bool, _ selectedItems :[String])->()){
        
        // selection delegate
        selectionMenu.setSelectedItems(items: selecteditem, maxSelected: 1) { [weak self] (item, index, isSelected, selectedItems) in
//            textField.text = text
            didSelect(item, isSelected, selectedItems)
            self?.selectionMenu.dismiss()
        }
        
        // search delegate

        if showSearchBar {
                selectionMenu.showSearchBar { (searchtext) -> ([String]) in
                    return self.array.filter({ $0.lowercased().hasPrefix(searchtext.lowercased()) })
                }
            }
        
        selectionMenu.show(style: .actionSheet(title: nil, action: "Cancel", height: nil), from: VC)
        
        

    }
    
    func hide(){
        selectionMenu.dismiss()
    }
}
