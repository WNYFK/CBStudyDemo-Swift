//
//  CBRXViewController1.swift
//  CBStudyDemo
//
//  Created by ChenBin on 2020/7/22.
//  Copyright © 2020 ChenBin. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa

typealias JSON = Any

final class CBRXViewController1: CBBaseViewController {
    let usernameTF = UITextField(frame: CGRect(x: 100, y: 60, width: 100, height: 40))
    let usernameValidLab = UILabel(frame: .zero)
    
    let passwordTF = UITextField(frame: .zero)
    let passwordVaildLab = UILabel(frame: .zero)
    
    let doSomethingBtn = UIButton(type: .custom)
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        usernameValidLab.text = "Username has to be at least \(3) characters"
        passwordVaildLab.text = "Password has to be at least \(5) characters"

        
        bindAction()
        
        doSomethingBtn.rx.tap.subscribe(onNext: { () in
            print("点击")
            }).disposed(by: disposeBag)
        test44_Operator()
    }
    
    private func bindAction() {
        let usernameValid = usernameTF.rx.text.orEmpty.map({ $0.count >= 3 }).share(replay: 1)
        
        usernameValid.bind(to: passwordTF.rx.isEnabled).disposed(by: disposeBag)
        usernameValid.bind(to: usernameValidLab.rx.isHidden).disposed(by: disposeBag)
        
        let passwordValid = passwordTF.rx.text.orEmpty.map({ $0.count >= 5 }).share(replay: 1)
        passwordValid.bind(to: passwordVaildLab.rx.isHidden).disposed(by: disposeBag)
        
        let everythingValid = Observable.combineLatest(usernameValid, passwordValid) { $0 && $1 }.share(replay: 1)
        everythingValid.bind(to: doSomethingBtn.rx.isEnabled).disposed(by: disposeBag)
    }
    
    private func setupViews() {
        view.cb.addSubviews(views: usernameTF, usernameValidLab, passwordTF, passwordVaildLab, doSomethingBtn)
        usernameTF.borderStyle = .roundedRect
        usernameTF.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(60)
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
        usernameValidLab.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(usernameTF.snp.bottom).offset(10)
        }
        passwordTF.borderStyle = .roundedRect
        passwordTF.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(usernameValidLab.snp.bottom).offset(20)
            make.width.equalTo(usernameTF.snp.width)
            make.height.equalTo(usernameTF.snp.height)
        }
        passwordVaildLab.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordTF.snp.bottom).offset(20)
        }
        
        doSomethingBtn.setTitle("确认", for: .normal)
        doSomethingBtn.setTitleColor(UIColor.black, for: .normal)
        doSomethingBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordVaildLab.snp.bottom).offset(30)
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
    }
    
    func test() {
        let taps: Observable<Void> = doSomethingBtn.rx.tap.asObservable()
        taps.subscribe(onNext: { () in
            print("")
        })
        
        let image: Observable<UIImage> = Observable.of(UIImage())
        let imgView = UIImageView(frame: .zero)
        image.bind(to: imgView.rx.image)
    }
    
    func test1() {
        let text = usernameTF.rx.text.orEmpty.asObservable()
        let passwordValid = text.map({ $0.count >= 10 })
        let observer = passwordVaildLab.rx.isHidden
        
        let disposable = passwordValid.subscribeOn(MainScheduler.instance).observeOn(MainScheduler.instance).bind(to: observer)
    }
    
    func test41() {
        let numbers: Observable<Int> = Observable.create { (observer) -> Disposable in
            observer.onNext(0)
            observer.onNext(1)
            observer.onNext(2)
            observer.onNext(3)
            observer.onNext(4)
            observer.onNext(5)
            observer.onNext(6)
            observer.onNext(7)
            observer.onNext(8)
            observer.onNext(9)
            observer.onCompleted()
            return Disposables.create()
        }
        numbers.subscribe(onNext: { (num) in
            print(num)
        })
        
        let json: Observable<JSON> = Observable.create { (observer) -> Disposable in
            let task = URLSession.shared.dataTask(with: URL(string: "")!) { (data, _, error) in
                guard error == nil else {
                    observer.onError(error!)
                    return
                }
                
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    func test41_Single() {
        func getRepo(_ repo: String) -> Single<[String: Any]> {
            return Single<[String: Any]>.create { (single) -> Disposable in
                let task = URLSession.shared.dataTask(with: URL(string: "")!) { (data, _, error) in
                    if let error = error {
                        single(.error(error))
                        return
                    }
                    single(.success([:]))
                }
                task.resume()
                return Disposables.create {
                    task.cancel()
                }
            }
        }
        getRepo("").subscribe(onSuccess: { (json) in
            print(json)
        }) { (error) in
            print(error)
        }.disposed(by: DisposeBag())
    }
    
    func test41_Completable() {
        func cacheLocally() -> Completable {
            return Completable.create { (completable) -> Disposable in
                completable(.completed)
                return Disposables.create()
            }
        }
        cacheLocally().subscribe(onCompleted: {
            print("")
        }) { (error) in
            print(error)
        }
    }
    func test41_Maybe() {
        func generateString() -> Maybe<String> {
            return Maybe<String>.create { (maybe) -> Disposable in
                maybe(.success("asdf"))
                maybe(.completed)
//                maybe(.error(<#T##Error#>))
                return Disposables.create()
            }
        }
        generateString().subscribe(onSuccess: { (element) in
            print(element)
        }, onError: { (error) in
            print(error)
        }) {
            print("completed")
        }
    }
    
    func test41_Driver() {
        
    }
    
    func test41_Signal() {
        let event: Signal<Void> = doSomethingBtn.rx.tap.asSignal()
        let observer: () -> Void = { print("点击") }
        event.emit(onNext: observer)
    }
    
    func test42_Observer() {
        let disposeBag = DisposeBag()
        let observer: AnyObserver<Data> = AnyObserver { (event) in
            switch event {
            case .next(let data):
                print("Data Task Success with count: \(data.count)")
            case .error(let error):
                print("Data Task Error:\(error)")
            default:
                break
            }
        }
        URLSession.shared.rx.data(request: URLRequest(url: URL(string: "")!)).subscribe(observer).disposed(by: disposeBag)
    }
    func test42_binder() {
        let disposeBag = DisposeBag()
        let observer: Binder<Bool> = Binder(usernameTF) { (view, isHidden) in
            view.isHidden = isHidden
        }
        let usernameValid = usernameTF.rx.text.orEmpty.map({ $0.count > 5 })
        usernameValid.bind(to: observer).disposed(by: disposeBag)
        usernameValidLab.rx.isHidden
    }
    func test43_AsyncSubject() {
        let disposeBag = DisposeBag()
        let subject = AsyncSubject<String>()
        subject.subscribe({ print("Subscription: 1 Event:", $0) }).disposed(by: disposeBag)
        subject.onNext("aaa")
        subject.onNext("bbb")
        subject.onNext("ccc")
        subject.onCompleted()
        
    }
    func test43_publishSubject() {
        let disposeBag = DisposeBag()
        let subject = PublishSubject<String>()
        subject.subscribe({ print("Subscription: 1 Event:", $0)}).disposed(by: disposeBag)
        subject.onNext("1111")
    }
    
    func test44_Operator() {
        let disposeBag = DisposeBag()
        let rxHamburg: Observable<String> = Observable.of("aa", "bb", "ccc")
        let rxFrenchFries: Observable<Int> = Observable.of(111, 22, 33, 44)
        Observable.zip(rxHamburg, rxFrenchFries)
            .subscribe(onNext: { (hamburg, frenchFries) in
                print("取得汉堡：\(hamburg) 和 薯条：\(frenchFries)")
            }).disposed(by: disposeBag)
        test47_Error()
    }
    func test47_Error() {
        let disposeBag = DisposeBag()
        let rxJson: Observable<String> = Observable.create { (observer) -> Disposable in
            observer.onError(RxError.unknown)
            return Disposables.create()
        }
        rxJson.retry(3).takeUntil(self.rx.deallocated).subscribe(onNext: { (json) in
            print(json)
            print(rxJson)
        }, onError: { (error) in
            print(error)
            })
        
        rxJson.retryWhen { (rxError) -> Observable<Int> in
            return Observable.timer(3, scheduler: MainScheduler.instance)
        }.subscribe { (event) in
            print(rxJson)
            print(event.element)
        }
        
    }
}
