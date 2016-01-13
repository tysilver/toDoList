//
//  FinishedViewController.swift
//  CustomCell
//
//  Created by Tyler Silverman on 11/20/15.
//  Copyright © 2015 Tyler Silverman. All rights reserved.
//

import Foundation
import UIKit

class FinishedViewController: UITableViewController {
    
    var finisheds = Finished.all()
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FinishedCell") as! FinishedCell
        cell.rightLabel.text = "\(finisheds[indexPath.row].createdAt)"
        cell.leftLabel.text = "\(finisheds[indexPath.row].objective)"
        // return cell so that Table View knows what to draw in each row
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return finisheds.count
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        finisheds = Finished.all()
        tableView.reloadData()
        print(finisheds.count)
    }
}