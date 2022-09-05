import UIKit
import Flutter
#import GoogleMaps
#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    [GMSServices provideAPIKey:@"AIzaSyBci-Qf9f5w-fEoqyXoWBl5ZkhSncZw12A"];
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
