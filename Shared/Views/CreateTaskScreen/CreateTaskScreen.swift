//
//  CreateTaskScreen.swift
//  NoteApp (iOS)
//
//  Created by Eloo on 22/09/2022.
//

import SwiftUI

struct CreateTaskScreen: View {
    @Binding var showingSheet: Bool
    @ObservedObject var model: Model
    @State private var date = Date()
    
    init(showingSheet: Binding<Bool>, model: CreateTaskScreen.Model) {
        self._showingSheet = showingSheet
        self.model = model
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0.0) {
                ZStack {
                    HStack(alignment: .bottom, spacing: 0.0) {
                        Spacer()
                        Button {
                            model.add()
                            showingSheet = false
                        } label: {
                            Text("Done")
                                .font(.title3).bold()
                                .foregroundColor(Color(Constant.colorRed))
                                .padding(.trailing, 16.0)
                        }
                        
                    }
                    Text("Add task")
                        .font(.title3).bold()
                        .foregroundColor(.white)
                }
                .frame(height: 48)
                .background(Color(hue: 0.683, saturation: 0.015, brightness: 0.138))
                List {
                    TextField(text: $model.title, prompt: Text("Title").foregroundColor(Color(Constant.colorDarkGray))) {
                        Text("Username")
                    }
                    .foregroundColor(Color(Constant.colorGray))
                    .listRowBackground(Color(hue: 0.683, saturation: 0.015, brightness: 0.138))
                    TextField(text: $model.description, prompt: Text("Description").foregroundColor(Color(Constant.colorDarkGray))) {
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

struct CreateTaskScreen_Previews: PreviewProvider {
    static var previews: some View {
        CreateTaskScreen(showingSheet: .constant(false), model: CreateTaskScreen.Model(typeScreen: .currentTask))
    }
}
