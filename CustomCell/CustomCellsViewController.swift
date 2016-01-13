//
//  ViewController.swift
//  CustomCell
//
//  Created by Tyler Silverman on 11/14/15.
//  Copyright © 2015 Tyler Silverman. All rights reserved.
//

import UIKit
class CustomCellsViewController: UITableViewController, CancelButtonDelegate, EditListControllerDelegate {
    var tasks = Task.all()
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CustomCell") as! CustomCell
        cell.rightLabel.text = "\(tasks[indexPath.row].objective)"
        cell.leftButton.backgroundColor = UIColor.orangeColor()
        // return cell so that Table View knows what to draw in each row
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    @IBAction func addFinishedButton(sender: UIButton) {
        let button = sender as! UIButton
        let view = button.superview!
        let cell = view.superview as! CustomCell
        let indexPath = tableView.indexPathForCell(cell)
        var newFinished = Finished(obj: tasks[indexPath!.row].objective)
        newFinished.save()
        tasks[indexPath!.row].destroy()
        tasks.removeAtIndex(indexPath!.row)
        tableView.reloadData()
        
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        tasks[indexPath.row].destroy()
        tasks.removeAtIndex(indexPath.row)
        tableView.reloadData()
    }
    
    func cancelButtonPressedFrom(controller: UIViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func AddButtonPressed(sender: UIBarButtonItem) {
        performSegueWithIdentifier("AddNewBeast", sender: sender)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "AddNewBeast" && sender!.tag == 1 {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! EditListController
            controller.cancelButtonDelegate = self
            controller.delegate = self
        } else if segue.identifier == "AddNewBeast" && sender!.tag != 1 {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! EditListController
            controller.cancelButtonDelegate = self
            controller.delegate = self
            if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell) {
                controller.beastToEdit = tasks[indexPath.row]
            }
        }
    }
    func editListController(controller: EditListController, didFinishAddingBeast beast: String) {
        dismissViewControllerAnimated(true, completion: nil)
        if controller.newBeastTextField.text!.characters.count > 0 {
            if let newTextField = controller.newBeastTextField.text {
                let beast = Task(obj: controller.newBeastTextField.text!)
                beast.save()
                tasks = Task.all()
            }
        }
        tableView.reloadData()
    }
    
    func editListController(controller: EditListController, didFinishEditingBeast beast: Task) {
        print("Something is happening here?")
        
        dismissViewControllerAnimated(true, completion: nil)
        
        if controller.newBeastTextField.text!.characters.count > 0 {
            if let newTextField = controller.newBeastTextField.text {
                beast.save()
                tasks = Task.all()
            }
        }
        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("AddNewBeast", sender: tableView.cellForRowAtIndexPath(indexPath))
        
    }
}

