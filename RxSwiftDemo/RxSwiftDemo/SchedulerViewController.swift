//
//  SchedulerViewController.swift
//  RxSwiftDemo
//
//  Created by Hony on 2016/12/12.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxBlocking


// 封装
public enum TScheduler {
    case main
    case serial( DispatchQoS.QoSClass)
    case concurrent
    case operation(OperationQueue)
    
    public func scheduler() -> ImmediateSchedulerType {
        switch self {
        case .main:
            return MainScheduler.instance
        case .serial(let QOS):
            return SerialDispatchQueueScheduler.init(qos: DispatchQoS.init(qosClass: QOS, relativePriority: 0))
        case .concurrent:
//            return ConcurrentMainScheduler.instance
            let i = DispatchQoS.QoSClass.background
            let qos = DispatchQoS.init(qosClass: i, relativePriority: 0)
            return ConcurrentDispatchQueueScheduler.init(qos: qos)
        case .operation(let queue):
            return OperationQueueScheduler(operationQueue: queue)
        }
    }
}


extension ObservableType {
    public func observeOn(scheduler: TScheduler) -> RxSwift.Observable<Self.E> {
        return observeOn(scheduler.scheduler())
    }
    
}

class SchedulerViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
    }
    
    func test() {

        let imageView = UIImageView()
        let request = URLRequest(url: URL.init(string: "")!)
            URLSession.shared
            .rx.data(request: request)
            .map{UIImage.init(data: $0)}
            .observeOn(scheduler: .main) // // 切换到主线程
            .bindTo(imageView.rx.image) //  // 在主线程设置 `image`
            .addDisposableTo(DisposeBag())

    }
    
    
    
    func intro() {
        /*
        Observable.of(1,2,3)
            .observeOn(backgroundScheduler) // 切换到后台线程
            .map { n in
                print("在 background scheduler 执行")
            }
            .observeOn(MainScheduler.instance) // 切换到主线程
            .map { n in
                print("在 main scheduler")
        }*/
        
        /**
        调用一下 observeOn 就切换到我们想要的线程了。
        当前的线程切换支持 GCD 和 NSOperation 。
        在线程这部分主要有两个操作符：observeOn 和 subscribeOn ，常用的还是 observeOn 。
        调用 observeOn 指定接下来的操作在哪个线程。
        调用 subscribeOn 决定订阅者的操作执行在哪个线程。
        当然，如果我们没有明确调用这两个操作，后面的操作都是在当前线程执行的。
         */
        
        // 在 Rx 中我们已经有主线程切换的姿势： .observeOn(MainScheduler.instance)
        
        // MainScheduler 有一个很有用的功能：
        // public class func ensureExecutingOnScheduler()
        //你可以在需要保证代码一定执行在主线程的地方调用 MainScheduler.ensureExecutingOnScheduler() ，特别是在线程切换来切换去的情况下，或者是调用其他的库，我们不确定当前是否在执行在主线程。毕竟 UI 的更新还是要在主线程执行的。

        /**
        someObservable
            .doOneThing()   1
            .observeOn(MainRouteScheduler.instance) 2
            .subscribeOn(OtherScheduler.instance) 3
            .subscribeNext { 4
                ......
            }
            .addDisposableTo(disposeBag)
         
         1.所有动作都发生在当前的默认线程
         2.observeOn转换线程到主线程，下面所有的操作都是在主线程中
         3.subscribeOn规定动作一开始不是发生在默认线程了，而是在OtherScheduler了。
         4.如果我们之前没有调用observeOn，那么这边会在OtherScheduler发生，但是我们前面调用了observeOn，所以这个动作还是会在主线程中调用。
         总结一下：subscribeOn只是影响事件链开始默认的线程，而observeOn规定了下一步动作发生在哪个线程中。
         */
        
        
        /**
         * observeOn()和subscribeOn()
         * subscribeOn()设置起点在哪个线程，observeOn()设置了后续工作在哪个线程
         */
        
//        map函数执行了两遍，但是有些时候我不需要map函数里的东西执行两遍，比如map函数里面如果执行的是网络请求，我只需要一次请求结果供大家使用就行了，多余的请求没啥用，浪费时间。所以这时候就需要shareReplay(1)
        
        /**drive方法只能在Driver序列中使用，Driver有以下特点：1 Driver序列不允许发出error，2 Driver序列的监听只会在主线程中。所以Driver是转为UI绑定量身打造的东西。以下情况你可以使用Driver替换BindTo:
        
        不能发出error
        在主线程中监听
        共享事件流 */
        
        /**
        extension Reactive where Base: UITextField {
            var inputEnabled: UIBindingObserver<Base, Result> {
                return UIBindingObserver(UIElement: base) { textFiled, result in
                    textFiled.isEnabled = result.isValid
                }
            }
        }*/
        
    }

}
