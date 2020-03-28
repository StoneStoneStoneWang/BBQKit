//
//  UITextField+WL.swift
//  TSTFKit_Swift
//
//  Created by three stone 王 on 2018/11/17.
//  Copyright © 2018年 three stone 王. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    @objc (bbq_backgroundColor:)
    public func bbq_backgroundColor(_ color: UIColor) {
        
        backgroundColor = color
    }
    @objc (bbq_font:)
    public func bbq_font(_ font: UIFont) {
        
        self.font = font
    }
    @objc (bbq_textColor:)
    public func bbq_textColor(_ color: UIColor) {
        
        textColor = color
    }
    @objc (bbq_textAlignment:)
    public func bbq_textAlignment(_ alignment: NSTextAlignment) {
        
        textAlignment = alignment
    }
    @objc (bbq_keyboardType:)
    public func bbq_keyboardType(_ keyboardType: UIKeyboardType) {
        
        self.keyboardType = keyboardType
    }
    @objc (bbq_clearButtonMode:)
    public func bbq_clearButtonMode(_ clearButtonMode: UITextField.ViewMode) {
        
        self.clearButtonMode = clearButtonMode
        
    }
    @objc (bbq_returnKeyType:)
    public func bbq_returnKeyType(_ returnKeyType: UIReturnKeyType) {
        
        self.returnKeyType = returnKeyType
    }
    @objc (bbq_rightViewMode:)
    public func bbq_rightViewMode(_ rightViewMode: UITextField.ViewMode) {
        
        self.rightViewMode = rightViewMode
    }
    @objc (bbq_leftViewMode:)
    public func bbq_leftViewMode(_ leftViewMode: UITextField.ViewMode) {
        
        self.leftViewMode = leftViewMode
    }
    @objc (bbq_leftView:)
    public func bbq_leftView(_ leftView: UIView) {
        
        self.leftView = leftView
    }
    @objc (bbq_rightView:)
    public func bbq_rightView(_ rightView: UIView) {
        
        self.rightView = rightView
    }
}

public typealias BBQShouldReturn = () -> Bool

public typealias BBQShouldClear = () -> Bool

extension UITextField: UITextFieldDelegate {
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return true
    }
    
    fileprivate var shouldReturn: BBQShouldReturn! {
        set {
            
            objc_setAssociatedObject(self, "shouldReturn", newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            
            return objc_getAssociatedObject(self, "shouldReturn") as? BBQShouldReturn
        }
    }
    @objc (bbq_shouldReturn:)
    public func bbq_shouldReturn(_ shouldReturn: @escaping () -> Bool) {
        
        self.shouldReturn = shouldReturn
    }
    @objc (textFieldShouldReturn:)
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if shouldReturn == nil {
            
            return true
        }
        
        return shouldReturn!()
    }
    
    fileprivate var shouldClear: BBQShouldClear! {
        
        set {
            
            objc_setAssociatedObject(self, "shouldClear", newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            
            return objc_getAssociatedObject(self, "shouldClear") as? BBQShouldClear
        }
    }
    @objc (bbq_shouldClear:)
    public func bbq_shouldClear(_ shouldClear: @escaping () -> Bool) {
        
        self.shouldClear = shouldClear
    }
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        
        if shouldClear == nil {
            
            return true
        }
        
        return shouldClear!()
    }
}

