//
//  EditListControllerDelegate.swift
//  CustomCell
//
//  Created by Tyler Silverman on 11/20/15.
//  Copyright © 2015 Tyler Silverman. All rights reserved.
//

import Foundation

protocol EditListControllerDelegate: class {
    func editListController(controller: EditListController, didFinishAddingBeast beast: String)
    func editListController(controller: EditListController, didFinishEditingBeast beast: Task)
}