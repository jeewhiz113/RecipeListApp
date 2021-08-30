//
//  RecipeFeaturedViews.swift
//  RecipeListApp
//
//  Created by Jee Zhou on 8/29/21.
//

import SwiftUI

struct RecipeFeaturedView: View {
    
    //note that if we were to do:
    //@ObservedObject var model = RecipeModel()
    
    //And assume RecipeModel() instantiate some api request, then we are asking the computer to query the api twice of the same data, further more, we have two instantiations of model, and if one is modified, we wish to have it drive the front end of BOTH tabs.  How do we keep them sync'ed?
    //The answer is to have one model and drive BOTH listview and featuredview with it!  This is the introduction to environment object modifier (much like redux)
    
    //Since this is a subview of the tabview and in the tabview, the environment object modifier is defined:
    @EnvironmentObject var model: RecipeModel
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct RecipeFeaturedViews_Previews: PreviewProvider {
    static var previews: some View {
        RecipeFeaturedView()
    }
}
