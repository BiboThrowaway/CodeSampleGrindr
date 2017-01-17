//
//  ViewController.swift
//  LetsChefTV
//
//  Created by Bibo on 12/23/15.
//  Copyright © 2015 Alminty. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    self.setupTableView()
  }
  
  func setupTableView() {
    let mainTableView = UITableView(frame: CGRectMake(100, 300, CGRectGetWidth(self.view.bounds)-200, CGRectGetHeight(self.view.bounds)-200), style: UITableViewStyle.Plain)
    mainTableView.delegate = self
    mainTableView.dataSource = self
    mainTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    mainTableView.backgroundColor = UIColor.redColor()
    self.view.addSubview(mainTableView)
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    cell.backgroundColor = UIColor.blueColor()
    
    let btnOne = UIButton(type: UIButtonType.System)
    btnOne.frame = CGRectMake(0, 50, 100, 50);
    btnOne.setTitle("Click me", forState: UIControlState.Normal)
    cell.addSubview(btnOne)
    
    let btnTwo = UIButton(type: UIButtonType.System)
    btnTwo.frame = CGRectMake(150, 50, 100, 50);
    btnTwo.setTitle("Click me", forState: UIControlState.Normal)
    cell.addSubview(btnTwo)
    
    return cell
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 150
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

