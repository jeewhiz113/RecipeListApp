//
//  RecipeDetailView.swift
//  RecipeListApp
//
//  Created by Jee Zhou on 8/26/21.
//

import SwiftUI

struct RecipeDetailView: View {
    var recipe : Recipe  //this is going to be determined depending on what the user tabs on, but for now, recipe is just going to be the type Recipe and it takes the value of model.recipes[0] initially
    var body: some View {
        
        ScrollView{
            //Mark: Recipe Image
            VStack(alignment: .leading){
                Image(recipe.image)
                    .resizable()
                    .scaledToFit()
                //Mark: Ingredients
                VStack(alignment: .leading){
                    Text("Ingredients")
                        .font(.headline)
                        .padding(.vertical, 5.0)
                        
                    //display the ingredient for the current item
                    ForEach(recipe.ingredients, id:\.self){ item in
                        Text("•" + item)
                            .padding(.bottom, 2)
                    }
                }
                .padding(.horizontal, 16)
                //swiftui divider:
                Divider()
                //Mark:Directions
                VStack(alignment: .leading){
                    Text("Directions")
                        .font(.headline)
                        .padding([.top, .bottom],  5)
                    ForEach(0..<recipe.directions.count, id:\.self){ index in
                        Text(String(index+1) + ". " + recipe.directions[index])
                            .padding(.bottom, 4)
                    }
                }
                .padding(.horizontal, 16)
            }
        
        }.navigationBarTitle(recipe.name)
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        //create a dummy recipe and pass it into the detail view so that we can see a preview
        
        let model = RecipeModel()
        
        //call the recipedetailview function with the recipe being the first json in the model array
        RecipeDetailView(recipe: model.recipes[0])  //just to see what it looks like on the front end.
    }
}
