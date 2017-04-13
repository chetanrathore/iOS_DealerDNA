//
//  AddInventoryVC.swift
//  DealerDNA
//
//  Created by LaNet on 3/23/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import UIKit

class AddInventoryVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, CustomNevigationDeletegate {
    
    @IBOutlet var txtYear: TextField!
    @IBOutlet var txtDate: UITextField!
    var pickerView : UIPickerView!
    var datePicker: UIDatePicker!
    let customNav = CustomNavigationBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        setLayout()
    }
    
    func setLayout(){
        pickerView = UIPickerView()
        pickerView.showsSelectionIndicator = true
        pickerView.delegate = self
        pickerView.dataSource = self
        txtYear.inputView = pickerView
        
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        txtDate.inputView = datePicker
        customNav.delegate = self
        customNav.createView(self.view, title: "Add Inventory", backBtn: .back, isRightRequired: false, rightBtnTitle: nil, rightButtonImage: nil)
        self.automaticallyAdjustsScrollViewInsets = false
        
    }
    
    func btnLeftClick() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: pickerview
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 5
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "Test"
    }
    
    @IBAction func handleBtnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
