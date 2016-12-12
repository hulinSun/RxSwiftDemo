//
//  CombineViewController.swift
//  RxSwiftDemo
//
//  Created by Hony on 2016/12/12.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa
import RxBlocking


/// 序列合并的操作
class CombineViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

         view.backgroundColor = .white
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
//        startWith()
//        combineLatest()
//        zip()
//        merge()
        switchLatest()
    }
    
    
    func startWith() {
        // 在最前面插入值，以。。为开头
        // 可以看到输出是 2 3 4 5 6 7 8 9 ，在 4 前面插入了一个 3 ，然后又在 3 前面插入了一个 2 。有什么用呢，当然有用啦。我们可以用这样的方式添加一些默认的数据。当然也可能我们会在末尾添加一些默认数据，这个时候需要使用 concat
        _ = Observable.of(4, 5, 6, 7, 8, 9)
            .startWith(3)
            .startWith(2)
            .subscribe {
                print($0)
        }
    }
    
    func concat() {
        // 在后面添加一些数据
        let disposeBag = DisposeBag()
        let subject1 = BehaviorSubject(value: "🍎")
        let subject2 = BehaviorSubject(value: "🐶")
        let variable = Variable(subject1)
        
        variable.asObservable()
            .concat()
            .subscribe { print($0) }
            .addDisposableTo(disposeBag)
        
        subject1.onNext("🍐")
        subject1.onNext("🍊")
        
        variable.value = subject2
        
        subject2.onNext("I would be ignored")
        subject2.onNext("🐱")
        
        subject1.onCompleted()
        subject2.onNext("🐭")
    }
    
    
    func combineLatest()  {
        
        // 当两个序列中的任何一个发射了数据时，combineLatest 会结合并整理每个序列发射的最近数据项。
        let intOb1 = PublishSubject<String>()
        let intOb2 = PublishSubject<Int>()
        
        _ = Observable.combineLatest(intOb1, intOb2) {
            "(\($0) --- \($1))"
            }
            .subscribe {
                print($0)
        }
        
        intOb1.onNext("A")
        intOb2.onNext(1)
        intOb1.onNext("B")
        intOb2.onNext(2)
        
//        输出是 (A 1) (B 1) (B 2) 。可以看到每当有一个序列发射值得时候， combineLatest 都会结合一次发射一个值。需要注意的有两点：
        
//        我们都要去传入 resultSelector 这个参数，一般我们做尾随闭包，这个是对两（多）个序列值的处理方式，上面的例子就是将序列一和二的值变成字符串，中间加个空格，外面再包一个() .
//        Rx 在 combineLatest 上的实现，只能结合 8 个序列。再多的话就要自己去拼接了。

    }
    
    func zip()  {
        // zip 和 combineLatest 相似，不同的是每当所有序列都发射一个值时， zip 才会发送一个值。它会等待每一个序列发射值，发射次数由最短序列决定。结合的值都是一一对应的。
        /*
        let intOb1 = PublishSubject<String>()
        let intOb2 = PublishSubject<Int>()
        
        _ = Observable.zip(intOb1, intOb2) {
            "(\($0) \($1))"
            }
            .subscribe {
                print($0)
        }
        
        // 这里的 zip 会配对的进行合并，也就是说 intOb1 虽然发射了 "C" ，但是 zip 仍然是结合 "B" 2 。
        intOb1.on(.next("A"))
        intOb2.on(.next(1))
        intOb1.on(.next("B"))
        intOb1.on(.next("C"))
        intOb2.on(.next(2)) */
        
        let intOb1 = Observable.of(0, 1)
        let intOb2 = Observable.of(0, 1, 2, 3)
        let intOb3 = Observable.of(0, 1, 2, 3, 4)
        
        _ = Observable.zip(intOb1, intOb2, intOb3) {
            ($0 + $1) * $2
            }
            .subscribe {
                print($0)
        }
    }
    
    func merge()  {
        // merge 会将多个序列合并成一个序列，序列发射的值按先后顺序合并。要注意的是 merge 操作的是序列，也就是说序列发射序列才可以使用 merge 。
        // 不论哪个序列发射值。都会在订阅里相应。只不过还是各玩各的
        let subject1 = PublishSubject<Int>()
        let subject2 = PublishSubject<Int>()
        
        _ = Observable.of(subject1, subject2)
            .merge()
            .subscribe {
                print($0)
        }
        
        subject1.on(.next(20))
        subject1.on(.next(40))
        subject1.on(.next(60))
        subject2.on(.next(1))
        subject1.on(.next(80))
        subject1.on(.next(100))
        subject2.on(.next(1))
    }
    
    // Singal of Singals
    func switchLatest()  {
        
        //switchLatest 和 merge 有一点相似，都是用来合并序列的。然而这个合并并非真的是合并序列。事实是每当发射一个新的序列时，丢弃上一个发射的序列。
        
        let var1 = Variable(0)
        let var2 = Variable(200)
        // var3 是一个 Observable<Observable<Int>>
        let var3 = Variable(var1.asObservable())
        
        _ = var3
            .asObservable()
            .switchLatest()
            .subscribe {
                print($0)
        }
        
        var1.value = 1
        var1.value = 2
        var1.value = 3
        var1.value = 4
        
        var3.value = var2.asObservable() // 我们在这里新发射了一个序列
        var2.value = 201
        var1.value = 5 // var1 发射的值都会被忽略
        var1.value = 6
        var1.value = 7
    }
}
