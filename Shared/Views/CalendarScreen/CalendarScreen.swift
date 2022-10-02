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
    @ObservedObject var model = Model()
    @State private var showingSheet = false
    
    let columns = [
        GridItem(.flexible())
    ]
    
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
                    Text("Current task")
                        .font(.title2).bold()
                        .foregroundColor(Color(Constant.colorGray))
                }
                .padding(.horizontal, 8.0)
                CalendarView(currentDate: $model.currentDate, selectedDate: $model.selectedDate)
                    .padding(.horizontal, 8.0)
                if model.filteredTask().isEmpty {
                    Text("No tasks to do")
                        .font(.title3).bold()
                        .foregroundColor(Color(Constant.colorDarkGray))
                        .padding(.top, 48.0)
                } else {
                    List {
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
                                    .tint(.red)
                                }
                        }
                        .listRowInsets(.init())
                        .listRowBackground(Color(hue: 0.683, saturation: 0.015, brightness: 0.138))
                    }
                    .listRowInsets(.init())
                    .background(Color(Constant.colorBlack))
                    .scrollContentBackground(.hidden)
                }
                Spacer()
            }
            VStack(alignment: .trailing) {
                Spacer()
                Button {
                    showingSheet.toggle()
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
            .sheet(isPresented: $showingSheet) {
                CreateTaskScreen(showingSheet: $showingSheet)
                    .presentationDetents([.height(Constant.sizeHeight! * 2 / 3)])
            }
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
    
    @ViewBuilder
    func taskView(task: TaskValue) ->some View {
        HStack(spacing: 8) {
            Rectangle()
                .frame(width: 3, height: 40)
                .foregroundColor(Color(Constant.colorRed))
            Image(systemName: "calendar.badge.exclamationmark")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 18, height: 18)
                .foregroundColor(Color(Constant.colorGray))
            Text("\(task.title)")
                .font(.callout)
                .foregroundColor(Color(Constant.colorGray))
                .lineLimit(1)
            Spacer()
            Text(task.startDate?.getHour() ?? "")
                .font(.caption.bold())
                .foregroundColor(Color(Constant.colorGray))
                .lineLimit(1)
                .padding(.trailing, 6.0)
        }
        .padding(0)
        .background(Color(hue: 0.683, saturation: 0.015, brightness: 0.138))
    }
}

struct CalendarScreen_Previews: PreviewProvider {
    static var previews: some View {
        CalendarScreen()
    }
}
