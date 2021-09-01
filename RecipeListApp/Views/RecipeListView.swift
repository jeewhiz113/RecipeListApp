//
//  ContentView.swift
//  RecipeListApp
//
//  Created by Jee Zhou on 8/25/21.
//

import SwiftUI

struct RecipeListView: View {
    //so making a recipemodel, in it we call a function in services to convert all in the recipes.json into an array of Recipes
//    @ObservedObject var model = RecipeModel()
    //Since this is a subview of the tabview and in the tabview, the environment object modifier is defined:
    @EnvironmentObject var model: RecipeModel
    
    var body: some View {
        //lets add a navigationview to wrap the whole list
        NavigationView{
            VStack(alignment: .leading){
                Text("All Recipes")
                    .bold()
                    .padding(.top, 30)
                    .font(Font.custom("Avenir Heavy", size:24))

                ScrollView{
                    LazyVStack(alignment: .leading){  //generate only when it comes into view
                        ForEach(model.recipes){ r in
                            NavigationLink(
                                destination: RecipeDetailView(recipe: r),
                                label: {
                                    //Mark: Row Item
                                    HStack (spacing:20){
                                        Image(r.image)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                            .clipped()
                                            .cornerRadius(8)
                                        VStack(alignment: .leading){
                                            Text(r.name)
                                                .foregroundColor(.black)
                                                .font(Font.custom("Avenir Heavy", size:16))

                                            RecipeHighlights(highlights: r.highlights)
                                                .foregroundColor(.black)
                                        }
                                        
                                    }
                                }
                            )
                        }
                    }
                }
            }
            .navigationBarHidden(true)
            .padding(.leading)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
            .environmentObject(RecipeModel())
    }
}
