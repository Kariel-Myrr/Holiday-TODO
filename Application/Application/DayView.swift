//
//  DayView.swift
//  Application
//
//  Created by Alex Shchelochkov on 28.01.2021.
//

import SwiftUI

struct DayView: View {
    let name: String
    @State var todoList: [Todo] = []
        
    @State var newHeadline = ""
    @State var newDeskription = ""
    
    var body: some View {
        NavigationView {
            List(todoList) {todo in
                HStack() {
                    TodoCell(todo: todo)
                }
            }.navigationBarHidden(true)
        }.navigationBarTitle(Text(name), displayMode: .inline)
        HStack() {
            VStack() {
                TextField("Headline", text: $newHeadline)
                TextField("Description", text: $newDeskription)
            }.padding(15)
            Button("Add", action: {
                todoList.append(Todo(headline: newHeadline, description: newDeskription))
                newHeadline = ""
                newDeskription = ""
                })
                .foregroundColor(.orange)
                .padding(.all)
                .background(Color.black)
                .cornerRadius(12)
        }
    }
}

struct TodoCell: View {
    @StateObject var todo: Todo
    var body: some View {
        if todo.flag {
            HStack() {
                VStack() {
                    Text(todo.headline)
                        .font(.headline)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    Text(todo.description)
                        .font(.subheadline)
                }
                Spacer(minLength: 3)
                Button("Done", action: {
                    todo.flag = false
                })
                .foregroundColor(.white)
                .padding(8)
                .background(Color.red)
                .cornerRadius(12)
            }
        } else {
            VStack() {
                Text(todo.headline)
                    .font(.headline)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    .strikethrough(true, color: .red)
                Text(todo.description)
                    .font(.subheadline)
                    .strikethrough(true, color: .red)
            }
        }
    }
}

class Todo: Identifiable, ObservableObject {
    let id = UUID()
    let headline: String
    let description: String
    @Published var flag: Bool
    
    init(headline: String, description: String) {
        self.headline = headline
        self.description = description
        self.flag = true
    }
}
