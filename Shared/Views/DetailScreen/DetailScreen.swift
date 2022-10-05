//
//  DetailScreen.swift
//  NoteApp (iOS)
//
//  Created by Eloo on 04/10/2022.
//

import SwiftUI

struct DetailScreen: View {
    @ObservedObject var model: Model
    @Binding var showingSheet: Bool
    @State private var birthDate: Date = Calendar.current.date(byAdding: DateComponents(year: -40), to: Date()) ?? Date()
    init(showingSheet: Binding<Bool> , model: DetailScreen.Model) {
        self.model = model
        self._showingSheet = showingSheet
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0.0) {
                ZStack {
                    HStack(alignment: .bottom, spacing: 0.0) {
                        Spacer()
                        Button {
                            model.updateTask()
                            showingSheet = false
                        } label: {
                            Text("Update")
                                .font(.title3).bold()
                                .foregroundColor(Color(Constant.colorRed))
                                .padding(.trailing, 16.0)
                        }
                        
                    }
                    Text(model.task.title)
                        .font(.title3).bold()
                        .foregroundColor(.white)
                }
                .frame(height: 48)
                List {
                    TextField(text: $model.task.description, prompt: Text("Description").foregroundColor(Color(Constant.colorDarkGray))) {
                        Text("Password")
                    }
                    .foregroundColor(Color(Constant.colorGray))
                    .listRowBackground(Color(hue: 0.683, saturation: 0.015, brightness: 0.138))
                    Section {
                        DatePicker(
                            "Start",
                            selection: $model.startDate,
                            displayedComponents: [.date, .hourAndMinute]
                        )
                        .padding(.vertical, 2)
                        .colorScheme(.dark)
                        .foregroundColor(Color(Constant.colorGray))
                    }
                    .foregroundColor(Color(Constant.colorGray))
                    .listRowBackground(Color(hue: 0.683, saturation: 0.015, brightness: 0.138))
                    Section {
                        DatePicker(
                            "End",
                            selection: $model.endDate,
                            displayedComponents: [.date, .hourAndMinute]
                        )
                        .padding(.vertical, 2)
                        .colorScheme(.dark)
                        .foregroundColor(Color(Constant.colorGray))
                    }
                    .foregroundColor(Color(Constant.colorGray))
                    .listRowBackground(Color(hue: 0.683, saturation: 0.015, brightness: 0.138))
                }
                .background(Color(Constant.colorBlack))
                .ignoresSafeArea()
                .scrollContentBackground(.hidden)
            }
            .background(Color(Constant.colorBlack))
        }
    }
}

struct DetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        DetailScreen(showingSheet: .constant(false), model: DetailScreen.Model(task: TaskValue()))
    }
}
