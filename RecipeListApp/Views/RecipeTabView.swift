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
            //So to modify the featured view, we simply modofy the RecipeFeaturedView file
            RecipeFeaturedView()  //Note the tabItem below is attached to this, this gets displayed initially regardless since it is the first tabItem
                .tabItem{
                    Image(systemName: "star.fill")
                    Text("Featured")
                }
            RecipeListView()  //when the tab is hit, we switch to RecipeListView
                .tabItem{
                    VStack{
                        Image(systemName: "list.bullet")
                        Text("List")
                    }
                }
        }
        .environmentObject(RecipeModel())
    }
}

struct RecipeTabView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeTabView()
    }
}
