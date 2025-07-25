import UIKit

class Student {
    let name: String
    let age: Int
    let grades: [Int]
    
    init(name: String, age: Int, grades: [Int]) {
        self.name = name
        self.age = age
        self.grades = grades
    }
    
    func averageGrade() -> Double {
        let averageGrade = Double(grades.reduce(0, +)) / Double(grades.count)
        return averageGrade
    }
    
    func passingGrade() -> String {
        if averageGrade() >= 60 {
            return "Passing"
        } else {
            return "Failing"
        }
    }
}

class Course {
    let students: [Student]
    
    init(students: [Student]) {
        self.students = students
    }
    
    func avgGrade() -> Double {
        let avgGrade: Double = Double(students.map{ $0.averageGrade() }.reduce(0, +)) / Double(students.count)
        return avgGrade
    }
    
    func topStudent() -> Student? {
        return students.max(by: { $0.averageGrade() < $1.averageGrade() })
    }
}

let student1: Student = Student(
    name: "Alice",
    age: 20,
    grades: [99, 88, 72]
    )
let student2: Student = Student(
    name: "Bob",
    age: 21,
    grades: [55, 44, 33]
    )
let student3: Student = Student(
    name: "Victor",
    age: 22,
    grades: [100, 100, 99]
)

let algebraCourse: Course = Course(students: [student1, student2, student3])

// Have to put in an if statement because topStudent function has an optional student "Student?"
if let topStudent = algebraCourse.topStudent(){
    print("""
        Student: \(student1.name)
        Average: \(String(format: "%.2f", student1.averageGrade()))
        Status: \(student1.passingGrade())
        
        Course Average: \(String(format: "%.2f", algebraCourse.avgGrade()))
        Top Student: \(topStudent.name) \(String(format: "%.2f", topStudent.averageGrade()))
        """)
} else {
    print("No students in course")
}


