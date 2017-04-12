//
//  HomeViewController.swift
//  Pipa
//
//  Created by 黄景川 on 16/12/6.
//  Copyright © 2016年 Pipa. All rights reserved.
//

import UIKit
import MQTTClient
import Alamofire

class HomeViewController: UIViewController,IFlySpeechRecognizerDelegate,IFlySpeechSynthesizerDelegate,MQTTSessionDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource{

    var collection:UICollectionView?
    
    var homeTableView:UITableView?
    
    //天气数据
    var dataDic:NSDictionary!
    
    //智能数据
    var intelligentData = Array<NSDictionary>()
    
    //讯飞语音识别
    var iFlySpeechRecognizer:IFlySpeechRecognizer!
    
    //语音合成
    var iFlySpeechSynthesizer:IFlySpeechSynthesizer!
    
    var msgData = Array<NSDictionary>()
    
    private var timer:DispatchSourceTimer?
    
    //物联网通讯协议
    var mySession:MQTTSession!
    
    var lightControllerView = LightControllerView()
    
    let intelligentName = ["室内温度","室内湿度","结露温度","瞬时水能耗","瞬时电能耗","PM2.5","水能总消耗","电能总消耗","室外温度","室外湿度","室外PM0.3","室外PM2.5","室外PM10","室外甲醛","室外二氧化碳","室内PM0.3","室内PM10","室内甲醛","室内二氧化碳"]
    
