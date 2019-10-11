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
    var listaFilmes: [String] = [""]
    var urlAPI: String?
    
    // MARK: - Outlets
    @IBOutlet weak var searchFilmes: UISearchBar!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchFilmes.delegate = self
        
        
    }
    
    //MARK: - Metodos
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
                guard let textoPesquisado = searchBar.text else { return }
        let formataTexto = textoPesquisado.replacingOccurrences(of: " ", with: "+")
        self.urlAPI = "http://www.omdbapi.com/?s=\(formataTexto)&type=movie&r=json&apikey=409292ea"
        
        guard let urlFormatada = urlAPI else { return }
        jsonRequest(url: urlFormatada)
    }
    
    func jsonRequest (url: String) {
        
        guard let requestURL = URL(string: url) else { return }
        var request = URLRequest(url: requestURL)
        let task = URLSession.shared.dataTask(with: request) { (data, requisicao, error) in
            if error == nil {
                if let dadosRetorno = data {
                    do {
                        if let objetoJson = try JSONSerialization.jsonObject(with: dadosRetorno, options: []) as? [String: Any] {
                            request.httpBody = data
                            request.httpMethod = "POST"
                            if let search = objetoJson["Search"] as? [String: Any] {
                                let title = search["Title"]
                                DispatchQueue.main.async {
                                    print(title)
                                }
                            }
                        }
                    } catch {
                        print(error .localizedDescription)
                    }
                }else {print("Erro 1!")}
            }
        }
        task.resume()
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
