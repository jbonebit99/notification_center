import Flutter
import UIKit
import os

public class SwiftNotificationCenterPlugin: NSObject, FlutterPlugin {
    
    let _methodRegisterNotificationCenter = "registerNotificationCenter"
    let _methodSendNotification = "sendNotification"
    let _methodReceiveNotification = "receiveNotification"
    let _methodRemoveNotification = "removeNotification"
    let _nameNotificationCenter = NSNotification.Name("com.cgb.regfaceios.center")
    private var channel:FlutterMethodChannel
    private static var instance: SwiftNotificationCenterPlugin?
    var result : FlutterResult?
    var documentInteractionController: UIDocumentInteractionController?
    
    init(_ channel: FlutterMethodChannel) {
        self.channel = channel
        super.init()
        SwiftNotificationCenterPlugin.instance = self
    }
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "notification_center", binaryMessenger: registrar.messenger())
        let instance = SwiftNotificationCenterPlugin(channel)
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        self.result = result
        switch call.method {
        case _methodRegisterNotificationCenter:
            registerNotificationCenter(result: result)
        case _methodSendNotification:
            guard let args = call.arguments as? [AnyHashable:Any] else {return}
            sendNotificationCenter(data: args, result: result)
        case _methodRemoveNotification:
            registerNotificationCenter(result: result)
        default:
            result("iOS " + UIDevice.current.systemVersion)
        }
        
        
    }
    
    func registerNotificationCenter(result: @escaping FlutterResult	) {
        NotificationCenter.default.addObserver(self, selector: #selector(receiveNotification(_:)), name: _nameNotificationCenter, object: nil)
        print("100 chai bia")
        result("Register success")
    }
    
    @objc func receiveNotification(_ notification: Notification){
        print("reciver message")
        let data: [AnyHashable:Any] = notification.userInfo!
        channel.invokeMethod("receiverNotification", arguments: data)
    }
    
    func sendNotificationCenter(data:[AnyHashable:Any], result: FlutterResult){
        NotificationCenter.default.post(name: _nameNotificationCenter, object: nil, userInfo: data)
        result(data)
    }
    
    func removeNotification (result: FlutterResult){
        NotificationCenter.default.removeObserver(self, name: _nameNotificationCenter, object: nil)
        result("Success")
        
    }
    
    
}
