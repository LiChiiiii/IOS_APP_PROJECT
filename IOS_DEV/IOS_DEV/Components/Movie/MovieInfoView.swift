//
//  MovieInfoView.swift
//  IOS_DEV
//
//  Created by Jackson on 1/5/2021.
//

import SwiftUI

struct MovieInfoView: View {
    var data : temp
    var body: some View {
        HStack {
            VStack(alignment:.leading,spacing:5){
                Text("MORE INFORMATION")
                    .bold()
                    .font(.title2)

                
                HStack{
                    VStack(alignment:.leading,spacing:2){
                        Text("Release Date:")
                        Text("Movie Time:")
                        Text("MovieLanguage:")
                        Text("Cast:")
                        Text("Director:")
                        Text("Restricted Level:")
                        Text("Region:")
                        Text("Company:")
                    }
                    VStack(alignment:.leading,spacing:2){
                        Text(tempData.releaseDate)
                        Text(tempData.movieTime)
                        Text(tempData.movieLanguage)
                        Text(tempData.cast[0])
                        Text(tempData.director[0])
                        Text(tempData.restrictedLevel)
                        Text(tempData.region)
                        Text(tempData.company)
                    }
                    .foregroundColor(.white)
                }
                .padding()
                .foregroundColor(.gray)
                
            }
            Spacer()
        }
        .foregroundColor(.white)
        .padding(.vertical)
    }
}

struct MovieInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color.black.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            MovieInfoView(data: tempData)
                
        }
        
    }
}


struct temp{
    let releaseDate:String
    let movieTime:String
    let movieLanguage:String
    let cast:[String]
    let director:[String]
    let restrictedLevel:String
    let region:String
    let company:String
}

let tempData = temp(releaseDate: "12-12-2020", movieTime: "162mins", movieLanguage: "English", cast: ["Jackson","Tome","Jack","Amy"], director: ["test1","test2","test3"], restrictedLevel:"16+" , region: "US", company: "Marval")
