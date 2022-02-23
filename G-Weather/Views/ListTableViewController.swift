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
//    let nameCitiesArray = ["Москва", "Санкт-Петербург", "Иваново", "Кострома",
//                           "Ярославль", "Сосновый бор", "Светогорск", "Екатеринбург", "Судак", "Сочи"]
    var nameCitiesArray = ["Москва", "Петербург", "Пенза", "Уфа",
                           "Новосибирск", "Челябинск", "Омск", "Екатеринбург", "Томск", "Сочи"]
    
    
    let networkManager = NetworkManager()
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if citiesArray.isEmpty {
            citiesArray = Array(repeating: emptyCity, count: nameCitiesArray.count)
        }
        
        addCities()

    }
    
    
    
    @IBAction func pressAddCityButton(_ sender: Any) {
        alertPlusCity(name: "Город", placeholder: "Введите название города") { (city) in
            self.nameCitiesArray.append(city)
            self.citiesArray.append(self.emptyCity)
            self.addCities()
        }
        
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

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { (_ , _ , complitionHandler) in
            let editingRow = self.nameCitiesArray[indexPath.row]
            if let index = self.nameCitiesArray.firstIndex(of: editingRow) {
                self.citiesArray.remove(at: index)
            }
            tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            
            let cityWeather = citiesArray[indexPath.row]
            let detailListVC = segue.destination as! DetailViewController
            detailListVC.weatherModel = cityWeather
            
        }
    }
}
