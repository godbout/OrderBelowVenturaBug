import AppKit
import SwiftUI


class AppDelegate: NSObject, NSApplicationDelegate {
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let options: NSDictionary = [kAXTrustedCheckOptionPrompt.takeRetainedValue() as NSString: true]
        
        AXIsProcessTrustedWithOptions(options)
    } 
    
}
