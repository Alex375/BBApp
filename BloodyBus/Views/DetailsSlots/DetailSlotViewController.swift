//
//  DetailSlotViewController.swift
//  BloodyBus
//
//  Created by Alexandre Josien on 12/07/2023.
//

import UIKit

class DetailSlotViewController: UIViewController {

    //MARK: - UI var
    lazy var header = DetailHeaderView()
    lazy var durationInfo = DetailInfoView()
    lazy var placesInfo = DetailInfoView()
    
    lazy var map = MapInfoView()
    
    //MARK: - Variables
    var user: UserEntity?
    var userSlot: UserSlotEntity?
    var slot: SlotEntity?
    var session: SessionEntity?
    var iAmOwner: Bool = false
    var isLoaded = false
//    let loaddingVC = LoadingViewController()
    var alert: UIAlertController?
    var completion: (UserEntity) -> () = {_ in}
    
    private var mapReduceConstrains: AnchoredConstraints?
    private var mapFullScreenConstrains: AnchoredConstraints?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpController()
        basicSetup()
        
        //setUpview()
        
        setUpTitles()
        
        layoutHeader()
        layoutInfos()
        layoutMap()
        
        setInfo()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        guard let _ = session else {
//            if !self.isLoaded
//            {
//                loaddingVC.present(target: self, completion: nil)
//            }
//            return
//        }
        setInfo()
    }
    
    //MARK: - Setup methods
    func setUpTitles()
    {
        durationInfo.title = "session.detail.duration.title".localized
        durationInfo.info = "-"
        
        placesInfo.title = "session.detail.bench.title".localized
        placesInfo.info = "-"
        
    }
    
    func layoutHeader()
    {
        view.addSubview(header)
        
        header.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                      leading: view.safeAreaLayoutGuide.leadingAnchor,
                      bottom: nil,
                      trailing: view.safeAreaLayoutGuide.trailingAnchor,
                      padding: .init(top: 35, left: 20, bottom: 0, right: 20))
    }
    
    func layoutInfos()
    {
        let firstStack = view.stack(.horizontal, views: durationInfo, placesInfo, spacing: 0)
        placesInfo.widthAnchor.constraint(equalTo: durationInfo.widthAnchor, multiplier: 9/10).isActive = true
        
        
        firstStack.anchor(top: header.bottomAnchor,
                          leading: view.safeAreaLayoutGuide.leadingAnchor,
                          bottom: nil,
                          trailing: view.safeAreaLayoutGuide.trailingAnchor,
                          padding: .init(top: 40, left: 20, bottom: 0, right: 10))
    }

    func setInfo()
    {
        if let userSlot = userSlot {
            header.donation = userSlot.service
            header.date = userSlot.startTime.dateValue()
        }
        
        guard let slot = slot else {
            return
        }
        
        header.donation = slot.service
        header.date = slot.startTime.dateValue()
        
        
        durationInfo.info = "1h30"
        
        placesInfo.info = "\(slot.bench)"

        guard let session = session else {
            return
        }
        
        map.centerToLocation(session.location.geoPoint, name: Donation.getDonation(with: slot.service), regionRadius: 10000)
    }

    func basicSetup()
    {
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = UIColor(named: "VCBackground")
    }
    
    func setUpController()
    {
        
        self.setInfo()
    }
    
    func fullScreenToogle()
    {
        let temp = map.isFullScreen
        
        mapReduceConstrains?.top?.isActive = temp
        mapReduceConstrains?.leading?.isActive = temp
        mapReduceConstrains?.trailing?.isActive = temp
        mapReduceConstrains?.bottom?.isActive = temp
        
        
        mapFullScreenConstrains?.top?.isActive = !temp
        mapFullScreenConstrains?.leading?.isActive = !temp
        mapFullScreenConstrains?.trailing?.isActive = !temp
        mapFullScreenConstrains?.bottom?.isActive = !temp
        
        map.layer.cornerRadius = temp ? 20: 0
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }

    }
    
    func layoutMap()
    {
        view.addSubview(map)
        
        
        mapFullScreenConstrains = map.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.safeAreaLayoutGuide.leadingAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            trailing: view.safeAreaLayoutGuide.trailingAnchor)
        
        mapFullScreenConstrains?.trailing?.isActive = false
        mapFullScreenConstrains?.leading?.isActive = false
        mapFullScreenConstrains?.bottom?.isActive = false
        mapFullScreenConstrains?.top?.isActive = false
        
        
        mapReduceConstrains = map.anchor(top: placesInfo.bottomAnchor,
                   leading: view.safeAreaLayoutGuide.leadingAnchor,
                   bottom: view.safeAreaLayoutGuide.bottomAnchor,
                   trailing: view.safeAreaLayoutGuide.trailingAnchor,
                   padding: .init(top: 30, left: 20, bottom: 50, right: 20))
        map.layer.cornerRadius = 20
        
        
        map.layer.masksToBounds = true
        
        map.fullScreenCompletion = {
            self.fullScreenToogle()
        }
    }
}
