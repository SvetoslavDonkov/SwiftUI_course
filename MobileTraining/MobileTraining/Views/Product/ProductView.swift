//
//  ProductView.swift
//  MobileTraining
//
//  Created by Svetoslav Donkov on 14.05.23.
//

import SwiftUI
import URLImage

struct ProductView: View {
    @State private var productViewModel: ProductViewModel?
    let productRepository: ProductRepository
    
    init(productRepository: ProductRepository) {
        self.productRepository = productRepository
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            if let productViewModel = productViewModel {
//                URLImage(URL(string: productViewModel.product.image)!) {
//                    EmptyView()
//                } inProgress: { progress in
//                    Text("Loading...")
//                        .padding()
//                        .frame(maxWidth: .infinity, alignment: .center)
//                        .frame(maxHeight: .infinity)
//                        .font(.system(size: 30))
//                } failure: { error, retry in
//                    Image(systemName: "photo")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                } content: { image in
//                    image
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .cornerRadius(15)
//                }
                
                Text(productViewModel.product.title)
                    .font(.title)
                    .fontWeight(.bold)
                
                Text(productViewModel.product.short_description)
                    .font(.body)
                    .foregroundColor(.secondary)
                
                Text(productViewModel.product.description)
                    .font(.body)
                    .foregroundColor(.primary)
                    .lineLimit(6)
                    .multilineTextAlignment(.leading)
                
                HStack {
                    Text("$\(productViewModel.product.price, specifier: "%.2f")")
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
            } else {
                Text("Loading...")
            }
        }
        .padding()
        .navigationBarTitle(Text("Product details"), displayMode: .inline)
        .background(
            Image("Background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
        )
        .onAppear {
            productViewModel = ProductViewModel(productRepository: productRepository)
            productViewModel?.getProduct { success in
                if success {
                    // Handle success
                } else {
                    // Handle failure
                }
            }
        }
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        let productRepository = ProductRepository()
        return ProductView(productRepository: productRepository)
    }
}
