import Cocoa
import GTMAppAuth

fileprivate let clientId = "982483247841-sn6f1vpnsc6qu3s071ntqp287nh5q48k.apps.googleusercontent.com"
fileprivate let clientSecret = "UpiwF4s9s44hJyTDoD7CN-KS"
fileprivate let redirectURL = URL(string: "http://localhost:8080")!

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    @IBOutlet var window: NSWindow!
    
    private var eventManager: NSAppleEventManager!
    private var authFlow: OIDAuthorizationFlowSession!
    private var authorization: GTMAppAuthFetcherAuthorization?
    
    func applicationWillFinishLaunching(_ notification: Notification) {
        eventManager = NSAppleEventManager.shared()
    }
    
    func applicationDidFinishLaunching(_: Notification) {
        setupEventHandlers()
        setupAuth()
    }

    func applicationWillTerminate(_: Notification) {
        // Insert code here to tear down your application
    }
    
    func application(_ application: NSApplication, open urls: [URL]) {
        if authFlow.resumeAuthorizationFlow(with: urls[0]) {
            authFlow = nil
        }
    }
    
    private func setupAuth() {
        let configuration = GTMAppAuthFetcherAuthorization.configurationForGoogle()
        let request = OIDAuthorizationRequest(
            configuration: configuration,
            clientId: clientId,
            clientSecret: clientSecret,
            scopes: [OIDScopeOpenID, OIDScopeProfile],
            redirectURL: redirectURL,
            responseType: OIDResponseTypeCode,
            additionalParameters: nil
        )
        authFlow = OIDAuthState.authState(byPresenting: request, callback: { (state, error) in
            switch (state, error) {
            case (_, .some(let error)):
                print(error)
                self.authorization = nil
            case (.some(let state), _):
                self.authorization = .init(authState: state)
            default:
                break
            }
        })
    }
    
    private func setupEventHandlers() {
        eventManager.setEventHandler(
            self,
            andSelector: #selector(handleInternetEvent(with:and:)),
            forEventClass: AEEventClass(kInternetEventClass),
            andEventID: AEEventID(kAEGetURL)
        )
        eventManager.setEventHandler(
            self,
            andSelector: #selector(handleCoreEvent(with:and:)),
            forEventClass: AEEventClass(kCoreEventClass),
            andEventID: AEEventID(kAEReopenApplication)
        )
    }
    
    @objc
    private func handleInternetEvent(with event: NSAppleEventDescriptor, and replyEvent: NSAppleEventDescriptor) {
        guard
            let urlString = event.paramDescriptor(forKeyword: keyDirectObject)?.stringValue,
            let url = URL(string: urlString)
        else { return }
        authFlow.resumeAuthorizationFlow(with: url)
    }
    
    @objc
    private func handleCoreEvent(with event: NSAppleEventDescriptor, and replyEvent: NSAppleEventDescriptor) {
        
    }
}
