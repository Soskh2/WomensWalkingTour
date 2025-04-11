import Flutter
import UIKit
import GoogleMaps
import "package:tour/static/keys.dart";


@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    GMSServices.provideAPIKey(Keys.googleMaps)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
