//
//  ViewController.swift
//  FrontPet
//
//  Created by jonnattan Choque on 27/10/21.
//

import UIKit
import MaterialComponents

class ViewController: UIViewController {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var createBtn: UIButton!
    @IBOutlet weak var formView: UIView!
    @IBOutlet weak var errorView: UIView!
    
    @IBOutlet weak var nameTF: MDCOutlinedTextField!
    @IBOutlet weak var raceTF: MDCOutlinedTextField!
    @IBOutlet weak var genderTF: MDCOutlinedTextField!
    @IBOutlet weak var stateTF: MDCOutlinedTextField!
    @IBOutlet weak var birthdayTF: MDCOutlinedTextField!
    
    @IBOutlet weak var radioBtn: UIButton!{
        didSet{
            radioBtn.setImage(UIImage(named:"circle"), for: .normal)
            radioBtn.setImage(UIImage(named:"circle_selected"), for: .selected)
        }
    }
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var errorLbl: UILabel!
    
    var textFieldArray = [MDCOutlinedTextField]()
    let pickerView = PickerViewHelper()
    
    var pickerInfo : [String] = []
    var selectedMenu : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addCloseKeyboardGesture()
        addObserver()
        sendBtn.circularStyleSecundary()
        backBtn.circularStyle()
        createBtn.circularStyle()
        setStyleTextFields()
        setupDelegateForPickerView()
        setupDelegatesForTextFields()
    }
    
    // MARK: Functions
    func addCloseKeyboardGesture(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func addObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func setStyleTextFields(){
        nameTF.setStyle(label: "Nombre", placeholder: "Nombre del perro")
        raceTF.setStyle(label: "Raza", placeholder: "Raza del perro")
        genderTF.setStyle(label: "Género", placeholder: "Género")
        stateTF.setStyle(label: "Estado", placeholder: "Estado")
        birthdayTF.setStyle(label: "Cumpleaños", placeholder: "dd/mm/yyyy")
    }
    
    func setupDelegatesForTextFields() {
        textFieldArray += [raceTF, genderTF, stateTF]
        
        for textfield in textFieldArray {
            textfield.delegate = self
            textfield.inputView = pickerView
            textfield.inputAccessoryView = pickerView.toolbar
        }
    }

    func setupDelegateForPickerView() {
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.toolbarDelegate = self
    }
    
    func showError(error: String){
        UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.errorLbl.text = error
            self.errorView.isHidden = false
        })
    }
    
    // MARK: Objective functions
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    // MARK: Event functions
    @IBAction func createPressed(_ sender: UIButton) {
        if self.formView.isHidden{
            UIView.transition(with: view, duration: 0.5, options: .transitionCurlDown, animations: {
                self.formView.isHidden = false
            })
        }
    }
    
    @IBAction func btnPaytmAction(_ sender: UIButton) {
        sender.checkboxAnimation {
            print(sender.isSelected)
        }
    }
    
    @IBAction func sendFormPressed(_ sender: UIButton) {
        if nameTF.text == ""{
            self.showError(error: "Debes agregar el nombre")
        }else if raceTF.text == ""{
            self.showError(error: "Debes seleccionar la raza")
        }else if genderTF.text == ""{
            self.showError(error: "Debes seleccionar el género")
        }else if birthdayTF.text == ""{
            self.showError(error: "Debes agregar el cumpleaños")
        }else{
            let validBirthday = ValidationHelpers.isValidDate(dateString: birthdayTF.text!)
            if !validBirthday{
                self.showError(error: "El campo cumpleaños debe ser una fecha válida")
            }
        }
    }
    
    @IBAction func closeViewErrorPressed(_ sender: UIButton) {
        UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.errorView.isHidden = true
        })
    }
}

extension ViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField.tag {
        case 0:
            self.pickerInfo = ["uno", "DOs"]
        case 1:
            self.pickerInfo = ["Macho", "Hembra"]
        case 2:
            self.pickerInfo = ["Castrado", "Esterilizado"]

        default:
            self.pickerInfo = ["N/A"]
        }
        self.pickerView.reloadAllComponents()
    }
}

extension ViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickerInfo.count
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.pickerInfo[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        for textArray in textFieldArray {
            if textArray.isFirstResponder {
                textArray.text = self.pickerInfo[row]
            }
        }
    }
}

extension ViewController: PickerViewHelperDelegate {

    func didTapDone() {
        self.view.endEditing(true)
    }

    func didTapCancel() {
       self.view.endEditing(true)
    }
}
