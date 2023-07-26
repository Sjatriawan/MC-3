//
//  FavoritesViewModel.swift
//  Enviroamer
//
//  Created by tiyas aria on 25/07/23.
//

import Foundation


//final class Database {
//    private let FAV_KEY = "fav_key"
//
//    func save(items : Set<Int>) {
//        let array = Array(items)
//        UserDefaults.standard.set(array, forKey: FAV_KEY)
//
//    }
//
//    func load() -> Set<Int>{
//        let array = UserDefaults.standard.array(forKey: FAV_KEY) as? [Int] ?? [Int]()
//
//        return Set(array)
//    }
//}

class FavoritesViewModel : ObservableObject{
    @Published var favorites: [Location] = [] 
      
      private let FAV_KEY = "fav_key"
      
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
             let decodedFavorites = try? JSONDecoder().decode([Location].self, from: data) {
              favorites = decodedFavorites
          }
      }
      
      func addToFavorites(_ item: Location) {
          favorites.append(item)
          saveFavorites()
      }
      
      func removeFromFavorites(_ item: Location) {
          if let index = favorites.firstIndex(of: item) {
              favorites.remove(at: index)
              saveFavorites()
          }
      }
      
      func isFavorite(_ item: Location) -> Bool {
          favorites.contains(item)
      }
    
}
