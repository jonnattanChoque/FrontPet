//
//  TaskTableViewCell.swift
//  FrontPet
//
//  Created by jonnattan Choque on 1/11/21.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var subtitleLbl: UILabel!
    @IBOutlet weak var radioBtn: UIButton!{
        didSet{
            radioBtn.setImage(UIImage(named:"circle"), for: .normal)
            radioBtn.setImage(UIImage(named:"circle_selected"), for: .selected)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func display(object: Task) {
        titleLbl.text = object.title
        subtitleLbl.text = object.subtitle
        radioBtn.isSelected = false
    }
    
    @IBAction func btnPaytmAction(_ sender: UIButton) {
        sender.checkboxAnimation {
            if sender.isSelected{
                self.contentView.backgroundColor = UIColor.white
                self.contentView.tintColor = UIColor.white
            }
        }
    }
    
}
