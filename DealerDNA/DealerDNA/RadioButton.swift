

import UIKit

class RadioButton: UIButton {
    
    fileprivate let check = UIImage(named: "R_C")!.withRenderingMode(.alwaysTemplate)
    fileprivate let uncheck = UIImage(named: "R_U_C")!.withRenderingMode(.alwaysTemplate)
    
    fileprivate var isChe:Bool = false{
        didSet{
            if isChe == true{
                self.setImage(check, for: UIControlState())
            }else{
                self.setImage(uncheck, for: UIControlState())
            }
        }
    }
    
    fileprivate var grp_name = ""
    override func awakeFromNib() {
        self.addTarget(self, action: #selector(RadioButton.btnclick(_:)), for: UIControlEvents.touchUpInside)
        isChe = false
    }
    
    func did_Selected(){
        self.isChe = true
    }
    func did_UnSelected(){
        self.isChe = false
    }
    func is_Selected() -> Bool {
        return self.isChe
    }
    func did_SetGroup(_ Group_Name:String){
        self.grp_name = Group_Name
    }
    func is_inGroup() -> Bool {
        if self.grp_name == ""{
            return false
        }
        return true
    }
    func did_RemoveGroup(){
        self.grp_name = ""
    }
    @objc fileprivate func btnclick(_ sender:UIButton){
        if sender == self{
            if isChe == true{
                isChe = false
            }else{
                for rad in (self.superview?.subviews)!{
                    if let tmp = rad as? RadioButton{
                        if tmp.grp_name == self.grp_name{
                            tmp.isChe = false
                        }
                    }
                }
                isChe = true
            }
        }
    }
}
