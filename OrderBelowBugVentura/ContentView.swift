import SwiftUI


struct ContentView: View {

    let window: NSWindow
    private static var timer: Timer?
    
    var body: some View {
        VStack {
            Button("place a window below the frontmost one") {
                Self.timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
                    guard let number = frontmostWindowNumber() else { return }
                    
                    window.setFrame(NSScreen.main!.frame, display: true)
                    window.backgroundColor = .black
                    window.alphaValue = 0.9
                    
                    window.order(.below, relativeTo: number)
                }
            }
            Button("hide the window") {
                window.alphaValue = 0
            }
        }
        .frame(width: 388, height: 288)
    }
    
    
    private func frontmostWindowNumber() -> Int? {
        guard let pid = NSWorkspace.shared.frontmostApplication?.processIdentifier else { return nil }
        guard let pidFromAX = axFrontmostApplicationPID() else { return nil }
        
        print("pid from NSWorkspace: \(pid) — pid from AX: \(pidFromAX)")
        
        guard let tooManyWindows = CGWindowListCopyWindowInfo([.optionOnScreenOnly, .excludeDesktopElements], kCGNullWindowID) as NSArray? else { return nil }
        guard let focusedWindow = tooManyWindows.filtered(using: NSPredicate(format: "kCGWindowOwnerPID = \(pid) && kCGWindowLayer != 25")).first as? NSDictionary else { return nil }
        guard let number = focusedWindow.value(forKey: "kCGWindowNumber") as? Int else { return nil }
        
        print("window number")
                
        return number
    }
        
    private func axFrontmostApplicationPID() -> pid_t? {
        let axSystemWideElement = AXUIElementCreateSystemWide()
        
        var axApplication: AnyObject?
        guard AXUIElementCopyAttributeValue(axSystemWideElement, kAXFocusedApplicationAttribute as CFString, &axApplication) == .success else { return nil }

        var pid: pid_t = -1
        AXUIElementGetPid(axApplication as! AXUIElement, &pid)
        
        return pid == -1 ? nil : pid
    }
        
}
