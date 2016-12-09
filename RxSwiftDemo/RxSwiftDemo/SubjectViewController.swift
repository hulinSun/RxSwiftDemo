//
//  SubjectViewController.swift
//  RxSwiftDemo
//
//  Created by Hony on 2016/12/9.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa
import RxBlocking

/** 
可以把 Subject 当作一个桥梁（或者说是代理）， Subject 既是 Observable 也是 Observer 。
作为一个 Observer,它可以订阅序列。
同时作为一个 Observable ，它可以转发或者发射数据。
Subject 还有一个特别的功能，就是将冷序列变成热序列，订阅后重新发送嘛。
 
PublishSubject 只发射给观察者订阅后的数据。当有观察者订阅 PublishSubject 时，PublishSubject 会发射订阅之后的数据给这个观察者。于是这里存在丢失数据的问题，如果需要全部数据，我推荐改用ReplaySubject 。如果序列因为错误终止发射序列，此时 PublishSubject 就不会发射数据，只是传递这次错误事件
 
ReplaySubject : 不论观察者什么时候订阅， ReplaySubject 都会发射完整的数据给观察者。
 
BehaviorSubject : 当一个观察者订阅一个 BehaviorSubject ，它会发送原序列最近的那个值（如果原序列还有没发射值那就用一个默认值代替），之后继续发射原序列的值。
 
Variable： Variable 是 BehaviorSubject 的一个封装。相比 BehaviorSubject ，它不会因为错误终止也不会正常终止，是一个无限序列。
*/

class SubjectViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
//        publishSubject()
//        replaySubject()
//        behavior()
        variable()
    }
    
    
    func publishSubject() {
        // 先订阅 后发送数据 。那么订阅里的代码能收到数据， 但是如果先发送，后订阅，就会导致数据丢失问题
        let disposeBag = DisposeBag()
        let publishSubject = PublishSubject<String>()
        
        publishSubject.subscribe { (event) in
            print("subscribe1111 event = \(event)")
        }.addDisposableTo(disposeBag)
        
        publishSubject.onNext("呵呵--> 发送信号1")
        publishSubject.onNext("呵呵--> 发送信号2")
        
        publishSubject.subscribe { (event) in
            print("subscribe2222 event = \(event)")
            }.addDisposableTo(disposeBag)
        
        publishSubject.onNext("呵呵--> 发送信号3")
        publishSubject.onNext("呵呵--> 发送信号4")
        
    }
    
    /// 只要订阅了我的信号，不管你什么时候发送数据，都能收到
    func replaySubject() {
        
        let replaySbj = ReplaySubject<String>.create(bufferSize: 2)
        let bag = DisposeBag()
        
        replaySbj.subscribe { (e) in
            print("11111111   \(e)")
        }.addDisposableTo(bag)
        
        replaySbj.onNext("呵呵 A")
        replaySbj.onNext("呵呵 B")
        
        replaySbj.subscribe { (e) in
            print("2222222 \(e)")
        }.addDisposableTo(bag)

        replaySbj.onNext("呵呵 C")
        replaySbj.onNext("呵呵 D")
    }
    
    func behavior()  {
        
        let disposeBag = DisposeBag()
        
        let behaviorSubject = BehaviorSubject(value: "z")
        behaviorSubject.subscribe { e in
            print("Subscription: 1, event: \(e)")
            }.addDisposableTo(disposeBag)
        
        behaviorSubject.on(.next("a"))
        behaviorSubject.on(.next("b"))
        
        behaviorSubject.subscribe { e in /// 我们可以在这里看到，这个订阅收到了四个数据
            print("Subscription: 2, event: \(e)")
            }.addDisposableTo(disposeBag)
        
        behaviorSubject.on(.next("c"))
        behaviorSubject.on(.next("d"))
        behaviorSubject.on(.completed)
    }
    
    
//    最常用的 Subject 应该就是 Variable 。Variable 很适合做数据源，比如作为一个 UITableView 的数据源，我们可以在这里保留一个完整的 Array 数据，每一个订阅者都可以获得这个 Array 。
    
//    let elements = Variable<[String]>([])
    
    let elements = Variable<[String]>([])
    func variable()  {
        
        let bag = DisposeBag()
        let vab = Variable("fitst blood")
        vab.asObservable().subscribe { (e) in
            print("11111 \(e)")
        }.addDisposableTo(bag)
        
        vab.value = "Double Kill"
        vab.value = "Trible Kill"
        
        vab.asObservable().subscribe { (e) in
            print("22222 \(e)")
        }.addDisposableTo(bag)
        
        vab.value = "Pental Kill"
    }

}
