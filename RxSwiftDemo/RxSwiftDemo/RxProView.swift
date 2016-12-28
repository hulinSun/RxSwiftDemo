//
//  RxProView.swift
//  RxSwiftDemo
//
//  Created by Hony on 2016/12/19.
//  Copyright © 2016年 Hony. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa
import RxBlocking
import RxDataSources


@objc protocol RxProViewProtocol: NSObjectProtocol {
    @objc optional func log()
}

class RxProView: UIView {
    
    weak var delegate: RxProViewProtocol?
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        delegate?.log?()
    }
}

extension RxProView {
 
}


/******************************************************/

class RxProViewProtocolProxy: DelegateProxy, DelegateProxyType, RxProViewProtocol{
    
    static func currentDelegateFor(_ object: AnyObject) -> AnyObject? {
        let view = object as! RxProView
        return view.delegate
    }
    
    static func setCurrentDelegate(_ delegate: AnyObject?, toObject object: AnyObject) {
        let view = object as! RxProView
        view.delegate = delegate as? RxProViewProtocol
    }
}






