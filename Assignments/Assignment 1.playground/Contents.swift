import UIKit

var students: [String] = ["Will", "John", "Mary", "David", "Roy", "Thomas"]
var studentGrades: [String : [Int]] = [
    "Will": [100, 99, 90],
    "John": [95, 90, 88],
    "Mary": [88, 85, 82],
    "David": [92, 72, 82],
    "Roy": [79, 70, 65],
    "Thomas": [85, 100, 72]
]

print(studentGrades)

var highestAvg = 0
var topStudent = ""

for (name, grade) in studentGrades {
    let average = grade.reduce(0, +) / grade.count
    print("""
        Student Record Summary:
        Student: \(name)
        Grades: \(grade)
        Average: \(average)\n
        """)
    
    if average > highestAvg {
        highestAvg = average
        topStudent = name
    }
}
print("\(topStudent) is the top student with an average of \(highestAvg)")
