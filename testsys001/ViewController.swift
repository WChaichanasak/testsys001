//
//  ViewController.swift
//  testsys001
//
//  Created by Woramaet Chaichanasak on 2022/02/14.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textFund: UITextField!
    @IBOutlet weak var textTime: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buttonSent: UIButton!
    
    var Alldata:[ModelData] = []
    var timeGap:[String] = ["Select Time","1D", "1W", "1M", "1Y"]
    var names:[String] = ["Select Fund"]
    var selectData:[ModelData] = []
    var ra:String = ""
    
    var picker1 = UIPickerView()
    var picker2 = UIPickerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker1.delegate = self
        picker1.dataSource = self
        picker1.tag = 101
        
        picker2.delegate = self
        picker2.dataSource = self
        picker2.tag = 102
        
        textFund.inputView = picker1
        textTime.inputView = picker2
        
        APIGetData().request(){
            (status,message,command,result) in
            if status == true{
                self.Alldata = result
                self.getDatas()
            }
            
            
        }
        
        setuptableView()
        
        buttonSent.isEnabled = false
    }
    
    private func setuptableView(){
        self.tableView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        
        self.tableView.rowHeight = UITableView.automaticDimension
                      
        self.tableView.estimatedRowHeight = 44.0
        
        self.tableView.separatorStyle = .none
        
        self.tableView.separatorInset = UIEdgeInsets.zero
                      
        self.tableView.register(UINib(nibName: "dataTableViewCell", bundle: nil), forCellReuseIdentifier: "dataTableViewCell")
        
        self.tableView.contentSize = CGSize(width: self.tableView.frame.width, height: self.tableView.contentSize.height)
                      
        self.tableView.reloadData()
    }
    
    private func checkData(){
        if textTime.text == "" || textFund.text == ""{
            buttonSent.isEnabled = false
        }
        if textFund.text == "Select Fund" || textTime.text == "Select Time"{
            buttonSent.isEnabled = false
        }
        else{
            buttonSent.isEnabled = true
        }
        
    }
    
    private func getDatas(){
    
        for datas in Alldata{
            names.append(datas.thcode)
        }
        self.picker1.reloadInputViews()
    }
    
    
    @IBAction func sentClicked(_ sender: UIButton) {
        if textTime.text != "1Y"{
            showAlert(view: self, msg: "This time not found try again")
        }
        
        else{
            selectData = Alldata.filter({$0.thcode == textFund.text})
            
            if let i = Alldata.firstIndex(where: { $0.thcode == textFund.text }) {
                self.ra = String(i + 1)
                print( Alldata[i])
            }
            

            self.tableView.reloadData()
        }
    }
    

}


extension ViewController:UIPickerViewDelegate,UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView.tag == 101{
            return names.count
        }
        else if pickerView.tag == 102{
            return timeGap.count
        }
        else{
            return 0
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 101{
            return names[row]
        }
        else if pickerView.tag == 102{
            return timeGap[row]
        }
        else{
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 101{
            textFund.text = names[row]
        }
        else if pickerView.tag == 102{
            textTime.text = timeGap[row]
        }
        
        checkData()
    }
}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:dataTableViewCell = tableView.dequeueReusableCell(withIdentifier: "dataTableViewCell", for: indexPath) as! dataTableViewCell
        
        let d = selectData[indexPath.row]
        
        let dateformater = DateFormatter()
        dateformater.locale = Locale(identifier: "en_US_POSIX")
        dateformater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let dates = dateformater.date(from: d.dateNav)
        dateformater.dateFormat = "dd MMM yyyy"
        let result = dateformater.string(from: dates!)
       
        cell.selectionStyle = .none
        
        
        cell.labelFund.text = d.thcode
        cell.labelRank.text = ra
        cell.labelUpdate.text = result
        cell.labelPerformance.text = "\(d.navRe)"
        cell.labelPrice.text = "\(d.nav)"
        
        return cell
    }
    
    
}
