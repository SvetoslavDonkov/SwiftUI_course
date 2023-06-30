//
//  ProductView.swift
//  MobileTraining
//
//  Created by Svetoslav Donkov on 14.05.23.
//

import SwiftUI
import URLImage
import Factory

struct ProductView: View {
    @StateObject var viewModel = ProductViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            if !viewModel.loading {
                URLImage(URL(string: viewModel.product.image!)!) {
                    EmptyView()
                } inProgress: { progress in
                    Text("Loading...")
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .frame(maxHeight: .infinity)
                        .font(.system(size: 30))
                } failure: { error, retry in
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } content: { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(15)
                }
                
                Text(viewModel.product.title!)
                    .font(.title)
                    .fontWeight(.bold)
                
                Text(viewModel.product.shortDescription!)
                    .font(.body)
                    .foregroundColor(.secondary)
                
                Text(viewModel.product.description!)
                    .font(.body)
                    .foregroundColor(.primary)
                    .lineLimit(6)
                    .multilineTextAlignment(.leading)
                
                HStack {
                    Text("$\(viewModel.product.price!, specifier: "%.2f")")
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
            
            else {
                Text("Loading...")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .padding()
        .background(
            Image("Background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
        )
        .onAppear {
            viewModel.getProduct()
        }
        .navigationBarTitle(Text("Product details"), displayMode: .inline)
        .navigationBarBackButtonHidden(true)
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView()
    }
}
