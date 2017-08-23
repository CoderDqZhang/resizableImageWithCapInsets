//
//  ViewController.swift
//  ImageCrop
//
//  Created by Zhang on 23/08/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit

let VIEWHEIGHT = UIScreen.main.bounds.size.height
let VIEWWIDTH = UIScreen.main.bounds.size.width

class Form: NSObject {
    var top:String = "0"
    var left:String = "0"
    var right:String = "0"
    var bottom:String = "0"
    override init() {
        super.init()
    }
}

class ViewController: UIViewController {

    var imageView:UIImageView!
    
    
    var top:UITextField!
    var left:UITextField!
    var right:UITextField!
    var bottom:UITextField!
    
    var image = UIImage.init(named: "Combined_mine")
    
    var button:UIButton!
    
    var button1:UIButton!
    
    var form = Form.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        imageView = UIImageView.init()
        imageView.frame = CGRect.init(x: 15, y: 100, width: (image?.size.width)! + 100, height: (image?.size.height)! + 100)
        imageView.backgroundColor = UIColor.red
//        imageView.image = image
//        imageView.contentMode = .scaleToFill
        self.view.addSubview(imageView)
        
        
        top = UITextField.init()
        top.tag = 1
        top.delegate = self
        top.placeholder = "top"
        top.frame = CGRect.init(x: 15, y: VIEWHEIGHT - 180, width: (VIEWWIDTH - 60)/2, height: 40)
        top.borderStyle = .roundedRect
        self.view.addSubview(top)
        
        left = UITextField.init()
        left.delegate = self
        left.tag = 2
        left.placeholder = "left"
        left.frame = CGRect.init(x: VIEWWIDTH/2 + 15, y: VIEWHEIGHT - 180, width: (VIEWWIDTH - 60)/2, height: 40)
        left.borderStyle = .roundedRect
        self.view.addSubview(left)
        
        right = UITextField.init()
        right.delegate = self
        right.tag = 3
        right.placeholder = "right"
        right.frame = CGRect.init(x: 15, y: VIEWHEIGHT - 120, width: (VIEWWIDTH - 60)/2, height: 40)
        right.borderStyle = .roundedRect
        self.view.addSubview(right)
        
        bottom = UITextField.init()
        bottom.delegate = self
        bottom.tag = 4
        bottom.placeholder = "bottom"
        bottom.frame = CGRect.init(x: VIEWWIDTH/2 + 15, y: VIEWHEIGHT - 120, width: (VIEWWIDTH - 60)/2, height: 40)
        bottom.borderStyle = .roundedRect
        self.view.addSubview(bottom)
        
        button = UIButton.init(type: .custom)
        button.setTitle("设置拉伸", for: .normal)
        button.frame = CGRect.init(x: 15, y: VIEWHEIGHT - 60, width: VIEWWIDTH - 30, height: 40)
        button.addTarget(self, action: #selector(ViewController.buttonPress(btn:)), for: .touchUpInside)
        button.backgroundColor = UIColor.brown
        self.view.addSubview(button)
        
        button1 = UIButton.init(type: .custom)
        button1.setTitle("改变图片大小", for: .normal)
        button1.frame = CGRect.init(x: 15, y: VIEWHEIGHT - 260, width: VIEWWIDTH - 30, height: 40)
        button1.addTarget(self, action: #selector(ViewController.buttonPress1(btn:)), for: .touchUpInside)
        button1.backgroundColor = UIColor.brown
        self.view.addSubview(button1)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //这里的点击方法后进行图片的拉伸操作
    func buttonPress(btn:UIButton){
        //UIEdgeInsets 设置要拉伸图片中某个位置的图片的内边距，根据宽高起始点确定图片中的一个矩形，已这个矩形为起始点向旁边扩展直到填充满图片控制器的大小
        let edg = UIEdgeInsets.init(top: self.coverStringToCGFloat(str: form.top), left: self.coverStringToCGFloat(str: form.left), bottom: self.coverStringToCGFloat(str: form.bottom), right: self.coverStringToCGFloat(str: form.right))
        //这里resizingModel有两个种方式，。stretch为拉伸模式，通过拉伸UIEdgeInsets指定的矩形区域来填充图片。
        //.tile：平铺模式，通过重复显示UIEdgeInsets指定的矩形区域来填充图片
        let newImage = image?.resizableImage(withCapInsets: edg, resizingMode: .stretch)
        imageView.image = newImage
        self.view.updateConstraintsIfNeeded()
    }
    
    func buttonPress1(btn:UIButton) {
        imageView.frame = CGRect.init(x: 15, y: 100, width: 100, height: 100)
    }
    
    
    func coverStringToCGFloat(str:String) -> CGFloat{
        guard let n = NumberFormatter().number(from: str) else {
            return 0
        }
        return CGFloat(n)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController : UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
        case 1:
            form.top = textField.text!
        case 2:
            form.left = textField.text!
        case 3:
            form.right = textField.text!
        default:
            form.bottom = textField.text!
        }
    }
    
    @available(iOS 10.0, *)
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        
    }
}

