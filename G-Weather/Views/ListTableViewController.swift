//
//  ListTableViewController.swift
//  G-Weather
//
//  Created by Сперанский Никита on 18.02.2022.
//

import UIKit


class ListTableViewController: UITableViewController {
    
    let emptyCity = Weather()
    
    var citiesArray = [Weather]()
    let nameCitiesArray = ["Москва", "Санкт-Петербург", "Иваново", "Кострома",
                           "Ярославль", "Сосновый бор", "Светогорск", "Екатеринбург", "Судак", "Сочи"]
    
    let networkManager = NetworkManager()
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if citiesArray.isEmpty {
            citiesArray = Array(repeating: emptyCity, count: nameCitiesArray.count)
        }
        
        addCities()

    }
    
    // MARK: - Func
    
    func addCities() {
        getCiyWeather(citiesArray: self.nameCitiesArray) { (index, weather) in
            self.citiesArray[index] = weather
            self.citiesArray[index].name = self.nameCitiesArray[index]
            
            print(self.citiesArray)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }

            
        }
    }
    
    
    // MARK: - Table view data source



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citiesArray.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListCell

        
        var weather = Weather()
        weather = citiesArray[indexPath.row]
        cell.configure(weather: weather)

        return cell
    }

}
