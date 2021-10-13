//
//  ViewController.swift
//  COVID-19_vaccine
//
//  Created by 준수김 on 2021/10/13.
//

import UIKit

class ViewController: UIViewController, XMLParserDelegate {
    
    var xmlParser = XMLParser()
    
    var currentElement = ""
    var items = [[String : String]]()
    var item = [String : String]()
    var vaccineSidoNm = ""
    var vaccineFirstTot = ""
    var vaccineSecondTot = ""
    var vaccineThirdTot = ""
    
    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        requestVaccineSidoInfo()
    }
    
    func requestVaccineSidoInfo() {
        let url = "https://nip.kdca.go.kr/irgd/cov19stats.do?list=sido"
        guard let xmlParser = XMLParser(contentsOf: URL(string: url)!) else { return }
        xmlParser.delegate = self
        xmlParser.parse()
    }
    public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?,attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        if elementName == "item" {
            item = [String : String]()
            vaccineSidoNm = ""
            vaccineFirstTot = ""
            vaccineSecondTot = ""
            vaccineThirdTot = ""
            //print("didStartElement")
        }
    }
        
    public func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            item["sidoNm"] = vaccineSidoNm
            item["firstTot"] = vaccineFirstTot
            item["secondTot"] = vaccineSecondTot
            item["thirdTot"] = vaccineThirdTot
            items.append(item)

            //print("didEndElement")
        }
        
    }
    
    public func parser(_ parser: XMLParser, foundCharacters string: String) {
        //print("foundCharacters")
        
        if currentElement == "sidoNm" {
            vaccineSidoNm = string
            //print("시도명: \(vaccineSidoNm)")
            print(vaccineSidoNm)
            //print("foundCharacters1")
        } else if (currentElement == "firstTot") {
            vaccineFirstTot = string
            //print("1차 백신 접종자 수:\(vaccineFirstTot)")
            //print("foundCharacters2")
            print(vaccineFirstTot)
            label.text = vaccineFirstTot
            label.sizeToFit()
        } else if (currentElement == "secondTot") {
            vaccineSecondTot = string
           // print("2차 백신 접종자 수:\(vaccineSecondTot)")
            //print("foundCharacters2")
            print(vaccineSecondTot)
        } else if (currentElement == "thirdTot") {
            vaccineThirdTot = string
            //print("3차 백신 접종자 수:\(vaccineThirdTot)")
            print(vaccineThirdTot)
            //print("-----------------------")
            //print("foundCharacters2")
        }
    }
}
    




