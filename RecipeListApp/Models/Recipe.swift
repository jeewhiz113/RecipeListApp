//
//  Recipe.swift
//  RecipeListApp
//
//  Created by Jee Zhou on 8/25/21.
//

import Foundation

class Recipe: Identifiable, Decodable {  //note identifiable makes it so the List object can read it
    //Decodable makes it so swift could read it, or this can be hooked up to the .json file.
    var id:UUID?
    var name: String
    var featured: Bool
    var image: String
    var description: String
    var prepTime: String
    var cookTime: String
    var totalTime: String
    var servings: Int  //this gave me so much grief haha!
    var highlights: [String]
    var ingredients: [Ingredient]
    var directions: [String]
    
}

class Ingredient: Identifiable, Decodable {
    var id:UUID?
    var name: String
    var num: Int?
    var denom: Int?
    var unit: String?
}
