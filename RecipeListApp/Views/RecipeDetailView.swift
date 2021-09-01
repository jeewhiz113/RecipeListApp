//
//  RecipeDetailView.swift
//  RecipeListApp
//
//  Created by Jee Zhou on 8/26/21.
//

import SwiftUI

struct RecipeDetailView: View {
    var recipe : Recipe  //this is going to be determined depending on what the user tabs on, but for now, recipe is just going to be the type Recipe and it takes the value of model.recipes[0] initially
    @State var selectedServingSize = 2;  //default size is 2

    var body: some View {
        ScrollView{
            //Mark: Recipe Image
            VStack(alignment: .leading){
                Image(recipe.image)
                    .resizable()
                    .scaledToFit()
                //Mark: Recipe Title
                Text(recipe.name)
                    .bold()
                    .padding([.top, .bottom], 5)
                    .padding(.leading)
                    .font(Font.custom("Avenir Heavy", size:24))

                
                
                //Mark: Serving size picker
                VStack(alignment:.leading){
                    Text("Selected your serving size:")
                        .font(Font.custom("Avenir", size:15))
                    Picker("", selection: $selectedServingSize){
                        Text("2").tag(2)
                        Text("4").tag(4)
                        Text("6").tag(6)
                        Text("8").tag(8)

                    }
                    .font(Font.custom("Avenir", size:15))
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width:200)
                }
                .padding(.horizontal, 16)
                
                //Mark: Ingredients
                VStack(alignment: .leading){
                    Text("Ingredients")
                        .font(Font.custom("Avenir Heavy", size:16))
                        .padding(.vertical, 5.0)
                        
                    //display the ingredient for the current item
                    //need to understand how this getPortion method is getting called everytime we click on a new picker item.
                    ForEach(recipe.ingredients){ item in
                        Text("• " + RecipeModel.getPortion(ingredient:item, recipeServings: recipe.servings, targetServings: selectedServingSize) + " " + item.name.lowercased())
                            .padding(.bottom, 2)
                            .font(Font.custom("Avenir", size:15))
                    }
                }
                .padding(.horizontal, 16)
                //swiftui divider:
                Divider()
                //Mark:Directions
                VStack(alignment: .leading){
                    Text("Directions")
                        .font(Font.custom("Avenir Heavy", size:16))
                        .padding([.top, .bottom],  5)
                    ForEach(0..<recipe.directions.count, id:\.self){ index in
                        Text(String(index+1) + ".  " + recipe.directions[index])
                            .padding(.bottom, 4)
                            .font(Font.custom("Avenir", size:15))

                    }
                }.padding(.horizontal, 16)
                
            }
        
        }
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
