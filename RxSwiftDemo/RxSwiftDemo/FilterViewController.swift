//
//  FilterViewController.swift
//  RxSwiftDemo
//
//  Created by Hony on 2016/12/12.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxBlocking



/// 过滤序列
class FilterViewController: UIViewController {

    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
//        filter()
//        distinctUntilChanged()
//        take()
//        takeLast()
//        skip()
//        debounce()
//        elemAt()
//        single()
//        singleWithCondtion()
//        sample()
//        takeWhile()
//        skipWhile()
//        skipWhileWithIndex()
        skipUntil()
    }
    
    func filter() {
        // 过滤掉不适合的条件的元素
        Observable.of("123","22","44","76").filter { (str) -> Bool in
            return str.characters.count < 3
        }.subscribe(onNext: { (str) in
            print(str)
        }, onError: { err in
            print(err)
        }, onCompleted: {
            print("completed")
        }, onDisposed: {
            print("disposed")
        }).addDisposableTo(bag)
        
    }
    
    func distinctUntilChanged()  {
        // 阻止发射与上一个重复的值。
        Observable.of(1, 2, 3, 1, 1,1,1,1,1, 4)
            .distinctUntilChanged()
            .subscribe {
                print($0)
            }
            .addDisposableTo(bag)
    }
    
    func take()  {
        // 取前几个信号发送
        Observable.of(1, 2, 3, 1, 1,1,1,1,1, 4)
            .take(4)
            .subscribe {
                print($0)
            }
            .addDisposableTo(bag)
    }
    
    func takeLast()  {
        // 值发送后三个信号的值
        Observable.of(1, 2, 3, 1, 1,1,1,1,1, 4)
            .takeLast(3)
            .subscribe {
                print($0)
            }
            .addDisposableTo(bag)
    }
    
    func skip()  {
        // 跳过钱三个的信号
        Observable.of(1, 2, 3, 4, 5, 6)
            .skip(3)
            .subscribe {
                print($0)
            }
            .addDisposableTo(bag)
    }
    
    func skipWhile() {
        // 但是从前面开始跳过。跳过满足情况的信号。如果第一个就不满足，(不会有跳过)那么发送全部信号,反正都是从钱凯开始的
        Observable.of(1, 2, 3, 4, 5, 6)
            .skipWhile { $0 < 4 }
            .subscribe(onNext: { print($0) })
            .addDisposableTo(bag)
    }
    
    func debounce()  {
        // 仅在过了一段指定的时间还没发射数据时才发射一个数据，换句话说就是 debounce 会抑制发射过快的值。注意这一操作需要指定一个线程
        // debounce 和 throttle 是同一个东西。
        Observable.of(1, 2, 3, 4, 5, 6)
            .debounce(1, scheduler: MainScheduler.instance)
            .subscribe {
                print($0)
            }
            .addDisposableTo(bag)
    }
    
    func elemAt() {
        // 使用 elementAt 就只会发射一个值了，也就是指发射序列指定位置的值，比如 elementAt(2) 就是只发射第二个index的值。
        Observable.of(1, 2, 3, 4, 5, 6)
            .elementAt(2)
            .subscribe {
                print($0)
            }
            .addDisposableTo(bag)
    }
    
    
    func single()  {
        // single 就类似于 take(1) 操作，不同的是 single 可以抛出两种异常： RxError.MoreThanOneElement 和 RxError.NoElements 。当序列发射多于一个值时，就会抛出 RxError.MoreThanOneElement ；当序列没有值发射就结束时， single 会抛出 RxError.NoElements 。
        
        Observable.of(1, 2, 3, 4, 5, 6)
            .single()
            .subscribe {
                print($0)
            }
            .addDisposableTo(bag)
    }
    
    func singleWithCondtion()  {
        
        Observable.of("🐱", "🐰", "🐶", "🐸", "🐷", "🐵")
            .single { $0 == "🐸" }
            .subscribe { print($0) }
            .addDisposableTo(bag)
        
    }
    
    func takeWhile() {
        // 和filter 类似,但是从前面开始过滤。如果第一个不满足，那么久直接返回不在发送信号了。
        // 第一个改为 1 或者 7
        Observable.of(7, 2, 3, 4, 5, 6)
            .takeWhile { $0 < 4 }
            .subscribe(onNext: { print($0) })
            .addDisposableTo(bag)
    }
    
    func sample() {
        
        // 中我们使用 interval 创建了每 0.1s 递增的无限序列，同时用 take 只留下前 100 个值。抽样序列是一个每 1s 递增的无限序列。
        
        // 以上就是基本的过滤操作了，记得用它们去掉讨厌的数据。
        // sample 就是抽样操作，按照 sample 中传入的序列发射情况进行抽样。
        
        /**
        Observable<Int>.interval(0.1, scheduler: SerialDispatchQueueScheduler(globalConcurrentQueueQOS: .Background))
            .take(100)
            .sample(Observable<Int>.interval(1, scheduler: SerialDispatchQueueScheduler(globalConcurrentQueueQOS: .Background)))
            .subscribe {
                print($0)
            }
            .addDisposableTo(disposeBag) */

    }
    
    func skipWhileWithIndex()  {
        Observable.of("🐱", "🐰", "🐶", "🐸", "🐷", "🐵")
            .skipWhileWithIndex { element, index in
                index < 3
            }
            .subscribe(onNext: { print($0) })
            .addDisposableTo(bag)
    }
    
    func skipUntil()  {
        
        // 一直忽略掉 直到 referenceSequence 发送信号。
        let disposeBag = DisposeBag()
        
        let sourceSequence = PublishSubject<String>()
        let referenceSequence = PublishSubject<String>()
        
        sourceSequence
            .skipUntil(referenceSequence)
            .subscribe(onNext: { print($0) })
            .addDisposableTo(disposeBag)
        
        sourceSequence.onNext("🐱")
        sourceSequence.onNext("🐰")
        sourceSequence.onNext("🐶")
        
        referenceSequence.onNext("🔴")
        
        sourceSequence.onNext("🐸")
        sourceSequence.onNext("🐷")
        sourceSequence.onNext("🐵")
    }
}
