//
//  TaskViewController.swift
//  FrontPet
//
//  Created by jonnattan Choque on 1/11/21.
//

import UIKit

class TaskViewController: UIViewController {

    @IBOutlet weak var dogOne: UIImageView!
    @IBOutlet weak var dogTwo: UIImageView!
    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var taskView: UIView!
    @IBOutlet weak var tableInfo: UITableView!
    @IBOutlet weak var backBtn: UIButton!
    
    
    var taskInfo : [Task] = [Task]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        dogOne.isUserInteractionEnabled = true
        dogOne.addGestureRecognizer(tapGestureRecognizer)
        
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(imageTapped2(tapGestureRecognizer:)))
        dogTwo.isUserInteractionEnabled = true
        dogTwo.addGestureRecognizer(tapGestureRecognizer2)
        
        taskView.circularStyleView()
        backBtn.circularStyle()
        
        self.tableInfo.delegate = self
        self.tableInfo.dataSource = self
        self.tableInfo.register(UINib(nibName: "TaskTableViewCell", bundle: nil), forCellReuseIdentifier: "DequeueReusableCell")
        
        taskInfo = [
            Task(title: "Título 1", subtitle: "Perro 1: Correr"),
            Task(title: "Título 2", subtitle: "Perro 1: Bañar"),
            Task(title: "Título 3", subtitle: "Perro 1: Saltar"),
            Task(title: "Título 4", subtitle: "Perro 1: Dormir"),
        ]
        self.tableInfo.reloadData()
    }
    
    func addAnimation(tag: Int){
        var width = 0.0
        if tag == 0{
            width = 100.0
        }else{
            width = -100.0
        }
        
        let originalTransform = self.imageView.transform
        let scaledTransform = originalTransform.scaledBy(x: 1, y: 1)
        let scaledAndTranslatedTransform = scaledTransform.translatedBy(x: width, y: 0.0)
        UIView.animate(withDuration: 0.7, animations: {
            self.imageView.transform = scaledAndTranslatedTransform
            self.showInfo(infoTag: tag)
        })
    }
    
    func showInfo(infoTag: Int){
        if(infoTag == 0){
            taskInfo = [
                Task(title: "Título 1", subtitle: "Perro 1: Correr"),
                Task(title: "Título 2", subtitle: "Perro 1: Bañar"),
                Task(title: "Título 3", subtitle: "Perro 1: Saltar"),
                Task(title: "Título 4", subtitle: "Perro 1: Dormir"),
            ]
        }else{
            taskInfo = [
                Task(title: "Título 5", subtitle: "Perro 2: Correr"),
                Task(title: "Título 6", subtitle: "Perro 2: Bañar"),
                Task(title: "Título 7", subtitle: "Perro 2: Saltar"),
                Task(title: "Título 8", subtitle: "Perro 2: Dormir"),
            ]
        }
        
        self.tableInfo.reloadData()
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        self.dogOne.isUserInteractionEnabled = false
        self.dogTwo.isUserInteractionEnabled = true
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        self.addAnimation(tag: tappedImage.tag)
    }
    
    @objc func imageTapped2(tapGestureRecognizer: UITapGestureRecognizer){
        self.dogOne.isUserInteractionEnabled = true
        self.dogTwo.isUserInteractionEnabled = false
        
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        self.addAnimation(tag: tappedImage.tag)
    }
    
    
    @IBAction func backPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}


extension TaskViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DequeueReusableCell") as? TaskTableViewCell
        let data = taskInfo
        let object = data[indexPath.row]
        cell?.display(object: object)
        if let aCell = cell {
            return aCell
        }
        return UITableViewCell()
    }
}
