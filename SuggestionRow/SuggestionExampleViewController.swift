//
//  SuggestionExampleViewController.swift
//  SuggestionRow
//

import UIKit
import Eureka

class SuggestionExampleViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let options = ["Apple", "Appetizer", "Around", "Addiction", "Anachronism", "Ant", "Author"]
        
        form +++ Section("Input accessory view suggestions")
            <<< SuggestionAccessoryRow() {
                $0.filterFunction = { text in
                    options.filter({ $0.hasPrefix(text) })
                }
                $0.placeholder = "Enter text that starts with A..."
            }
        
        +++ Section("Table suggestions")
            <<< SuggestionTableRow() {
                $0.filterFunction = { text in
                    options.filter({ $0.hasPrefix(text) })
                }
                $0.placeholder = "Enter text that starts with A..."
            }
    }
}
