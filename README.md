# Benny SDK 
The Benny SDK is used to embed Benny supported flows within your native iOS app. Using these embedded flows, end users will be able to be able to use our products such as Ebt Balance.

>Note: Complete documentation at [docs.bennyapi.com](bennyapi.com).


## Installation 

### Swift Package Manager
Install by adding our github as a package dependency to your app. 

## Flow Usage 
### Ebt Balance Flow
To use the Ebt Balance Flow, you'll need an organization id. For each user session, you'll also need a unique external id to identify the end user.

>**NOTE:** If you do not have an organization id, please reach out to the help@bennyapi.com to setup your oganization. 

#### Integration 
The Ebt Balance flow is accessed through a simple UIViewController, or UIViewControllerRepresentable if needed.
 
```swift
import BennySDK

let controller = EbtBalanceViewController(parameters: ebtBalanceParams, delegate: listener)
```

#### Listening for Events
The EbtBalanceListenerDelegate is responsible for communicating to your native app when the  user wants to end the current session or request a data exchange. The delegate must comform to the following protocol:

```swift
public protocol EbtBalanceListenerDelegate {
    func onExit()
    func onLinkSuccess(linkToken: String)
}
```

## Author
[Benny API Inc.](bennyapi.com)

## License 
The Benny iOS SDK is available under the MIT license.
