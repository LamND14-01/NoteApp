//
//  CalendarScreen.swift
//  NoteApp
//
//  Created by Eloo on 04/09/2022.
//

import SwiftUI

struct CalendarScreen: View {
    @Environment(\.safeAreaInsets) var safeAreaInsets
    @Environment(\.dismiss) var dismiss
    @StateObject var model = Model()
    @State private var createSheet = false
    @State private var detailSheet = false
    private let typeScreen: Screen
    
    let columns = [
        GridItem(.flexible())
    ]
    
    init(typeScreen: Screen) {
        self.typeScreen = typeScreen
    }
    
    var body: some View {
        ZStack {
            Color(Constant.colorBlack)
                .ignoresSafeArea()
            VStack {
                Rectangle().frame(width: 0, height: safeAreaInsets.top)
                NaviBar {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.backward")
                            .frame(width: 36, height: 36)
                            .foregroundColor(Color(Constant.colorGray))
                            .font(.title)
                    }
                } centerView: {
                    Text("\(model.typeScreen?.rawValue ?? "")")
                        .font(.title2).bold()
                        .foregroundColor(Color(Constant.colorGray))
                }
                .padding(.horizontal, 8.0)
                if model.typeScreen == .currentTask {
                    CalendarView(currentDate: $model.currentDate, selectedDate: $model.selectedDate)
                        .padding(.horizontal, 8.0)
                }

                if model.filteredTask().isEmpty, model.filteredCompletedTask().isEmpty {
                    Text("No tasks to do")
                        .font(.title3).bold()
                        .foregroundColor(Color(Constant.colorDarkGray))
                        .padding(.top, 48.0)
                } else {
                    List {
                        if !model.filteredTask().isEmpty {
                            Section {
                                ForEach(model.filteredTask()) { task in
                                    taskView(task: task)
                                        .swipeActions(edge: .leading) {
                                            Button {
                                                model.completeTask(task)
                                            } label: {
                                                Image(systemName: "checkmark")
                                            }
                                            .tint(.green)
                                        }
                                        .swipeActions(edge: .trailing) {
                                            Button {
                                                model.deleteTask(task)
                                            } label: {
                                                Image(systemName: "trash")
                                            }
                                            .tint(Color(Constant.colorRed))
                                        }
                                }
                                .listRowInsets(.init())
                                .listRowBackground(Color(hue: 0.683, saturation: 0.015, brightness: 0.138))
                            }
                        }
                        if !model.filteredCompletedTask().isEmpty, model.typeScreen == .currentTask {
                            Section(header: Text("Completed task")
                                .font(.callout).bold()
                                .foregroundColor(Color(Constant.colorDarkGray))) {
                                    ForEach(model.filteredCompletedTask()) { task in
                                        taskView(task: task)
                                            .swipeActions(edge: .leading) {
                                                Button {
                                                    model.completeTask(task)
                                                } label: {
                                                    Image(systemName: "checkmark")
                                                }
                                                .tint(.green)
                                            }
                                            .swipeActions(edge: .trailing) {
                                                Button {
                                                    model.deleteTask(task)
                                                } label: {
                                                    Image(systemName: "trash")
                                                }
                                                .tint(Color(Constant.colorRed))
                                            }
                                    }
                                    .listRowInsets(.init())
                                    .listRowBackground(Color(hue: 0.683, saturation: 0.015, brightness: 0.138))
                                }
                        }
                        Rectangle()
                            .frame(width: 0, height: 24 + safeAreaInsets.top)
                            .listRowBackground(Color(Constant.colorBlack))
                    }
                    .listRowInsets(.init())
                    .background(Color(Constant.colorBlack))
                    .scrollContentBackground(.hidden)
                }
                Spacer()
            }
            if model.typeScreen != .completed {
                createButton()
            }
            
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
        .onAppear() {
            model.typeScreen = typeScreen
        }
    }
    
    @ViewBuilder
    func taskView(task: TaskValue) ->some View {
        HStack(spacing: 8) {
            if model.isExpired(task.startDate) {
                Rectangle()
                    .frame(width: 3, height: 40)
                    .foregroundColor(task.isSuccess ? .green : .red)
                Image(systemName: task.isSuccess ? "text.badge.checkmark" : "calendar.badge.exclamationmark")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 18, height: 18)
                    .foregroundColor(Color(Constant.colorGray))
            }
            VStack(alignment: .leading) {
                Text("\(task.title)")
                    .font(.callout)
                    .foregroundColor(Color(Constant.colorGray))
                    .lineLimit(1)
                Text("From: \(task.startDate?.getDay() ?? "")   To: \(task.endDate?.getDay() ?? "")")
                    .font(.caption2)
                    .foregroundColor(Color(Constant.colorGray))
                    .lineLimit(1)
            }
            .padding(.leading, 6.0)
            Spacer()
            Image(systemName: task.isImportant ? "star.fill" : "star")
                .font(.system(size: 16, weight: .medium, design: .default))
                .foregroundColor(task.isImportant ? .yellow : Color(Constant.colorGray))
                .padding(.trailing, 16.0)
                .onTapGesture {
                    model.importantChange(task)
                }
        }
        .padding(0)
        .background(Color(hue: 0.683, saturation: 0.015, brightness: 0.138))
        .onTapGesture {
            detailSheet = true
        }
        .sheet(isPresented: $detailSheet) {
            DetailScreen(showingSheet: $detailSheet, task: task)
                .presentationDetents([.fraction(2/3)])
        }
    }
    
    @ViewBuilder
    func createButton() ->some View {
        VStack(alignment: .trailing) {
            Spacer()
            Button {
                createSheet.toggle()
            } label: {
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 60, weight: .medium, design: .default))
                    .background(content: {
                        Circle().foregroundColor(Color(Constant.colorGray))
                            .frame(width: 60)
                    })
                    .foregroundColor(Color(Constant.colorRed))
                    .alignTrailing()
            }
            .offset(CGSize(width: -10, height: -(24 + safeAreaInsets.top)))
            
        }
        .sheet(isPresented: $createSheet) {
            CreateTaskScreen(showingSheet: $createSheet, typeScreen: model.typeScreen ?? .currentTask)
                .presentationDetents([.fraction(2/3)])
        }
    }
}

struct CalendarScreen_Previews: PreviewProvider {
    static var previews: some View {
        CalendarScreen(typeScreen: .currentTask)
    }
}
