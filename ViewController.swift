//
//  ViewController.swift
//  coronaAPP
//
//  Created by Aa Rr on 2021/02/21.
//

import UIKit

struct Corona: Decodable{
    let itemList: [itemList]
}
struct itemList: Decodable{
    let date: String
    let nameJp: String
    let npatients: String
    
    enum CodingKeys: String, CodingKey{
        case date = "date"
        case nameJp = "name_jp"
        case npatients = "npatients"
    }
}

class ViewController: UIViewController, UIPickerViewDelegate {
    @IBOutlet weak var placetext: UITextField!
    @IBOutlet weak var monthtext: UITextField!
    @IBOutlet weak var yeartext: UITextField!
    
    var datedata1 = ""
    var urldata = "https://opendata.corona.go.jp/api/Covid19JapanAll?date="
    var coronaData1: [itemList] = []
    var coronaInfo1: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        yeartext.placeholder = "YYYY"
        monthtext.placeholder = "MM"
        placetext.placeholder = "DD"
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "tosecond" {
                let secondView = segue.destination as! secondViewController
                    secondView.coronaInfo2 = coronaInfo1
            }
        }
    
    @IBAction func infoButton(_ sender: Any) {
        datedata1 = yeartext.text! + monthtext.text! + placetext.text!
        urldata = urldata + datedata1
        getcoronaApi()
        urldata = "https://opendata.corona.go.jp/api/Covid19JapanAll?date="
    }
    func getcoronaApi() {
            guard let url = URL(string: urldata) else { return }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            let task = URLSession.shared.dataTask(with: url) { [self] (data , response , err) in
                if let err = err {
                    print("情報の取得に失敗しました。:",err)
                    return
                }
                if let data = data {
                    do {
                        //let json = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                      let corona = try JSONDecoder().decode(Corona.self, from: data)
                        if coronaData1.count == 0 {
                            self.coronaData1 = corona.itemList
                            for a in 0...46 {
                                coronaInfo1.append(coronaData1[a].nameJp + " : " + coronaData1[a].npatients + " 人 ")
                            }
                        } else {
                            coronaData1 = []
                            coronaInfo1 = []
                            self.coronaData1 = corona.itemList
                            for a in 0...46 {
                                coronaInfo1.append(coronaData1[a].nameJp + " : " + coronaData1[a].npatients + " 人 ")
                            }
                        }
                    }catch(let err) {
                        print("情報の取得に失敗しました！！！。:",err)
                    }
                }
                
            }
            task.resume()
        }
        
}

