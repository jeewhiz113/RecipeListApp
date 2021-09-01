//
//  RecipeFeaturedViews.swift
//  RecipeListApp
//
//  Created by Jee Zhou on 8/29/21.
//

import SwiftUI

struct RecipeFeaturedView: View {
    @State var detailShowing = false
    //note that if we were to do:
    //@ObservedObject var model = RecipeModel()
    
    //And assume RecipeModel() instantiate some api request, then we are asking the computer to query the api twice of the same data, further more, we have two instantiations of model, and if one is modified, we wish to have it drive the front end of BOTH tabs.  How do we keep them sync'ed?
    //The answer is to have one model and drive BOTH listview and featuredview with it!  This is the introduction to environment object modifier (much like redux)
    
    //Since this is a subview of the tabview and in the tabview, the environment object modifier is defined:
    @EnvironmentObject var model: RecipeModel
    @State var tabSelectionIndex = 0
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Featured Recipes")
                .bold()
                .padding(.leading)
                .padding(.top, 30)
                .font(Font.custom("Avenir Heavy", size:24))
            GeometryReader{ geo in
                TabView(selection: $tabSelectionIndex){  //Note tabView changes tabselectionIndex
                    //note tabView gets auto centered. and the Rectangle takes up the whole screen, so the frame is actually specifying the width and height of the tabview
                    //go through all items in the recipes array and if featured has a true value then display the card.
                    ForEach(0..<model.recipes.count){ index in
                        if (model.recipes[index].featured){  //if featured is true
                            Button(action: {
                                //show the detail sheet
                                self.detailShowing = true;
                            }, label: {
                                ZStack{
                                    //ZStack cause I wanna add image and name on top of the rectangle, so the rectangle serves as a card
                                    Rectangle()
                                        .foregroundColor(.white)
                                    VStack (spacing:0){
                                        Image(model.recipes[index].image)
                                            .resizable()
                                            .aspectRatio(contentMode:.fill)
                                            .clipped()
                                        Text(model.recipes[index].name)
                                            .padding(5)
                                            .font(Font.custom("Avenir", size:15))
                                    }
                                        //.shadow(radius:1000)
                                }.frame(width: geo.size.width-40, height: geo.size.height-100)  //Why is it centered?  The width parameter says we have 40 to play with on the sides together.
                                .cornerRadius(20)  //the zstack has this much width and height to contain the rectangle and vstack
                                .shadow(color:Color.black, radius:10, x:-5,y:5)
                            })
                            .tag(index)  //this is to keep track of the curren recipe the user is looking at
                            .sheet(isPresented: $detailShowing){
                                //show the recipe detail view if true, sheet is a property of the Button class
                                RecipeDetailView(recipe: model.recipes[index])  //show this recipe
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))  //this shows the little dots at the bottom showing how many to swipe through
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))  //makes the scroll dots more visible
            }
            VStack (alignment: .leading, spacing:10) {
                Text("Preparation Time:")
                    .font(Font.custom("Avenir Heavy", size:16))

                Text(model.recipes[tabSelectionIndex].prepTime)
                    .font(Font.custom("Avenir", size:15))
                Text("Highlights")
                    .font(Font.custom("Avenir Heavy", size:16))
                RecipeHighlights(highlights: model.recipes[tabSelectionIndex].highlights)

                
            }.padding([.leading, .bottom])
        }
        .onAppear(perform: {
            setFeaturedIndex()
        })
    }
    
    func setFeaturedIndex(){  //??? What is going on here?
        //find the index of the first recipe that is featured
        var index = model.recipes.firstIndex{
            (recipe) -> Bool in
            return recipe.featured
        }
        tabSelectionIndex = index ?? 0
    }
}

struct RecipeFeaturedViews_Previews: PreviewProvider {
    static var previews: some View {
        RecipeFeaturedView()
            .environmentObject(RecipeModel())
    }
}
