//
//  HomeScreen.swift
//  NoteApp
//
//  Created by Eloo on 04/09/2022.
//

import SwiftUI

struct HomeScreen: View {
    @Environment(\.safeAreaInsets) var safeAreaInsets
    @ObservedObject var model = Model()
    @State private var routerCategory: [Router] = []
    
    var body: some View {
        NavigationStack(path: $routerCategory) {
            ZStack {
                Color(Constant.colorBlack)
                    .ignoresSafeArea()
                VStack(alignment: .leading) {
                    headerView()
                    List {
                        ForEach(Category.data) { category in
                            listItems(category)
                                .listRowBackground(Color(hue: 0.683, saturation: 0.015, brightness: 0.138))
                        }
                    }
                    .background(Color(Constant.colorBlack))
                    .scrollContentBackground(.hidden)
                }
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: .infinity,
                    alignment: .topLeading
                )
            }
            .navigationDestination(for: Router.self) { router in
                navigate(router)
            }
            .ignoresSafeArea()
        }
    }
    
    @ViewBuilder
    func headerView() -> some View {
        HStack(alignment: .center) {
            Image("avatar")
                .resizable()
                .frame(width: 36, height: 36)
                .aspectRatio(contentMode: .fit)
                .background(.white)
                .clipShape(Circle())
            Text("LamnND")
                .font(.headline)
                .foregroundColor(Color(Constant.colorGray))
            Spacer()
            Button {
                print("search")
            } label: {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(Color(Constant.colorGray))
                    .aspectRatio(contentMode: .fit)
            }
            
        }
        .padding(.horizontal, 16.0)
        .frame(height: 60)
        .padding(.top, safeAreaInsets.top)
    }
    
    @ViewBuilder
    func listItems(_ category: Category) -> some View {
        Button {
            routerCategory.append(Router(screen: category.title))
        } label: {
            HStack {
                Image(systemName: category.icon)
                    .resizable()
                    .frame(width: 18, height: 18)
                    .foregroundColor(category.color)
                    .aspectRatio(contentMode: .fit)
                Text("\(category.title.rawValue)")
                    .font(.subheadline)
                    .foregroundColor(Color(Constant.colorGray))
                    .padding(.leading, 4.0)
            }
        }
    }
    
    @ViewBuilder 
    func navigate(_ router: Router) -> some View {
        CalendarScreen(typeScreen: router.screen)
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
