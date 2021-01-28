//
//  ContentView.swift
//  Application
//
//  Created by Alex Shchelochkov on 28.01.2021.
//

import SwiftUI

struct WeekView: View {
   
    let days: [Day] = [
        Day(name: "Monday"),
        Day(name: "Tuesday"),
        Day(name: "Wednesday"),
        Day(name: "Thursday"),
        Day(name: "Friday"),
        Day(name: "Saturday"),
        Day(name: "Sunday"),
    ]
    var body: some View {
        NavigationView {
            List(days) { day in
                NavigationLink(destination: DayView(name: day.name)) {
                    Text(day.name)
                }
            }
            .navigationBarTitle(Text("Week"))
        }
    }
}

struct Day: Identifiable {
    let id = UUID()
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WeekView()
    }
}
