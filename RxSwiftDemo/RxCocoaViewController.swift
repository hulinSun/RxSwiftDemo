//
//  RxCocoaViewController.swift
//  RxSwiftDemo
//
//  Created by Hony on 2016/12/12.
//  Copyright © 2016年 Hony. All rights reserved.
//


import CoreLocation

import UIKit
import RxSwift
import RxCocoa
import RxBlocking

class Person: NSObject {
    var name = "Hony"
    let age = 25
}

let bag  = DisposeBag()


class RxCocoaViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        rx_guesture()
    }
    
    var person: Person!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
//        KVO()
        
    }
    
    // 释放的钩子
    func rx_dealloc()  {
        Person().rx.deallocated.subscribe {
            print("person  释放了")
            }.addDisposableTo(bag)
    }
    
    // FIXME: 这里e.type 还没搞好
    func KVO() {
        
        person = Person()
        person.name = "hony1"
        person.name = "love1"
        person.rx.observeWeakly(String.self, #keyPath(Person.name), options: .new).subscribe { (e) in
            print(e)
        }.addDisposableTo(bag)
        person.name = "hony"
        person.name = "love"
    }

    
    // Session
    func session() {
        
        let session = URLSession.shared
        let request = URLRequest(url: URL(string: "s")!)
        session.rx.response(request: request).subscribe { (e) in
            print(e)
        }.addDisposableTo(bag)
        _ = session.rx.data(request: request).subscribe { (e) in
            print(e)
        }
        _ = session.rx.json(url: URL(string: "s")!).subscribe({ (e) in
            print(e)
        })
    }
    
    
    // 通知
    func notification() {
        let name = Notification.Name.init("SomeNotificationName")
        NotificationCenter.default.rx.notification(name, object: person).subscribe { (e) in
            print(e)
        }.addDisposableTo(bag)
    }
    
    // 手势
    func rx_guesture() {
        let tap = UITapGestureRecognizer()
        tap.rx.event.subscribe { (e) in
            print("清点")
        }.addDisposableTo(bag)
        view.addGestureRecognizer(tap)
    }
    
    // CLLocation
    func rx_locationManager() {
        
        /**
        public var rx_delegate: DelegateProxy {}
        
        public var rx_didUpdateLocations: Observable<[CLLocation]> {}
        
        public var rx_didFailWithError: Observable<NSError> {}
        
        public var rx_didFinishDeferredUpdatesWithError: Observable<NSError> {}
        
        public var rx_didPauseLocationUpdates: Observable<Void> {}
        
        public var rx_didResumeLocationUpdates: Observable<Void> {}
        
        public var rx_didUpdateHeading: Observable<CLHeading> {}
        
        public var rx_didEnterRegion: Observable<CLRegion> {}
        
        public var rx_didExitRegion: Observable<CLRegion> {}
        
        public var rx_didDetermineStateForRegion: Observable<(state: CLRegionState, region: CLRegion)> {}
        
        public var rx_monitoringDidFailForRegionWithError: Observable<(region: CLRegion?, error: NSError)> {}
        
        public var rx_didStartMonitoringForRegion: Observable<CLRegion> {}
        
        public var rx_didRangeBeaconsInRegion: Observable<(beacons: [CLBeacon], region: CLBeaconRegion)> {}
        
        public var rx_rangingBeaconsDidFailForRegionWithError: Observable<(region: CLBeaconRegion, error: NSError)> {}
        
        public var rx_didVisit: Observable<CLVisit> {}
        
        public var rx_didChangeAuthorizationStatus: Observable<CLAuthorizationStatus> {}
        */
        
    }
    
    // UIControl
    func rx_control()  {
        
        let control = UIControl()
        control.rx.controlEvent(.touchUpInside).subscribe { (_) in
            print("相应事件")
        }.addDisposableTo(bag)
        
//        public var rx_enabled: ObserverOf<Bool> {}
        _ = control.rx.isEnabled
    }
    
    // UIButton - tap
    func tap()  {
        let btn = UIButton()
        btn.rx.tap.subscribe { (_) in
            print("点击了按钮")
        }.addDisposableTo(bag)
    }
    
    // UITextField/UITextView/Label - text
    func rx_text()  {
        let textfild = UITextField()
        // orEmpty  过滤掉可选
        textfild.rx.text.orEmpty.subscribe { (e) in
            print(e)
        }.addDisposableTo(bag)
    }
    
    
    func rx_searchBar(){
        let bar = UISearchBar()
        bar.rx.searchButtonClicked.subscribe { (_) in
            print("点击了搜索按钮")
        }.addDisposableTo(bag)
        bar.rx.text.orEmpty.subscribe { (_) in
            print("文字")
        }.addDisposableTo(bag)
    }
    
    func rx_datePicker()  {
        let picker = UIDatePicker()
        picker.rx.date.subscribe { (e) in
            print(e)
        }.addDisposableTo(bag)
    }
    
    func rx_scrollview()  {
        /**
        extension UIScrollView {
            public var rx_delegate: DelegateProxy {}
            public func rx_setDelegate(delegate: UIScrollViewDelegate) {}
            public var rx_contentOffset: ControlProperty<CGPoint> {}
        }*/
        let sc = UIScrollView()
        sc.rx.contentOffset.subscribe { (e) in
            print(e)
        }.addDisposableTo(bag)
    }
}
