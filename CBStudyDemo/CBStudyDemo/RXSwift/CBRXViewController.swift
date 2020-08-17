//
//  CBRXViewController.swift
//  CBStudyDemo
//
//  Created by ChenBin on 2020/7/10.
//  Copyright © 2020 ChenBin. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct Teacher {
    let name: String
}
struct Comment {
    let detail: String
}
struct UserInfo {
    let id: Int
    let name: String
}

enum API {
    static func token(username: String, password: String) -> Observable<String> {
        return Observable.of("asdfasdf")
    }
    
    static func userInfo(token: String) -> Observable<UserInfo> {
        return Observable.of(UserInfo(id: 1, name: "userInfo"))
    }
    
    static func teacher(teacherId: Int) -> Observable<Teacher> {
        return Observable.create { (ob) -> Disposable in
            ob.onNext(Teacher(name: "aaa"))
            ob.onCompleted()
            return Disposables.create()
        }
    }
    
    static func teacherComments(teacherId: Int) -> Observable<[Comment]> {
        return Observable.create { (ob) -> Disposable in
            ob.onNext([Comment(detail: "comment1"), Comment(detail: "comment2")])
            ob.onCompleted()
            return Disposables.create()
        }
    }
}


final class CBRXViewController: CBBaseViewController, UIScrollViewDelegate {
    
    let scrollView = UIScrollView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        RXDemo.test()
        let disposeBag = DisposeBag()
        scrollView.rx.contentOffset.subscribe(onNext: { (point) in
            print(point)
            }).disposed(by: disposeBag)
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 100, y: 30, width: 50, height: 30)
        btn.setTitle("点击", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        view.addSubview(btn)
        _ = btn.rx.controlEvent(.touchUpInside).subscribe { [weak btn] _ in
            guard let btn = btn else { return }
            btn.cb.top = btn.cb.top + 10
        }
        _ = btn.rx.observe(CGRect.self, "frame").subscribe(onNext: { (frame) in
            print(frame)
            })
        _ = btn.rx.observeWeakly(CGRect.self, "frame").subscribe(onNext: { (frame) in
            print(frame)
        })
        
//        URLSession.shared.rx
//            .data(request: URLRequest(url: URL(string: "")!))
//            .subscribe(onNext: { (data) in
//                print("Data Task Success with count: \(data.count)")
//            }, onError: { (error) in
//                print("Data Task Error: \(error)")
//            }).disposed(by: disposeBag)
        
        NotificationCenter.default.rx
            .notification(.UIApplicationWillEnterForeground)
            .subscribe(onNext: { (notification) in
                print("Application Will Enter Foreground")
            }).disposed(by: disposeBag)
        apiTest()
    }
    
    func apiTest() {
        let disposeBag = DisposeBag()
        API.token(username: "beeasdf", password: "asdfadsf")
            .flatMapFirst(API.userInfo)
            .subscribe(onNext: { (userInfo) in
                print("用户信息成功：\(userInfo.name)")
            }, onError: { (error) in
                print("用户信息失败")
            }).disposed(by: disposeBag)
        
        Observable.zip(API.teacher(teacherId: 11), API.teacherComments(teacherId: 11))
            .subscribe(onNext: { (teacher, comments) in
                print("获取老师信息成功：\(teacher.name)")
                print("获取老师评论：\(comments.count) 条")
            }, onError: { (error) in
                print("获取老师信息或评论失败: \(error)")
            }).disposed(by: disposeBag)
    }
}
