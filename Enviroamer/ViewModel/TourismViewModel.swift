//
//  TourismViewModel.swift
//  Enviroamer
//
//  Created by tiyas aria on 20/07/23.
//

import Foundation


final class TourismViewModel : ObservableObject{

    @Published var tourisms = [Location]()
    
    
    init()  {
         loadData()
    }
    
    func loadData()   {
        guard let url = Bundle.main.url(forResource: "data", withExtension: "json")
        else{
            print("json not found")
            return
        }
        
        do {
                let data = try Data(contentsOf: url)
            let tourisms = try JSONDecoder().decode([Location].self, from: data)
            self.tourisms = tourisms
            print("Wisata nya adalah \(String(describing: tourisms[0].namaProvinsi)) dan memiliki salah satu wisata \(tourisms[0].listWisata[0].nama ?? "")")
        } catch {
                print("Error decoding JSON data: \(error)")
        }
   }
    
    
    func loadSpesificCity(idProvinsi:Int)->Location?{
        return tourisms.first(where: {$0.idProvinsi == idProvinsi})
    }
}
