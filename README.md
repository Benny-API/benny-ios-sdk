# Benny iOS SDK 
The Benny iOS SDK allows your iOS app to use Benny client libraries.

> **Note**
> See our complete documentation at [docs.bennyapi.com](https://docs.bennyapi.com).

### Installation 
#### Swift Package Manager
Install by adding the GitHub package as a dependency to your app. 

## Usage 

### EBT Balance Link Flow

The Ebt Balance Link Flow allows users to link their EBT account, verifying the account, and
returning a tokenized representation of the credentials for fetching balance and transaction
information.

#### Required IDs
You'll need an `organizationId`, the ID representing your organization, along with
a `temporarylink` that is generated serverside via a call to the Benny API.

> **Note**
> Reach out to [help@bennyapi.com](help@bennyapi.com) to set up your organization.

#### Integration 
The Ebt Balance flow is accessed through a simple `UIViewController`, or `UIViewControllerRepresentable` if needed.
 
```swift
import BennySDK

let controller = EbtBalanceViewController(parameters: ebtBalanceParams, delegate: listener)
```

#### Listening for Flow Events
The `EbtBalanceListenerDelegate` is responsible for communicating to your iOS app when the user wants to exit the flow and when a link is successful.

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
