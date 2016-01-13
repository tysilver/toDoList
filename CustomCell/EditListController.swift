//
//  EditListController.swift
//  CustomCell
//
//  Created by Tyler Silverman on 11/20/15.
//  Copyright © 2015 Tyler Silverman. All rights reserved.
//

import Foundation
import UIKit

class EditListController: UITableViewController {
    @IBAction func cancelBarButtonPressed(sender: UIBarButtonItem) {
        cancelButtonDelegate?.cancelButtonPressedFrom(self)
    }
    @IBAction func doneBarButtonPressed(sender: UIBarButtonItem) {
        if let beastMode = beastToEdit {
            beastToEdit!.objective = newBeastTextField.text!
            delegate?.editListController(self, didFinishEditingBeast: beastToEdit!)
        } else {
            delegate?.editListController(self, didFinishAddingBeast: newBeastTextField.text!)
        }
    }
    @IBOutlet weak var newBeastTextField: UITextField!
    weak var delegate: EditListControllerDelegate?
    weak var cancelButtonDelegate: CancelButtonDelegate?
    var beastToEdit: Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let editBeast = beastToEdit {
            newBeastTextField.text = editBeast.objective
        }
    }
}