//
//  FavoritesDestinationViewModel.swift
//  Enviroamer
//
//  Created by tiyas aria on 26/07/23.
//

import Foundation

class FavoriteDestinationViewModel : ObservableObject{
    @Published var favorites: [Tourism] = []
      
      private let FAV_KEY = "fav_key_tourism"
      
      init() {
          loadFavorites()
      }
      
      func saveFavorites() {
          if let encodedData = try? JSONEncoder().encode(favorites) {
              UserDefaults.standard.set(encodedData, forKey: FAV_KEY)
          }
      }
      
      func loadFavorites() {
          if let data = UserDefaults.standard.data(forKey: FAV_KEY),
             let decodedFavorites = try? JSONDecoder().decode([Tourism].self, from: data) {
              favorites = decodedFavorites
          }
      }
      
      func addToFavorites(_ item: Tourism) {
          favorites.append(item)
          saveFavorites()
      }
      
      func removeFromFavorites(_ item: Tourism) {
          if let index = favorites.firstIndex(of: item) {
              favorites.remove(at: index)
              saveFavorites()
          }
      }
      
      func isFavorite(_ item: Tourism) -> Bool {
          favorites.contains(item)
      }
}
