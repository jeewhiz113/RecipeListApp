//
//  DataService.swift
//  RecipeListApp
//
//  Created by Jee Zhou on 8/25/21.
//

import Foundation
//So this here serves the purpose of the controller in a web app.  In the services folder, the data fetching code goes in here so that it is more modulized and if an error occurs, I know exactly where to go to debug the code.
class DataService {
    //a function to retrieve the local data and return a recipes array
    static func getLocalData() -> [Recipe]{
        //sequence of events here:
        //get a url path to the json file
        let pathString = Bundle.main.path(forResource: "recipes", ofType: "json")
        //create a url object, another way to check the nilness or pathString is by using a guard statement
        guard pathString != nil else {
            return [Recipe]()  //return an empty recipe array if nil
        }
        
        //create a data object
        let url = URL(fileURLWithPath: pathString!)  //note pathString needs to be unwrapped since it could be nil
        //decode the data with a json decoder
        do {
            let data = try Data(contentsOf: url)
            //decode the data with a json decoder
            let decoder = JSONDecoder()
            //add the unique IDs
            do{
                let recipeData = try decoder.decode([Recipe].self, from: data)
                for r in recipeData{
                    r.id = UUID()
                }
                return recipeData
            }catch {
                print(error)
            }
        }catch {
            print(error)
        }
        return [Recipe]()
    }
}
