
//  EasyViewController.swift
//  RxSwiftDemo
//
//  Created by Hony on 2016/12/9.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxBlocking


/// Observable 简单的 创建 与 订阅
class EasyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    /**
    asObservable 返回一个序列
    create 使用 Swift 闭包的方式创建序列
    deferred 只有在有观察者订阅时，才去创建序列
    empty 创建一个空的序列，只发射一个 .Completed
    error 创建一个发射 error 终止的序列
     FROM
    toObservable 使用 SequenceType 创建序列
    interval 创建一个每隔一段时间就发射的递增序列
    never 不创建序列，也不发送通知
    just 只创建包含一个元素的序列。换言之，只发送一个值和 .Completed
    of 通过一组元素创建一个序列
    range 创建一个有范围的递增序列
    repeatElement 创建一个发射重复值的序列
    timer 创建一个带延迟的序列 */
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
//        creat()
//        otherEasy()
//        never()
//        generate()
//        deferred()
//        interval()
//        timer()
        doon()
    }
    
    
    /// Never 创建的序列。即便有订阅，也不会执行
    func never() {
        
        // MARK: 为什么addDisposableTo 不跟在最后？
        /*
        _ = Observable<String>.never().subscribe { (event) in
            print("这里不会执行")
        }.addDisposableTo(DisposeBag()) */
        
        let neverSequence = Observable<String>.never()
        let neverSequenceSubscription = neverSequence
            .subscribe { _ in
                print("This will never be printed")
        }
        neverSequenceSubscription.addDisposableTo(DisposeBag())
    }
    
    /// 直接创建
    func creat()  {
        let myJust = { (singleElement: Int) -> Observable<Int> in
            return Observable.create { observer in
                observer.on(.next(singleElement))
                observer.on(.completed)
                return Disposables.create()
            }
        }
        _ = myJust(5)
            .subscribe { event in
                print(event)
        }
        
        
        _ = Observable<String>.create({ (observerOfString) -> Disposable in
            print("Observable created")
            observerOfString.on(.next("😉"))
            observerOfString.on(.completed)
            return Disposables.create()
        }).subscribe({ (event) in
            print(event)
        })
    }
    
    /// Bag
    func bag() {
        
//        subscribe(: )会返回Disposable实例, 一般会把它处理掉, 由此介绍了DisposeBag这个类型, 感觉是相当于@autoReleasePool, 一条信号在完结的时候, 总要回收的嘛
        
        let disposeBag = DisposeBag()
        Observable<Int>.empty()
            .subscribe { event in
                print(event)
            }
            .addDisposableTo(disposeBag)
    }
    
    /// 其他简单样式
    func otherEasy() {

        // 创建有且只有单个元素的Sequence
        Observable.just("SingleElement")
            .subscribe { (event) in
                    print(event)
                }
            .addDisposableTo(DisposeBag())
        
        
        //创建固定数量多个元素的Sequence
        Observable.of("🐶", "🐱", "🐭", "🐹")
            .subscribe { (event) in
                print(event)
            }
            .addDisposableTo(DisposeBag())
        
        
        // 创建一个范围的元素组成的Sequence
        Observable.range(start: 1, count: 10)
            .subscribe { (event) in
                print(event)
        }.addDisposableTo(DisposeBag())
        
        
        //创建重复元素组成的Sequence
        Observable.repeatElement("🔴").take(3)
        .subscribe { (event) in
            print(event)
        }.addDisposableTo(DisposeBag())
        
        
        Observable.from(["🐶 -", "🐱", "🐭", "🐹 +"])
            .subscribe(onNext: { print($0) })
            .addDisposableTo(DisposeBag())
        
    }
    
    /// 自定义某个range构成的Sequence, 自己加其中过滤条件
    func generate()  {
        let disposeBag = DisposeBag()
        Observable.generate(
            initialState: 0,
            condition: { $0 < 3 },
            iterate: { $0 + 1 }
            )
            .subscribe(onNext: { print($0) })
            .addDisposableTo(disposeBag)
    }
 
    
    /// 只有在有观察者订阅时，才去创建序列
    func deferred()  {
//        let seq = Observable<Int>.create { (observer) -> Disposable in
//            observer.on(.next(2))
//            observer.onNext(3)
//            observer.onNext(4)
//            let err = NSError(domain: "error", code: 404, userInfo: nil)
//            observer.onError(err)
//           return Disposables.create()
//        }
//        seq.subscribe { (event) in
//            print(event)
//        }.addDisposableTo(DisposeBag())
        
        
        let disposeBag = DisposeBag()
        var count = 1
        
        let deferredSequence = Observable<String>.deferred {
            print("Creating \(count)")
            count += 1
            
            return Observable.create { observer in
                print("Emitting...")
                observer.onNext("🐶")
                observer.onNext("🐱")
                observer.onNext("🐵")
                return Disposables.create()
            }
        }
        
        deferredSequence
            .subscribe(onNext: { print($0) })
            .addDisposableTo(disposeBag)
        
        deferredSequence
            .subscribe(onNext: { print($0) })
            .addDisposableTo(disposeBag)
        
    }
    
    /// 顺便做做 --- 一次一次做的。顺便做一做, 并且只能在subscribe 之前顺便做
    func doon() {
        
        let disposeBag = DisposeBag()
        Observable.of("🍎", "🍐", "🍊", "🍋")
            .do(onNext: { print("Intercepted:", $0) }, onError: { print("Intercepted error:", $0) }, onCompleted: { print("Completed")  })
            .subscribe(onNext: { print($0) })
            .addDisposableTo(disposeBag)
    }
    
    /// 每个多少秒
    func interval(){
        
        //  这里不能加 addDisposableTo 不然释放了,定时器不起作用了
       _ = Observable<Int>.interval(1, scheduler: MainScheduler.instance).subscribe { (event) in
            print(event)
        }
    }
    
    /// 延迟
    func timer()  {
        //FIXME: 这里为什么执行两次
        print("++++")
        _ = Observable<Int>.timer(2, scheduler: MainScheduler.instance)
        .subscribe({ (event) in
            print("----延迟了2秒---")
        })
    }
}
