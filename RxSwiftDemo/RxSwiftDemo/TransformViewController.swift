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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
//        map()
//        mapWithIdx()
        flatmap()
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
        let bag = DisposeBag()
        let obr1 = Observable.of(1,2,3)
        let obr2 = Observable.of("A","B","C","D");

        obr1.flatMap { (num) -> Observable<String> in
            print("----- \(num) ----")
            return obr2
        }.subscribe { (e) in
            print(e)
        }.addDisposableTo(bag)
    }
}
