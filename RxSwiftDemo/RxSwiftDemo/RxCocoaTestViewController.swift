//
//  RxCocoaTestViewController.swift
//  RxSwiftDemo
//
//  Created by Hony on 2016/12/14.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxBlocking

class RxCocoaTestViewController: UIViewController {

    @IBOutlet weak var resLabel: UILabel!
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var field: UITextField!
    
    @IBOutlet weak var `switch`: UISwitch!
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var button: UIButton!
    
    let bag = DisposeBag()
    
    var person: Person!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        buttonTap()
//        guesture()
        rxtext()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
//        KVO()
//        rxdelloc()
//        session()
//        rxNotification()
//        bind()
    }
    
    
    func rxNotification() {
        // 这个只是监听通知的写法，发出通知还是一般写法
        let i = Notification.Name.UIApplicationDidEnterBackground
        NotificationCenter.default.rx.notification(i, object: "xixi" as AnyObject?).subscribe { (e) in
            print(e)
        }.addDisposableTo(bag)
    }
    
    func session()  {
        
        let url = URL(string: "http://www.zhid58.com:8080/api/v2/topic/list/hotshot")!
        let request = URLRequest(url: url)
        
//        URLSession.shared.rx.json(url: url)
//            .subscribe { (e) in
//                print("请求的结果 \(e)")
//            }.addDisposableTo(bag)
        
        URLSession.shared.rx.json(request: request)
            .subscribe { (e) in
                print(e)
        }.addDisposableTo(bag)
        
        URLSession.shared.rx.data(request: request)
            .subscribe { (e) in
                print(e)
        }.addDisposableTo(bag)
    }
    
    func buttonTap()  {
        
        // 注意。这里一定是 onNext 
        button.rx.tap
            .subscribe(onNext: { [unowned self] x in
                self.resLabel.text = "点击了按钮"
            })
            .addDisposableTo(bag)
        
//        button.rx.controlEvent(.touchUpInside)
//            .subscribe(onNext: { [unowned self] x in
//                self.resLabel.text = "点击了按钮"
//            })
//            .addDisposableTo(bag)
    }
    
    func rxdelloc()  {
        Person().rx.deallocated.subscribe { (e) in
            print("person 释放了")
        }.addDisposableTo(bag)
    }
    
    func guesture() {
//        let tap = UITapGestureRecognizer()
//        tap.rx.event.subscribe { (e) in
//            print("点击了控制器的view")
//            }.addDisposableTo(bag)
//        view.addGestureRecognizer(tap)
        
        let pan = UIPanGestureRecognizer()
        pan.rx.event.subscribe { [unowned self](e) in
            
            // element 是传过来的对象
            guard let g = e.element else{return}
            self.resLabel.text = "pan---"
            print(g.location(in: g.view))
            
        }.addDisposableTo(bag)
        view.addGestureRecognizer(pan)
    }
    
    func KVO() {
        person = Person()
        person.name = "HONY1"
        person.name = "HONY2"
        person.rx.observe(String.self, #keyPath(Person.name)).subscribe { (e) in
            print(e)
        }.addDisposableTo(bag)
        person.name = "可惜你早已远去"
        // 订阅前最后改变的值
    }
    
    func bind()  {
        _ = Observable.of("控制器释放了控制器释放了控制器释放了")
            .map{$0 + "xixixixixi"}
            .bindTo(textView.rx.text)
        
    }
    
    func rxtext() {
        
        // orEmpty  过滤掉可选
        field.rx.text.orEmpty
            .subscribe { (e) in
                print(e)
            }.addDisposableTo(bag)
        
        textView.rx.text.orEmpty
            .subscribe { (e) in
                print(e)
            }.addDisposableTo(bag)
        
        textView.rx.didBeginEditing.subscribe { (e) in
            print("开始编辑")
        }.addDisposableTo(bag)
        textView.rx.didEndEditing.subscribe { (e) in
            print("结束编辑")
        }.addDisposableTo(bag)
    }
    
    deinit {
        print("控制器释放了")
    }
    
    
}
