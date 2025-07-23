//  StudentManagementView.swift
//  Unit 103
//  Created by Weeraphot Bumbaugh on 7/22/25.
import SwiftUI

struct StudentManagementView: View {
    
    struct Student: Identifiable {
        let id = UUID()
        var name: String
        var grades: [Double]
        
        var average: Double {
            // Protect ya self from nan and dividing by 0
            guard !grades.isEmpty else { return 0 }
            return grades.reduce(0, +) / Double(grades.count)
        }
    }
    
    @State private var students: [Student] = [
        Student(name: "Alice", grades: [80, 85, 88]),
        Student(name: "Bob", grades: [95, 92, 88]),
        Student(name: "Charlie", grades: [70, 80, 87]),
        Student(name: "Billy", grades: [60, 99, 85]),
        Student(name: "Xavier", grades: [99, 99, 95])
    ]
    
    @State private var isAscending = false
    
    var courseAvg: Double {
        // .map would return a [[Double]], .flatMap returns a [Double]
        let allGrades = students.flatMap(\.grades)
        guard !allGrades.isEmpty else { return 0 }
        return allGrades.reduce(0, +) / Double(allGrades.count)
    }
    
    var sortedStudents: [Student] {
        students.sorted {
            // If isAscending is true, ascending. Otherwise, descending
            isAscending ? $0.average < $1.average : $0.average > $1.average
        }
    }
    
    @State private var newStudent: String = ""
    @State private var initialGrade: String = ""
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.gray.opacity(0.1)
                    .ignoresSafeArea()
                
                VStack{
                    Text("Course Average: \(String(format: "%.2f", courseAvg))")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding(.top)
                    List {
                        ForEach(sortedStudents) { student in
                            Text("\(student.name): \(String(format: "%.2f", student.average))")
                                .font(.body)
                        }
                    }
                    
                    VStack{
                        HStack{
                            TextField("Name", text: $newStudent)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(50)
                                .overlay(RoundedRectangle(cornerRadius: 50)
                                    .stroke(Color.gray.opacity(0.5), lineWidth: 1))
                                .padding(.horizontal)
                            
                            TextField("Grade", text: $initialGrade)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(50)
                                .overlay(RoundedRectangle(cornerRadius: 50)
                                    .stroke(Color.gray.opacity(0.5), lineWidth: 1))
                                .padding(.trailing)
                        }

                        Button(action: {
                            if let grade = Double(initialGrade), !newStudent.isEmpty {
                                addStudent(newStudent, grade: grade)
                                newStudent = ""
                                initialGrade = ""
                            }
                        }) {
                            Label("Add Student", systemImage: "plus.circle.fill")
                                .font(.headline)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.purple)
                                .foregroundColor(.white)
                                .cornerRadius(20)
                                .padding(.horizontal)
                        }
                        .disabled(newStudent.isEmpty || Double(initialGrade) == nil)
                    }
                    
                } //VStack
                .padding(.bottom)
            } //ZStack
            .navigationBarTitle("Student Grades", displayMode: .inline)
            .toolbar {
                Button(action: {
                    isAscending.toggle()
                }) {
                    Image(systemName: isAscending ? "arrow.up" : "arrow.down")
                        .foregroundColor(.purple)
                }
                .padding()
            }
        } //NavigationStack
    } //View
    private func addStudent(_ name: String, grade: Double){
        let newStudent = Student(name: name, grades: [grade])
        students.append(newStudent)
    }
}

#Preview {
    StudentManagementView()
}
