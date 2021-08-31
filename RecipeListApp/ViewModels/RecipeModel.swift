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
    
    static func getPortion(ingredient: Ingredient, recipeServings: Int, targetServings: Int) -> String {  //static keyword means one can run this function without creating a RecipeModel
        //get a single serving size by multiplying denominator by the recipe servings
        var portion = ""
        var numerator = ingredient.num ?? 1  //if ingredient.num is nil, then assign it the value 1
        var denominator = ingredient.denom ?? 1
        var wholePortions = 0
        
        if ingredient.num != nil {  //only matters is numerator is not nil
            denominator = denominator * recipeServings
            //get target portion by multipluying numerator by target servings
            numerator *= targetServings
            //reduce fraction by greatest common divisor
            let divisor = Rational.greatestCommonDivisor(numerator, denominator)
            numerator /= divisor
            denominator /= divisor
            //get the whole portion if numerator > denominator
            if numerator >= denominator {
                //calculated the whole portions
                wholePortions = numerator / denominator
                
                //calculated the remainder
                numerator = numerator % denominator
                
                //assign to the portion string
                portion += String(wholePortions)
            }
            //express the remainder as a fraction
            if numerator > 0 {
                //assign remainder as fraction to the portion string
                portion += wholePortions > 0 ? " " : ""
                portion += "\(numerator)/\(denominator)"
            }
        }
        if var unit = ingredient.unit {
            if wholePortions > 1 {
                //calculate appropriate suffix
                if unit.suffix(2) == "ch" {
                    unit = "es"
                }else if unit.suffix(1) == "f" {
                    unit = String(unit.dropLast())
                    unit += "ves"
                }else{
                    unit += "s"
                }
            }
            
            portion += ingredient.num == nil && ingredient.denom == nil ? "" : " "
            return portion + unit
        }
        
        return portion
    }
}
