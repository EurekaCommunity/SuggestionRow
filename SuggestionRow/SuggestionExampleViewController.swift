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
        let users: [Scientist] = [Scientist(id: 1, firstName: "Albert", lastName: "Einstein"),
                             Scientist(id: 2, firstName: "Isaac", lastName: "Newton"),
                             Scientist(id: 3, firstName: "Galileo", lastName: "Galilei"),
                             Scientist(id: 4, firstName: "Marie", lastName: "Curie"),
                             Scientist(id: 5, firstName: "Louis", lastName: "Pasteur"),
                             Scientist(id: 6, firstName: "Michael", lastName: "Faraday")]

        form +++ Section("Input accessory view suggestions")
            <<< SuggestionAccessoryRow<String>() {
                $0.filterFunction = { text in
                    options.filter({ $0.hasPrefix(text) })
                }
                $0.placeholder = "Enter text that starts with A..."
            }
        
        +++ Section("Table suggestions")
            <<< SuggestionTableRow<Scientist>() {
                $0.filterFunction = { text in
                    users.filter({ $0.firstName.lowercaseString.containsString(text.lowercaseString) })
                }
                $0.placeholder = "Search for a famous scientist"
            }
    }
}


struct Scientist: SuggestionValue {
    var id: Int
    var firstName: String
    var lastName: String


    var suggestionString: String {
        return "\(firstName) \(lastName)"
    }

    init(id: Int, firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.id = id
    }

    init?(string stringValue: String) {
        return nil
    }
}

func == (lhs: Scientist, rhs: Scientist) -> Bool {
    return lhs.id == rhs.id
}