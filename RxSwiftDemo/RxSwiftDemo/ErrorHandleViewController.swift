//
//  ErrorHandleViewController.swift
//  RxSwiftDemo
//
//  Created by Hony on 2016/12/12.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxBlocking


// RxSwift 错误处理
class ErrorHandleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
//        retry()
//        catchError()
        catchErrorReturn()
        
    }
    
    func retry()  {
        // 一般用在网络请求失败时，再去进行请求。 retry 就是失败了再尝试，重新订阅一次序列。
        
        //不难发现这里的 retry 会出现数据重复的情况，我推荐 retry 只用在会发射一个值的序列（可能发射 Error 的序列）中。
        
        // 需要注意的是不加参数的 retry 会无限尝试下去。我们还可以传递一个 Int 值，来说明最多尝试几次。像这样 retry(2) ，最多尝试两次。
        
        var  count = 1
        let seq = Observable<Int>.create { (obser) -> Disposable in
            let err = NSError(domain: "test", code: 404, userInfo: nil)
            obser.onNext(1)
            obser.onNext(2)
            obser.onNext(3)
            if count < 2{
                obser.onError(err)
                count += 1
            }
            obser.onNext(4)
            obser.onNext(5)
            obser.onCompleted()
            return Disposables.create()
        }
        
       _ = seq.retry(2).subscribe { (e) in
            print(e)
        }
    }
    
    func catchError()  {
        // 当出现 Error 时，用一个新的序列替换。
        // 1 2 4 100 200 300 400 后面跟上的。也会包括之前的值,但是失败的值且以后得不会包括
        let sequenceThatFails = PublishSubject<Int>()
        let recoverySequence = Observable.of(100, 200, 300, 400)
        _ = sequenceThatFails
            .catchError { error in
                return recoverySequence
            }
            .subscribe {
                print($0)
        }
        sequenceThatFails.on(.next(1))
        sequenceThatFails.on(.next(2))
        sequenceThatFails.on(.next(3))
        sequenceThatFails.on(.error(NSError(domain: "Test", code: 0, userInfo: nil)))
        sequenceThatFails.on(.next(4))

    }
    
    func catchErrorReturn()  {
        // ，就是遇到错误，返回一个值替换这个错误。
        let sequenceThatFails = PublishSubject<Int>()
        _ = sequenceThatFails
            .catchErrorJustReturn(100)
            .subscribe {
                print($0)
        }
        
        sequenceThatFails.on(.next(1))
        sequenceThatFails.on(.next(2))
        sequenceThatFails.on(.next(3))
        sequenceThatFails.on(.error(NSError(domain: "Test", code: 0, userInfo: nil)))
        sequenceThatFails.on(.next(4))
    }

}
