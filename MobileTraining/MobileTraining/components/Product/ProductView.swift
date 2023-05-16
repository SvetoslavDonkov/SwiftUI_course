//
//  ProductView.swift
//  MobileTraining
//
//  Created by Svetoslav Donkov on 14.05.23.
//

import SwiftUI

struct Product: Identifiable {
    let id: Int
    let imageName: String
    let title: String
    let description: String
    let details: String
    let price: Double
}

let sampleProduct = Product(
    id: 1,
    imageName: "photo",
    title: "Stargazer's Tea Set",
    description: "Category: Home",
    details: "Indulge in a heavenly tea experience with our Stargazer’s Tea Set, featuring a constellation-themed teapot and matching teacups. Crafted from fine porcelain, this elegant set will transport you to the cosmos with every sip.",
    price: 90.00
)

struct ProductView: View {
    var product: Product
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Image(systemName: product.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Text(product.title)
                .font(.title)
                .fontWeight(.bold)
            
            Text(product.description)
                .font(.body)
                .foregroundColor(.secondary)
            
            Text(product.details)
                .font(.body)
                .foregroundColor(.primary)
                .lineLimit(6)
                .multilineTextAlignment(.leading)
            
            HStack {
                Text("$\(product.price, specifier: "%.2f")")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
            }
            Spacer()
            Button("Add to Cart") {
                // Handle adding product to cart
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color("Button_color"))
            .foregroundColor(.white)
            .cornerRadius(25)
        }
        .padding()
        .navigationBarTitle(Text("Product details"), displayMode: .inline)
        .background(
            Image("LoginBackground")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
        )
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView(product: sampleProduct)
    }
}
