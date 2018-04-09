//
//  ViewController.swift
//  Class Grades
//
//  Created by John Gallaugher on 4/8/18.
//  Copyright © 2018 John Gallaugher. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var students: [Student] = []
    // line above is same as line below
    // var students = [Student]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
//        students.append(Student(firstName: "Ann", lastName: "Wojiciski", grades: "", average: 100.0))
//        students.append(Student(firstName: "Mark", lastName: "Zuckerberg", grades: "", average: 68.0))
//        students.append(Student(firstName: "Susan", lastName: "Wojiciski", grades: "", average: 91.0))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowStudent" {
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            let destination = segue.destination as! StudentDetailViewController
            destination.student = students[selectedIndexPath.row]
        } else {
            if let selectedRow = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectedRow, animated: true)
            }
        }
    }
    
    @IBAction func unwindFromStudentDetailViewController(segue: UIStoryboardSegue){
        if let selectedIndexPath = tableView.indexPathForSelectedRow { // tableview cell you clicked on
            let source = segue.source as! StudentDetailViewController
            students[selectedIndexPath.row] = source.student
            tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
        } else {
            let source = segue.source as! StudentDetailViewController
            let newIndexPath = IndexPath(row: students.count, section: 0)
            students.append(source.student)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            tableView.scrollToRow(at: newIndexPath, at: .bottom, animated: true)
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let nameString = "\(students[indexPath.row].firstName) \(students[indexPath.row].lastName)"
        cell.textLabel?.text = nameString
        cell.detailTextLabel?.text = "Avg. \(students[indexPath.row].average)"
        return cell
    }
}