    let intelligentImg = [#imageLiteral(resourceName: "室内温度"),#imageLiteral(resourceName: "室内湿度"),#imageLiteral(resourceName: "结露温度"),#imageLiteral(resourceName: "瞬时水能消耗"),#imageLiteral(resourceName: "瞬时电能消耗"),#imageLiteral(resourceName: "室内PM2.5"),#imageLiteral(resourceName: "水能总消耗"),#imageLiteral(resourceName: "电能总消耗"),#imageLiteral(resourceName: "室外温度"),#imageLiteral(resourceName: "室外湿度"),#imageLiteral(resourceName: "室外PM0.3"),#imageLiteral(resourceName: "PM2.5"),#imageLiteral(resourceName: "室外PM10"),#imageLiteral(resourceName: "甲醛"),#imageLiteral(resourceName: "室外二氧化碳"),#imageLiteral(resourceName: "室内PM0.3"),#imageLiteral(resourceName: "室内PM10"),#imageLiteral(resourceName: "室内甲醛"),#imageLiteral(resourceName: "室内二氧化碳")]
    
    override func viewWillAppear(_ animated: Bool) {
        if mySession.status == .closed {
            mySession.connect()
        }
        
        if timer != nil{
            createTimer()
        }
        
        mySession.addObserver(self, forKeyPath: "status", options: .old, context: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "首页"
        self.view.backgroundColor = .black
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "切换输入", style: .plain, target: self, action: #selector(selectType))
        
        let initString = "appid=科大讯飞注册id"

        //拿取天气
        urlGetWeatherData()
        myCollectionView()
        createLightControllerView()
        createMyTableView()
        //初始化ifly
        IFlySpeechUtility.createUtility(initString)
        initRecognizer()
        initSynthesizer()
        //初始化mqtt
        initMQTT()
        //创建定时器
        createTimer()
        
        
    }
    
    func createTimer(){
        //定时器
        timer = DispatchSource.makeTimerSource(queue: .main)
        timer?.scheduleRepeating(deadline: .now() + 5, interval: 5, leeway: .milliseconds(40))
        timer?.setEventHandler{
            self.getIntelligentData()
        }
        timer?.resume()
    }
    
    func selectType(sender:UIBarButtonItem){
        
        var bool = false
        
        if sender.title == "切换输入" {
            
            self.navigationItem.rightBarButtonItem?.title = "切换语音"
            bool = true
            
        }else{
            
            self.navigationItem.rightBarButtonItem?.title = "切换输入"
            
        }
        
        lightControllerView.buildingLabel.isHidden = bool
        lightControllerView.controlBtn.isHidden = bool
        lightControllerView.roomTextField.isHidden = bool
        lightControllerView.msgTextField.isHidden = !bool
        lightControllerView.sendMsgBtn.isHidden = !bool
        
    }
    
    //MARK: - UITableViewDelegate
    func createMyTableView(){
        
        homeTableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        homeTableView?.delegate = self
        homeTableView?.dataSource = self
        homeTableView?.backgroundColor = BG_COLOR
        homeTableView?.separatorStyle = UITableViewCellSeparatorStyle.none
        homeTableView?.tableFooterView = UIView.init(frame: CGRect.zero)
        let cellNib = UINib(nibName: "HomeTableViewCell", bundle: nil)
        homeTableView?.register(cellNib, forCellReuseIdentifier: "msgCell")
        let myCellNib = UINib(nibName: "HomeMyTableViewCell", bundle: nil)
        homeTableView?.register(myCellNib, forCellReuseIdentifier: "myCell")
        self.view.addSubview(homeTableView!)
        homeTableView?.snp.makeConstraints({ (make) in
            make.bottom.equalTo(lightControllerView.snp.top).offset(0)
            make.right.left.equalToSuperview().offset(0)
            make.top.equalTo(collection!.snp.bottom)
        })
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return msgData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let dic = msgData[indexPath.row]
        
        return heightSizeWithContent(content: dic["value"] as! String, widthSize: SCREEN_WIDTH-120, fontSize: 14).height + 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let dic = msgData[indexPath.row]
        
        if (dic["name"] as! String) == "heimu" {
            
            let identifier = "msgCell"
            
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! HomeTableViewCell
            
            cell.backgroundColor = UIColor.clear
            
            cell.heimuHeadImageView.image = #imageLiteral(resourceName: "TOUXIAN")
            
            cell.heimuMessageLabel.text = dic["value"] as? String 
            
            return cell
            
        }else{
            
            let identifier = "myCell"
            
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! HomeMyTableViewCell
            
            cell.backgroundColor = UIColor.clear
            
            cell.myHeadImageView.image = #imageLiteral(resourceName: "TOUXIAN")
            
            cell.myMessageLabel.text = dic["value"] as? String
            
            return cell
        }
    }
    
    //MARK: - createLightControllerView
    func createLightControllerView(){
        lightControllerView = Bundle.main.loadNibNamed("LightControllerView", owner: self, options: nil)?.last as! LightControllerView
        lightControllerView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 195)
        self.view.addSubview(lightControllerView)
        lightControllerView.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-49)
            make.left.right.equalToSuperview().offset(0)
            make.height.equalTo(60)
        }
        
