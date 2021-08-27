//
//  RecipeTabView.swift
//  RecipeListApp
//
//  Created by Jee Zhou on 8/27/21.
//

import SwiftUI

struct RecipeTabView: View {
    var body: some View {
        TabView{
            Text("Featured View")
                .tabItem{
                    Image(systemName: "star.fill")
                    Text("Featured")
                }
            RecipeListView()
                .tabItem{
                    VStack{
                        Image(systemName: "list.bullet")
                        Text("List")
                    }
                }
        }
    }
}

struct RecipeTabView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeTabView()
    }
}
