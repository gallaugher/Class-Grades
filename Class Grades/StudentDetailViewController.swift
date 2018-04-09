//
//  StudentDetailViewController.swift
//  Class Grades
//
//  Created by John Gallaugher on 4/8/18.
//  Copyright © 2018 John Gallaugher. All rights reserved.
//

import UIKit

class StudentDetailViewController: UIViewController {
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var gradesTextView: UITextView!
    
    @IBOutlet weak var averageLabel: UILabel!
    var student: Student!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if student == nil {
            student = Student(firstName: "", lastName: "", grades: "", average: 0.0)
        }
        updateUserInterface()
    }
    
    func updateUserInterface() {
        firstNameTextField.text = student.firstName
        lastNameTextField.text = student.lastName
        gradesTextView.text = student.grades
        let average = calculateAverageGrade(gradeString: student.grades)
        averageLabel.text = "\(average)"
    }
    
    func calculateAverageGrade(gradeString: String) -> Double {
        let newGradeString = gradeString.replacingOccurrences(of: " ", with: "")
        let gradeArray = newGradeString.components(separatedBy: ",")
        var pointTotal = 0.0
        for grade in gradeArray {
            pointTotal += Double(grade) ?? 0.0
        }
        print(pointTotal)
        guard gradeArray.count > 0 else { return 0.0 }
        
        return pointTotal / Double(gradeArray.count)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        student.firstName = firstNameTextField.text!
        student.lastName = lastNameTextField.text!
        student.grades = gradesTextView.text!
        student.average = calculateAverageGrade(gradeString: gradesTextView.text!)
    }

    @IBAction func calculateAveragePressed(_ sender: UIButton) {
        let average = calculateAverageGrade(gradeString: gradesTextView.text)
        averageLabel.text = "\(average)"
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
}