        lightControllerView.controlBtn.addTarget(self, action: #selector(startOrStop), for: .touchDown)
        lightControllerView.controlBtn.addTarget(self, action: #selector(cancelVico), for: .touchUpInside)
        lightControllerView.sendMsgBtn.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
    }
    
    func sendMessage(){
        let onTopic = "talk heimu"
        let dic = ["text":lightControllerView.msgTextField.text!,"location":["building":lightControllerView.buildingLabel.text!,"room":lightControllerView.roomTextField.text!]] as [String : Any]
        
        let data = try! JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
        
        
        mySession.publishData(data, onTopic: onTopic, retain: false, qos: .atMostOnce)
        
        msgData.append(["name":"my","value":lightControllerView.msgTextField.text!])
        lightControllerView.msgTextField.text = ""
        
        homeTableView?.insertRows(at: [NSIndexPath.init(row: (homeTableView?.numberOfRows(inSection: 0))!, section: 0) as IndexPath as IndexPath], with: .bottom)
        homeTableView?.scrollToRow(at:NSIndexPath.init(row: (homeTableView?.numberOfRows(inSection: 0))!-1, section: 0) as IndexPath, at: .bottom, animated: true)
    }
    
    func startOrStop(){
        iFlySpeechSynthesizer.stopSpeaking()
        iFlySpeechRecognizer.startListening()
        lightControllerView.controlBtn.backgroundColor = .green
        createTopBarNotification(msg: "正在识别")
    }
    
    func cancelVico(){
        iFlySpeechRecognizer.stopListening()
        lightControllerView.controlBtn.backgroundColor = NAV_COLOR
        topBarNotificationHide()
    }
    
    //MARK: - UICollectionViewDelegate
    
    func myCollectionView() {
        // 1.自定义 Item 的FlowLayout
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width:(SCREEN_WIDTH-20)/3, height:219)
        flowLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
        flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5)
        flowLayout.minimumLineSpacing = 5
        flowLayout.minimumInteritemSpacing = 5
        collection = UICollectionView(frame: CGRect(x:0, y:0, width:SCREEN_WIDTH, height:0), collectionViewLayout: flowLayout)
        collection?.backgroundColor = BG_COLOR
        collection?.alwaysBounceHorizontal = true
        collection?.showsHorizontalScrollIndicator = false
        collection?.dataSource = self
        collection?.delegate = self
        collection?.allowsSelection = true
        collection?.allowsMultipleSelection = false
        collection?.isPagingEnabled = true
        // 10.注册 UICollectionViewCell
        let cellNib = UINib(nibName: "HomeCollectionViewCell", bundle: nil)
        collection?.register(cellNib, forCellWithReuseIdentifier: "cell")
        
        let weatherNib = UINib(nibName: "WeatherCollectionViewCell", bundle: nil)
        collection?.register(weatherNib, forCellWithReuseIdentifier: "weatherCell")
        
        // 11.添加到 self.view 上
        self.view.addSubview(collection!)
        
        collection?.snp.makeConstraints({ (make) in
            make.height.equalTo(219)
            make.top.equalToSuperview().offset(64)
            make.right.left.equalToSuperview().offset(0)
        })
        
