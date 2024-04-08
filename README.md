# Benny iOS SDK 
The Benny iOS SDK allows your iOS app to use Benny client libraries.

> **Note**
> See our complete documentation at [docs.bennyapi.com](https://docs.bennyapi.com).

## Installation 

The Benny iOS SDK is available via [Swift Package Manager](https://www.swift.org/documentation/package-manager/).

### Swift Package Manager
Install by adding https://github.com/Benny-API/benny-ios-sdk as a dependency to your app. 

## EBT Balance Link Flow

The Ebt Balance Link Flow allows users to link their EBT account, verifying the account, and
returning a tokenized representation of the credentials for fetching balance and transaction
information.

### Required IDs
You'll need an `organizationId`, the ID representing your organization, along with
a `temporarylink` that is generated serverside via a call to the Benny API.

> **Note**
> Reach out to [help@bennyapi.com](help@bennyapi.com) to set up your organization.

### Integration 
The Ebt Balance flow is accessed through a simple `UIViewController`, or `UIViewControllerRepresentable` if needed. Make sure to import
the `BennySDK`.
 
```swift
let controller = EbtBalanceViewControllerRepresentable(
    parameters: EbtBalanceParameters(
        organizationId: "org_wup29bz683g8habsxvazvyz1",
        environment: Environment.SANDBOX,
        temporaryLink: "temp_clr0vujq9000108l66odc7fxv"
    ), 
    delegate: listener)
```
### Starting the Flow

To start the EBT Balance flow, present the view controller or representable. 
See the [Benny Sample App](https://github.com/Benny-API/benny-ios-sdk/blob/main/benny-sample-app/bennysampleapp/ContentView.swift) as an example integration.

### Listening for Flow Events
The `EbtBalanceListenerDelegate` is responsible for communicating to your iOS app when the user wants to exit the flow and when a link is successful.

```swift
public protocol EbtBalanceListenerDelegate {
    func onExit()
    func onLinkSuccess(linkToken: String)
}
```

### Environments 
Set the environment to Environment.SANDBOX in your EbtBalanceParameters to integrate with the Benny sandbox environment, or omit to default to the production environment.

## Author
[Benny API Inc.](bennyapi.com)

## License 
The Benny iOS SDK is available under the MIT license.
