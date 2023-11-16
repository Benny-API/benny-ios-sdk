# Benny SDK 
The Benny SDK is used to embed Benny supported flows within your native iOS app. Using these embedded flows, end users will be able to be able to use our products such as Benny Apply.

>Note: Complete documentation at [docs.bennyapi.com](bennyapi.com).


## Installation 

### Swift Package Manager
Install by adding our github as a package dependency to your app. 

## Flow Usage 
### Benny Apply Flow
To use the Benny Apply Flow, you'll need an organization id. For each user session, you'll also need a unique external id to identify the end user.

>**NOTE:** If you do not have an organization id, please reach out to the help@bennyapi.com to setup your oganization. 

#### Integration 
The Benny Apply flow is accessed through a simple UIViewController, or UIViewControllerRepresentable if needed.
 
```swift
import BennySDK

let controller = BennyApplyViewController(parameters: bennyApplyParams, delegate: listener)
```

#### Listening for Events
The BennyApplyListenerDelegate is responsible for communicating to your native app when the  user wants to end the current session or request a data exchange. The delegate must comform to the following protocol:

```swift
public protocol BennyApplyListenerDelegate {
    func onExit()
    func onDataExchange(applicantDataId: String)
}
```

## Author
[Benny API Inc.](bennyapi.com)

## License 
The Benny iOS SDK is available under the MIT license.
