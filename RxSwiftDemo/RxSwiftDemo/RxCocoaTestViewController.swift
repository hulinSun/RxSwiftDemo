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
import RxDataSources

class RxCocoaTestViewController: UIViewController {

    
    @IBOutlet weak var resLabel: UILabel!
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var field: UITextField!
    
    @IBOutlet weak var `switch`: UISwitch!
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var button: UIButton!
    
    
    var personDatas: [Person] = [
                                Person(name: "Jack0", age: 22),
                                Person(name: "Jack1", age: 23),
                                Person(name: "Jack2", age: 24),
                                Person(name: "Jack3", age: 25),
                                Person(name: "Jack4", age: 26),
                                Person(name: "Jack5", age: 27),
                                Person(name: "Jack6", age: 28),
                                Person(name: "Jack7", age: 29),
                                Person(name: "Jack8", age: 30),
                                Person(name: "Jack9", age: 31)
                                    ]
    
    var easyDatas = Variable([Person]())
    
    fileprivate lazy var tableView: UITableView = {
        let i = UITableView(frame: .zero, style: .grouped)
        return i
    }()
    
    let bag = DisposeBag()
    
    var person: Person!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        buttonTap()
//        guesture()
//        rxtext()
//        control()
        easyTable()
//        advanceTable()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
//        KVO()
//        rxdelloc()
//        session()
//        rxNotification()
//        bind()
    }
    
    
    func control() {
        
//        self.slider.rx.controlEvent(.valueChanged).subscribe(onNext: { (e) in
//            print("点击滑竿，值改变")
//        }).addDisposableTo(bag)
        
            slider.rx.controlEvent(.valueChanged)
            .map{
                return "滑竿 \(self.slider.value)"
            }.bindTo(resLabel.rx.text)
            .addDisposableTo(bag)
        
        
        self.slider.rx.controlEvent(.valueChanged)
            .map{ [unowned self] in
                return self.slider.value >= 0.5 ? true : false
            }.bindTo(self.switch.rx.value)
            .addDisposableTo(bag)
        
        textView.rx.contentOffset.subscribe { (e) in
            print(e.element?.y ?? 1)
        }.addDisposableTo(bag)
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
    
    func easyTable()  {
        
        view.subviews.forEach{$0.removeFromSuperview()}
        view.addSubview(tableView)
        tableView.delegate = nil
        tableView.dataSource = nil
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "uitableviewcell")
        easyDatas.value.append(contentsOf: personDatas)
        tableView.frame = view.bounds
        view.addSubview(tableView)
        
        easyDatas.asObservable()
            .bindTo(tableView.rx.items(cellIdentifier: "uitableviewcell", cellType: UITableViewCell.self)){ row , person , cell in
                cell.textLabel?.text = person.name
                cell.detailTextLabel?.text = String(person.age)
                cell.accessoryType =  (row % 2 == 0) ? .checkmark : .detailButton
        }.addDisposableTo(bag)
        
        tableView.rx.itemSelected
            .subscribe{ e in
                print(e)
        }.addDisposableTo(bag)
        
        tableView.rx.modelSelected(Person.self).subscribe { (p) in
            print(p.element?.name ?? "haha ")
        }.addDisposableTo(bag)
        
        tableView.rx.itemAccessoryButtonTapped.subscribe { (e) in
            print("点击了详细按钮")
        }.addDisposableTo(bag)
        
        
    }
    
    
    
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Double>>()
    
    func advanceTable()  {
        
        let dataSource = self.dataSource
        
        view.subviews.forEach{$0.removeFromSuperview()}
        view.addSubview(tableView)
        tableView.frame = self.view.bounds
        tableView.delegate = nil
        tableView.dataSource = nil
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "uitableviewcell")
        
        let items = Observable.just([
            SectionModel(model: "First section", items: [
                1.0,
                2.0,
                3.0
                ]),
            SectionModel(model: "Second section", items: [
                1.0,
                2.0,
                3.0
                ]),
            SectionModel(model: "Third section", items: [
                1.0,
                2.0,
                3.0
                ])
            ])
        
        dataSource.configureCell = { (_, tv, indexPath, element) in
            let cell = tv.dequeueReusableCell(withIdentifier: "uitableviewcell")!
            cell.textLabel?.text = "\(element) @ row \(indexPath.row)"
            return cell
        }
        
        items
            .bindTo(tableView.rx.items(dataSource: dataSource))
            .addDisposableTo(bag)
        
        tableView.rx
            .itemSelected
            .map { indexPath in
                return (indexPath, dataSource[indexPath])
            }
            .subscribe(onNext: { indexPath, model in
                print("点击了\(indexPath.section) 组 第\(indexPath.row)行")
            })
            .addDisposableTo(bag)
        
        tableView.rx
            .setDelegate(self)
            .addDisposableTo(bag)

    }
    
    
    deinit {
        print("控制器释放了")
    }
}

extension RxCocoaTestViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel(frame: CGRect.zero)
        label.text = dataSource[section].model
        label.backgroundColor = .red
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
}
