//
//  ContentView.swift
//  WeSplit
//
//  Created by Somi Jeon on 2024-03-01.
//

import SwiftUI

struct ContentView: View {
    let students = ["Harry", "Hermione", "Ron"]
    @State private var selectedStudent = "Harry" // @State property wrapper is used to create a two-way binding
    
    var body: some View {
        NavigationStack {
            Form {
                Picker("Select your student", selection: $selectedStudent) {
                    ForEach(students, id: \.self) { // id: \.self is used to identify each student uniquely
                        Text($0) // $0 is a shorthand for the current item in the array
                    }
                }
//                TextField("Enter your name", text: $name) // $name is a two-way(read & write) binding
//                Text("Hello, \(name)!")
            }
        }
     
    }
}

#Preview {
    ContentView()
}
