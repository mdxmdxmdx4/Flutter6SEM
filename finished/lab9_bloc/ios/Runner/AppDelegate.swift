import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let batteryChannel = FlutterMethodChannel(name: "samples.flutter.dev/battery",
                                              binaryMessenger: controller.binaryMessenger)
    batteryChannel.setMethodCallHandler({
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      // Handle battery methods
      if call.method == "getBatteryLevel" {
        self.receiveBatteryLevel(result: result)
      } else {
        result(FlutterMethodNotImplemented)
      }
    })

    let phoneDialerChannel = FlutterMethodChannel(name: "samples.flutter.dev/phone_dialer",
                                                  binaryMessenger: controller.binaryMessenger)
    phoneDialerChannel.setMethodCallHandler({
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      // Handle phone dialer methods
      if call.method == "dialPhoneNumber" {
        if let args = call.arguments as? [String: Any],
           let phoneNumber = args["phoneNumber"] as? String {
          self.dialPhoneNumber(phoneNumber: phoneNumber, result: result)
        } else {
          result(FlutterError(code: "INVALID_ARGUMENTS",
                              message: "Invalid arguments for 'dialPhoneNumber'",
                              details: nil))
        }
      } else {
        result(FlutterMethodNotImplemented)
      }
    })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func receiveBatteryLevel(result: FlutterResult) {
    let device = UIDevice.current
    device.isBatteryMonitoringEnabled = true
    if device.batteryState == UIDevice.BatteryState.unknown {
      result(FlutterError(code: "UNAVAILABLE",
                          message: "Battery info unavailable",
                          details: nil))
    } else {
      result(Int(device.batteryLevel * 100))
    }
  }

  private func dialPhoneNumber(phoneNumber: String, result: FlutterResult) {
    if let url = URL(string: "tel://\(phoneNumber)"),
       UIApplication.shared.canOpenURL(url) {
      if #available(iOS 10, *) {
        UIApplication.shared.open(url)
      } else {
        UIApplication.shared.openURL(url)
      }
      result(nil)
    } else {
      result(FlutterError(code: "UNAVAILABLE",
                          message: "Could not dial phone number",
                          details: nil))
    }
  }
}
