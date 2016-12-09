//
//  TransformViewController.swift
//  RxSwiftDemo
//
//  Created by Hony on 2016/12/9.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxBlocking


class TransformViewController: UIViewController {

    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
//        map()
//        mapWithIdx()
//        flatmap()
        scan()
    }
    
    
    func map()  {
        // 注意，这里如果是[1,2,3,4,5] 那么item 就是数组类型
        Observable.of(1,2,3,4,5).map { item  in
            return item * 2
        }.subscribe { (e) in
            print(e)
        }.addDisposableTo(DisposeBag())
    }
    
    
    func mapWithIdx()  {
        ///注意第一个是序列发射的值，第二个是 index 。
        Observable.of(1,2,3).mapWithIndex { item , idx in
            item * idx
        }.subscribe { print($0) }
            .addDisposableTo(DisposeBag())
    }
    
    
    func flatmap()  {
        
        //FIXME: 这里有问题吧?
        let obr1 = Observable.of(1,2,3)
        let obr2 = Observable.of("A","B","C","D");

        obr1.flatMap { (num) -> Observable<String> in
            print("----- \(num) ----")
            return obr2
        }.subscribe { (e) in
            print(e)
        }.addDisposableTo(bag)
        
        //flatlatest:暂时归在 flatMap 中，和 flatMap 不同的就是，当进行 flatMap 转换时有新的值发射过来时就丢弃旧的值，去 flatMap 新的值。
            
        // flatfitst:flatMapFirst 和 flatMapLatest 不同就是 flatMapFisrt 会选择旧的值，抛弃新的。
    }
    
    func scan() {
        
        // scan:应用一个 accumulator (累加) 的方法遍历一个序列，然后返回累加的结果。此外我们还需要一个初始的累加值。实时上这个操作就类似于 Swift 中的 reduce 。
        // 那些返回的结果各个，并不相加 之后返回，只是返回当前这一步骤计算的结果
        Observable.of(1,2,3,4).scan(3, accumulator: { acum ,elem in
            print("acum = \(acum) , elem = \(elem)")
            return acum * elem
        }).subscribe { (e) in
            print(e)
        }.addDisposableTo(bag)
    }
}
