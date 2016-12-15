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
    var age = 25
    
    init(name: String, age: Int){
        self.name = name
        self.age = age
        super.init()
    }
    override init() {
        self.name = "Hony"
        self.age = 23
    }
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
        KVO()
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
        
        person.name = "love1111"
        person.rx.observe(String.self, #keyPath(Person.name)).subscribe { (e) in
            print(e)
        }.addDisposableTo(bag)
        person.name = "love2222"
        
        // 默认情况下，只打印最后发射的值
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
            print("tap 轻点")
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
    
    
    func rx_imgPicker()  {
        
        /**
        extension UIImagePickerController {
            public var rx_didFinishPickingMediaWithInfo: Observable<[String : AnyObject]> {}
            public var rx_didCancel: Observable<()> {}
        }*/
        
    }
    
    /// 其他的api
    func rx_otherUI() {
        /**
        extension UIBarButtonItem {
            public var rx_tap: ControlEvent<Void> {}
        }
        
        extension UISlider {
            public var rx_value: ControlProperty<Float> {}
        }
        
        extension UISegmentedControl {
            public var rx_value: ControlProperty<Int> {}
        }
        extension UISwitch {
            public var rx_value: ControlProperty<Bool> {}
        }
        extension UINavigationItem {
            public var rx_title: AnyObserver<String?> {}
        }
         
        extension UIActivityIndicatorView {
            public var rx_animating: AnyObserver<Bool> {}
        }
         */
    }
    
    func rx_tableView()  {
        
        /**
        extension UITableView {
            public var rx_dataSource: DelegateProxy {}
         
            public func rx_setDataSource(dataSource: UITableViewDataSource) -> Disposable {}
         
            public func rx_itemsWithCellFactory(source: O)(cellFactory: (UITableView, Int, S.Generator.Element) -> UITableViewCell) -> Disposable {}
         
            public func rx_itemsWithCellIdentifier(cellIdentifier: String, cellType: Cell.Type = Cell.self)(source: O)(configureCell: (Int, S.Generator.Element, Cell) -> Void) -> Disposable {}
            
            public func rx_itemsWithDataSource(dataSource: DataSource)(source: O) -> Disposable {}
            
            public var rx_itemSelected: ControlEvent<NSIndexPath> {}
            
            public var rx_itemDeselected: ControlEvent<NSIndexPath> {}
            
            public var rx_itemInserted: ControlEvent<NSIndexPath> {}
            
            public var rx_itemDeleted: ControlEvent<NSIndexPath> {}
            
            public var rx_itemMoved: ControlEvent<ItemMovedEvent> {}
            
            // This method only works in case one of the `rx_itemsWith*` methods was used, or data source implements `SectionedViewDataSourceType`
            public func rx_modelSelected<T>(modelType: T.Type) -> ControlEvent<T> {}
            
            // This method only works in case one of the `rx_itemsWith*` methods was used, or data source implements `SectionedViewDataSourceType`
            public func rx_modelDeselected<T>(modelType: T.Type) -> ControlEvent<T> {}
            
        }*/
    }
    
    func rx_collectionView()  {
        
        /**
        extension UICollectionView {
            
            public var rx_dataSource: DelegateProxy {}
            
            public func rx_setDataSource(dataSource: UICollectionViewDataSource) -> Disposable {}
            
            public func rx_itemsWithCellFactory(source: O)(cellFactory: (UICollectionView, Int, S.Generator.Element) -> UICollectionViewCell) -> Disposable {}
            
            public func rx_itemsWithCellIdentifier(cellIdentifier: String, cellType: Cell.Type = Cell.self)(source: O)(configureCell: (Int, S.Generator.Element, Cell) -> Void) -> Disposable {}
            
            public func rx_itemsWithDataSource(dataSource: DataSource)(source: O) -> Disposable {}
            
            public var rx_itemSelected: ControlEvent<NSIndexPath> {}
            
            public var rx_itemDeselected: ControlEvent<NSIndexPath> {}
            
            // This method only works in case one of the `rx_itemsWith*` methods was used, or data source implements `SectionedViewDataSourceType`
            public func rx_modelSelected<T>(modelType: T.Type) -> ControlEvent<T> {}
            
            // This method only works in case one of the `rx_itemsWith*` methods was used, or data source implements `SectionedViewDataSourceType`
            public func rx_modelSelected<T>(modelType: T.Type) -> ControlEvent<T> {}
        }*/
        
    }
    
    
}