        getIntelligentData()
        
    }
    
    //MARK: - getData
    func getIntelligentData(){
        
        //拿取智能设备地址
        let urlStr = SEVER_IP + "/api/getDevice"
        
        let arr = [19,18,17,7,6]
        
        Alamofire.request(urlStr,method: .get).responseJSON { (response) in
            
            self.intelligentData = response.result.value! as! Array
            
            for i in 0 ..< 5 {
                self.intelligentData.remove(at: arr[i])
            }
            
            self.collection?.reloadData()
        }
        
        
    }
    
    func urlGetWeatherData(){
        //拿取天气数据
        let urlStr = "http://wthrcdn.etouch.cn/weather_mini?citykey=101250101"
        
        let data:NSData? = CacheFunc.getDataFromCache(proName: "weatherData")
        
        if data == nil {
            
            return
        }else{
            let dic = NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as! NSDictionary
            
            dataDic = dic
            
            let getData = timeToDetermine(nowDate: Date(), beforeDate: (dic["date"] as! Date))
            
            if !getData {return}
            
        }
        
        
        Alamofire.request(urlStr,method: .get).responseJSON { (response) in
            
            let dd = (response.result.value! as! NSDictionary)["data"] as! NSDictionary
            
            self.dataDic = (dd["forecast"] as! NSArray)[0] as! NSDictionary
            
            let type = self.dataDic["type"] as! String
            
            var weatherImg:UIImage!
            
            weatherImg = #imageLiteral(resourceName: "晴")
            
            if type.contains("晴"){
                weatherImg = #imageLiteral(resourceName: "晴")
            }
            
            if type.contains("阴"){
                weatherImg = #imageLiteral(resourceName: "阴")
            }
            
            if type.contains("雨"){
                weatherImg = #imageLiteral(resourceName: "小雨")
            }
            
            if type.contains("多云"){
                weatherImg = #imageLiteral(resourceName: "多云")
            }
            
            if type.contains("小雨"){
                weatherImg = #imageLiteral(resourceName: "小雨")
            }
            
            if type.contains("中雨"){
                weatherImg = #imageLiteral(resourceName: "中雨")
            }
            
            if type.contains("大雨"){
                weatherImg = #imageLiteral(resourceName: "大雨")
            }
            
            if type.contains("雪"){
                weatherImg = #imageLiteral(resourceName: "雪")
            }
            
            
            self.dataDic = ["type":type,
                            "tempLabel":"\(extractTheNumberInTheText(str: dd["wendu"] as! String))°",
                "lowTempLabel":"▼\(extractTheNumberInTheText(str: (self.dataDic["low"] as! String)))°",
                "highTempLabel":"▲\(extractTheNumberInTheText(str: (self.dataDic["high"] as! String)))°",
                "windDirectionLabel":(self.dataDic["fengxiang"] as! String),
                "windLabel":(self.dataDic["fengli"] as! String),
                "weatherImg":weatherImg,
                "date":Date()]
            
            let data:NSData = NSKeyedArchiver.archivedData(withRootObject: self.dataDic) as NSData
            
            CacheFunc.saveDataToCache(proName: "weatherData",Data: data)
            
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        var weather = 0
        if self.dataDic != nil {
            weather = 1
        }
        return Int(ceilf((Float(intelligentData.count)/6))) + weather
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            
            return 1
            
        }else{
            
            let numb = Int(ceilf((Float(intelligentData.count)/6)))
            let minNumb = intelligentData.count/6
            if section == numb{
                if numb > minNumb {
                    return intelligentData.count - minNumb*6
                }
            }else{
                return 6
            }
            
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        
        if indexPath.section == 0 {
            
            return CGSize(width: SCREEN_WIDTH-10, height: collection!.frame.height-10)
            
        }else{
            
            let cellHeight = CGFloat((Float(collection!.frame.height)-15)/2)
            return CGSize(width: (SCREEN_WIDTH-20)/3, height: cellHeight)
            
        }
        
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        if indexPath.section == 0 {
            
            let identifier = "weatherCell"
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! WeatherCollectionViewCell
            
            if dataDic != nil{
                let dic:NSDictionary = dataDic
                
                cell.weatherLabel.text = dic["type"] as! String?
                cell.weatherImageView.image = dic["weatherImg"] as! UIImage?
                cell.tempLabel.text = dic["tempLabel"] as! String?
                cell.lowTempLabel.text = dic["lowTempLabel"] as! String?
                cell.highTempLabel.text = dic["highTempLabel"] as! String?
                cell.windDirectionLabel.text = dic["windDirectionLabel"] as! String?
                cell.windLabel.text = dic["windLabel"] as! String?
                
            }
            
            if intelligentData.count != 0 {
                cell.humiLabel.text = (intelligentData[9]["value"] as! String) + "%"
                
                let number = Float(self.intelligentData[10]["value"] as! String)
                
                cell.pmLabel.text = "\(Int(number! * 0.00015))"
            }
            
            
            
            return cell
            
        }else{
            
            let identifier = "cell"
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! HomeCollectionViewCell
            
            let cellLine = indexPath.row + (indexPath.section-1)*6
            
            let dic = intelligentData[cellLine]
            
            let name = dic["name"] as! String
            
            var unitStr = ""
            
            if name.contains("temp") || name.contains("point"){
                unitStr = "°"
            }else if name.contains("water") {
                unitStr = "m³"
                if name.contains("cur") {
                    unitStr = "m³/h"
                }
            }else if name.contains("power"){
                unitStr = "kw"
                if name.contains("cur") {
                    unitStr = "kw/h"
                }
            }else if name.contains("humidity"){
                unitStr = "%"
            }else if name.contains("co2"){
                unitStr = "ppm"
            }
            
            if (cellLine) == 10 || cellLine == 15 {
                
                let number = Float(self.intelligentData[cellLine]["value"] as! String)
                cell.numberLabel.text = "\(Int(number!*0.00015))"
                
            }else{
                
                cell.numberLabel.text = (dic["value"] as! String) + unitStr
                
            }
            
            cell.nameLabel.text = intelligentName[cellLine]
            
            cell.iconDataImageView.image = intelligentImg[cellLine]
            
            return cell

        }
        
    }
    
    
    //MARK: - MQTTSessionDelegate
    //初始化MQTT
    func initMQTT(){
        
        let transport = MQTTCFSocketTransport.init()
        transport.host = "地址：www.baidu.com"
        transport.port = 端口号
        
        mySession = MQTTSession.init()
        mySession.transport = transport
        mySession.delegate = self
        mySession.clientId = UIDevice.current.name
        mySession.userName = "mqtt连接用户名"
        mySession.password = "密码"
        mySession.connectAndWaitTimeout(1)
        //语音
        //voice
        mySession.subscribe(toTopics: [UIDevice.current.name + " set device":0,UIDevice.current.name + " talk heimu":0]) { (error, gQoss) in
            if ((error) != nil) {//Topic则表示要订阅的主题，Level（qosLevel）表示消息等级。
                createTopBarNotification(msg: "物联网连接失败")
            } else {
                createTopBarNotification(msg: "物联网连接成功")
            }
            topBarNotificationHide()
        }
    }
    
    //监听状态，断线重连
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if mySession.status == .closed {
            mySession.connect()
            if mySession.status == .connecting{
                createTopBarNotification(msg: "物联网连接成功")
                topBarNotificationHide()
            }
        }
        
    }
    
    //重新连接之后再次订阅
    func connected(_ session: MQTTSession!, sessionPresent: Bool) {
        
        mySession.subscribe(toTopics: [UIDevice.current.name + " set device":0,UIDevice.current.name + " talk heimu":0])
        
    }
    
    func newMessage(_ session: MQTTSession!, data: Data!, onTopic topic: String!, qos: MQTTQosLevel, retained: Bool, mid: UInt32) {
        // 这个是代理回调方法，接收到的数据可以在这里进行处理。
        let json = try! JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! Dictionary<String, String>
        
        if json["type"]! == "voice-text" {
            
            if self.navigationItem.rightBarButtonItem?.title == "切换输入" {
                
                iFlySpeechSynthesizer.startSpeaking(json["data"]!)
                
            }
            
        }
        
        msgData.append(["name":"heimu","value":json["data"]!])
        homeTableView?.insertRows(at: [NSIndexPath.init(row: (homeTableView?.numberOfRows(inSection: 0))!, section: 0) as IndexPath as IndexPath], with: .bottom)
        homeTableView?.scrollToRow(at:NSIndexPath.init(row: (homeTableView?.numberOfRows(inSection: 0))!-1, section: 0) as IndexPath, at: .bottom, animated: true)
        
//        if json["type"]! == "voice-text" {
//            
//            msgData.append(["name":"heimu","value":json["data"]!])
//            homeTableView?.insertRows(at: [NSIndexPath.init(row: (homeTableView?.numberOfRows(inSection: 0))!, section: 0) as IndexPath as IndexPath], with: .bottom)
//            homeTableView?.scrollToRow(at:NSIndexPath.init(row: (homeTableView?.numberOfRows(inSection: 0))!-1, section: 0) as IndexPath, at: .bottom, animated: true)
//            
//            if self.navigationItem.rightBarButtonItem?.title == "切换输入" {
//                
//                iFlySpeechSynthesizer.startSpeaking(json["data"]!)
//                
//            }
//            
//        }
    }
    
    //MARK: - IFlySpeechSynthesizerDelegate
    func initSynthesizer(){
        
        iFlySpeechSynthesizer = IFlySpeechSynthesizer.sharedInstance()
        iFlySpeechSynthesizer.delegate = self
        
        iFlySpeechSynthesizer.setParameter(IFlySpeechConstant.type_CLOUD(), forKey: IFlySpeechConstant.engine_TYPE())
        iFlySpeechSynthesizer.setParameter("50", forKey: IFlySpeechConstant.speed())
        iFlySpeechSynthesizer.setParameter("50", forKey: IFlySpeechConstant.volume())
        iFlySpeechSynthesizer.setParameter("vinn", forKey: IFlySpeechConstant.voice_NAME())
        iFlySpeechSynthesizer.setParameter("8000", forKey: IFlySpeechConstant.sample_RATE())
        iFlySpeechSynthesizer.setParameter("30000", forKey: IFlySpeechConstant.net_TIMEOUT())
        iFlySpeechSynthesizer.setParameter("tts.pcm", forKey: IFlySpeechConstant.tts_AUDIO_PATH())

    }
    
    //MARK: - IFlySpeechRecognizerDelegate
    //初始化语音识别器
    func initRecognizer(){
        
        iFlySpeechRecognizer = IFlySpeechRecognizer.init()
        iFlySpeechRecognizer.setParameter("", forKey: IFlySpeechConstant.params())
        iFlySpeechRecognizer.setParameter("iat", forKey: IFlySpeechConstant.ifly_DOMAIN())
        iFlySpeechRecognizer.setParameter("100000", forKey: IFlySpeechConstant.speech_TIMEOUT())
        iFlySpeechRecognizer.setParameter("1800", forKey: IFlySpeechConstant.vad_EOS())
        iFlySpeechRecognizer.setParameter("1800", forKey: IFlySpeechConstant.vad_BOS())
        iFlySpeechRecognizer.setParameter("20000", forKey: IFlySpeechConstant.net_TIMEOUT())
        iFlySpeechRecognizer.setParameter("16000", forKey: IFlySpeechConstant.sample_RATE())
        iFlySpeechRecognizer.setParameter("zh_cn", forKey: IFlySpeechConstant.language())
        iFlySpeechRecognizer.setParameter("mandarin", forKey: IFlySpeechConstant.accent())
        iFlySpeechRecognizer.setParameter("1", forKey: IFlySpeechConstant.asr_PTT())
        iFlySpeechRecognizer.setParameter("plain", forKey: IFlySpeechConstant.result_TYPE())
        iFlySpeechRecognizer.delegate = self
    }
    
    // 出现错误
    func onError(_ errorCode: IFlySpeechError!) {
        
    }
    
    func onCompleted(_ error: IFlySpeechError!) {
        
    }
    
    func onSpeakBegin() {
        
    }
    
    func onBufferProgress(_ progress: Int32, message msg: String!) {
        
    }
    
    // 识别结果
    func onResults(_ results: [Any]!, isLast: Bool) {
        let onTopic = "talk heimu"
        let resultString: NSMutableString = ""
        if results != nil {
            let dict = results[0] as! NSDictionary
            for (key,_) in dict {
                resultString.append("\(key)")
            }
            
            var resultStr:String! = resultString as String
            resultStr = resultStr.replacingOccurrences(of: "。", with: "")
            resultStr = resultStr.replacingOccurrences(of: "？", with: "")
            resultStr = resultStr.replacingOccurrences(of: "！", with: "")
            
            if resultStr != "" {
                
                let dic = ["text":resultStr,"location":["building":lightControllerView.buildingLabel.text!,"room":lightControllerView.roomTextField.text!]] as [String : Any]
                
                let data = try! JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
                
                mySession.publishData(data, onTopic: onTopic, retain: false, qos: .atMostOnce)
                msgData.append(["name":"my","value":resultStr])
                homeTableView?.insertRows(at: [NSIndexPath.init(row: (homeTableView?.numberOfRows(inSection: 0))!, section: 0) as IndexPath as IndexPath], with: .bottom)
                homeTableView?.scrollToRow(at:NSIndexPath.init(row: (homeTableView?.numberOfRows(inSection: 0))!-1, section: 0) as IndexPath, at: .bottom, animated: true)
                topbarNotification?.topNotiLabel.text = "识别成功:" + resultStr
                
            }
        }
    }
    
    // MARK: - 离开界面关闭MQTT
    
    override func viewDidDisappear(_ animated: Bool) {
        
        mySession.removeObserver(self, forKeyPath: "status")
        mySession.close()
        timer?.cancel()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
