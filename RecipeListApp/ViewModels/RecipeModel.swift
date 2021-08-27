//
//  RecipeModel.swift
//  RecipeListApp
//
//  Created by Jee Zhou on 8/25/21.
//

import Foundation

//whats the real difference between models and viewModels?  While models is about the more atomic level of data, viewModels can be seen as the more aggregate data the application needs to function.  So Models can be individual recipes and viewModels then can probably structured as the encapsulation of a collection of recipes used to display a list perhaps?

class RecipeModel: ObservableObject{  //conforms to observable object
    @Published var recipes = [Recipe]()  //publish any changes so recipelistview gets the updates
    
    init(){
        //No need to create an instance of data service, since it only contains a static method.  We can call it directly ONLY IF we put the static keyword infront of it.
        self.recipes = DataService.getLocalData()
        
        //set the recipes property
    }
}
