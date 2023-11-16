//
//  ListViewController.swift
//  Chapter05-CustomPlist
//
//  Created by JuSun Kang on 11/16/23.
//

import UIKit

class ListViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    

    @IBOutlet weak var account: UITextField!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var gender: UISegmentedControl!
    @IBOutlet weak var married: UISwitch!
    
//    var accountlist = [String]()
    var accountlist = ["test@naver.com"]
    
    /*
    @IBAction func edit(_ sender: UITapGestureRecognizer) {
        let alert = UIAlertController(title: nil, message: "이름을 입력하세요", preferredStyle: .alert)
        
        alert.addTextField() {
            $0.text = self.name.text
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default) { (_) in
            let value = alert.textFields?[0].text
            
            let plist = UserDefaults.standard
            plist.setValue(value, forKey: "name")
            plist.synchronize()
            
            self.name.text = value
        })
        
        self.present(alert, animated: false)
    }
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let plist = UserDefaults.standard

        self.name.text = plist.string(forKey: "name")
        self.married.isOn = plist.bool(forKey: "married")
        self.gender.selectedSegmentIndex = plist.integer(forKey: "gender")

        let picker = UIPickerView()
        
        picker.delegate = self
        self.account.inputView = picker
        
        let toolbar = UIToolbar()
        toolbar.frame = CGRect(x: 0, y: 0, width: 0, height: 35)
        toolbar.barTintColor = .lightGray
        
        self.account.inputAccessoryView = toolbar
        
        let done = UIBarButtonItem()
        done.title = "Done"
        done.target = self
        done.action = #selector(pickerDone)
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let new = UIBarButtonItem()
        new.title = "New"
        new.target = self
        new.action = #selector(newAccount)
        
        toolbar.setItems([new, flexSpace, done], animated: true)
    }
    
    @IBAction func changeGender(_ sender: UISegmentedControl) {
        let value = sender.selectedSegmentIndex
        
        let plist = UserDefaults.standard
        plist.set(value, forKey: "gender")
        plist.synchronize()
    }
    
    @IBAction func changeMarried(_ sender: UISwitch) {
        let value = sender.isOn
        
        let plist = UserDefaults.standard
        plist.set(value, forKey: "married")
        plist.synchronize()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return super.numberOfSections(in: tableView)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return super.tableView(tableView, numberOfRowsInSection: section)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            let alert = UIAlertController(title: nil, message: "이름을 입력하세요", preferredStyle: .alert)
            
            alert.addTextField() {
                $0.text = self.name.text
            }
            
            alert.addAction(UIAlertAction(title: "OK", style: .default) { (_) in
                let value = alert.textFields?[0].text
                
                let plist = UserDefaults.standard
                plist.setValue(value, forKey: "name")
                plist.synchronize()
                
                self.name.text = value
            })
            
            self.present(alert, animated: false)
        }
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - UIPickerViewDelegate, UIPickerViewDataSource
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.accountlist.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.accountlist[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let account = self.accountlist[row]
        self.account.text = account
        
//        self.view.endEditing(true)
    }
    
    @objc func pickerDone(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    @objc func newAccount(_ sender: Any) {
        self.view.endEditing(true)
        
        let alert = UIAlertController(title: "새 계정을 입력하세요", message: nil, preferredStyle: .alert)
        
        alert.addTextField() {
            $0.placeholder = "ex) abc@gmail.com"
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            if let account = alert.textFields?[0].text {
                self.accountlist.append(account)
                self.account.text = account
                self.name.text = ""
                self.gender.selectedSegmentIndex = 0
                self.married.isOn = false
            }
        }))
        
        self.present(alert, animated: false)
    }

}
