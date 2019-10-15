//
//  listaFilmesTableViewController.swift
//  BRQiOSChallenge
//
//  Created by Fellipe Ricciardi Chiarello on 30/09/19.
//  Copyright © 2019 Fellipe Ricciardi Chiarello. All rights reserved.
// API KEY 409292ea

import UIKit

class listaFilmesTableViewController: UITableViewController, UISearchBarDelegate {
    
    // MARK: - Atributos
    
    var urlAPI: String?
    var listaFilmes = [""]
    var dicionarioDeFilmes = [
        "Title": "",
        "Year": "",
        "imdbID": "",
        "Type": "",
        "Poster": ""
    ]
    
    // MARK: - Outlets
    @IBOutlet weak var searchFilmes: UISearchBar!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchFilmes.delegate = self
        tableView.reloadData()
        
        
    }
    
    //MARK: - Metodos
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let textoPesquisado = searchBar.text else { return }
        let formataTexto = textoPesquisado.replacingOccurrences(of: " ", with: "+")
        self.urlAPI = "http://www.omdbapi.com/?s=\(formataTexto)&type=movie&r=json&apikey=409292ea"
        
        guard let urlFormatada = urlAPI else { return }
        jsonRequest(url: urlFormatada)
        
        tableView.reloadData()
    }
    
    func jsonRequest (url: String) {
        guard let requestURL = URL(string: url) else { return }
        var listaDeFilmes: Array<Dictionary<String, Any>> = []
        var json:Dictionary<String, Any>
        
        listaDeFilmes.append(dicionarioDeFilmes as [String:Any])
        json = [
            "Search": listaDeFilmes
        ]
        
        var requisicao = URLRequest(url: requestURL)
//        print("Aqui: \(requisicao)")
        do{
            let data = try JSONSerialization.data(withJSONObject: json, options: [])
            requisicao.httpMethod = "GET"
            requisicao.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let task = URLSession.shared.dataTask(with: requisicao) { (data, response, error) in
                if error == nil {
                    do{
                        guard let dicionario = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] else {return}
                        print(dicionario)
                        guard let search = dicionario["Search"] as? [String: Any] else{ return }
                            if let title = search["Title"] as? String{
                                print("Esse é: \(title)")
                            }
                    }catch{
                        print(error.localizedDescription)
                    }
                }
            }
            task.resume()
            
        }catch{
            print(error.localizedDescription)
        }
    }
    
    
    // MARK: - TableView DataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return listaFilmes.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let filmes = listaFilmes [indexPath.row]
        
        let celula = tableView.dequeueReusableCell(withIdentifier: "celula", for: indexPath)
        celula.textLabel?.text = filmes
        
        return celula
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "segueDetalhes", sender: indexPath)
        
    }
}
