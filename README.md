# Benny iOS SDK 
The Benny iOS SDK allows your iOS app to use Benny client libraries.

> **Note**
> See our complete documentation at [docs.bennyapi.com](https://docs.bennyapi.com).

## Installation 

The Benny iOS SDK is available via [Swift Package Manager](https://www.swift.org/documentation/package-manager/).

### Swift Package Manager
Install by adding https://github.com/Benny-API/benny-ios-sdk as a dependency to your app. 

## EBT Balance Link Flow

The Ebt Balance Link Flow allows users to link their EBT account, verify the account, and
returning a tokenized representation of the credentials for fetching balance and transaction information.

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
    func onLinkResult(result: LinkResult)
}
```

## EBT Transfer 

The EBT Transfer product consists of `EbtTransferLinkCardFlow`, `EbtTransferBalanceFlow`, and the `EbtTransferFlow`. Once a user successfully links their EBT card through the `EbtTransferLinkCardFlow`, a transfer token is created. The transfer token allows for EBT balance checks through the `EbtTransferBalanceFlow` and EBT cash transfers through the `EbtTransferBalanceFlow`.

### Link Card Flow 
The `EbtTransferLinkCardFlow` is initialized with an organization ID and a single-use temporary link generated serverside via a call to Benny's API.

Callbacks (i.e., `onExit` and `onLinkResult`) are responsible for communicating to your app when the user wants to exit the flow and when a link result is obtained. A
successful link result returns a transfer token along with its expiration date. A failed link result returns an error message. 

```swift
EbtTransferLinkCardFlow(parameters:
    EbtTransferLinkCardParameters(
        organizationId: "org_l3i8e62a1ir45xwl2val3enz",
        temporaryLink: "link_e4oh6juqpjqzor2e5kg38r13" ,
        environment: Environment.SANDBOX,
    ),
    onExit: { /* Your on exit logic */ },
    onLinkResult: { /* Your on link result logic */ }
)
```

### Balance Flow 
The `EbtTransferBalanceFlow` is initialized with an organization ID and the transfer token obtained earlier.

Callbacks (i.e., `onExit` and `onResult`) are responsible for communicating to your app when the user wants to
exit the flow and when a result is obtained. A successful result returns the customer's cents-denominated EBT cash balance, while a failed link result returns an error message.

```swift
EbtTransferBalanceFlow(parameters:
    EbtTransferBalanceParameters(
        organizationId: "org_l3i8e62a1ir45xwl2val3enz",
        transferToken: "link_e4oh6juqpjqzor2e5kg38r13" ,
        environment: Environment.SANDBOX,
    ),
    onExit: { /* Your on exit logic */ },
    onResult: { /* Your on result logic */ }
)
```

### Transfer Flow
The `EbtTransferFlow` is initialized with an organization ID, the transfer token obtained earlier, a cents-denominated amount that the customer wishes to transfer, and an idempotency key.

Callbacks (i.e., `onExit` and `onResult`) are responsible for communicating to your app when the user wants to exit the flow and when a transfer result is obtained. 
A successful result invokes the `onResult` callback with no value, while a failed result returns an error message.

```swift
EbtTransferFlow(parameters:
    EbtTransferParameters(
        organizationId: "org_l3i8e62a1ir45xwl2val3enz",
        transferToken: "link_e4oh6juqpjqzor2e5kg38r13" ,
        idempotencyKey: "idempotent",
        amount: 200,
        environment: Environment.SANDBOX
    ),
    onExit: { /* Your on exit logic */ },
    onResult: { /* Your on result logic */ }
)
```

### Environments 
Set the environment to `Environment.SANDBOX` in your EbtBalanceParameters to integrate with the Benny sandbox environment or omit to default to the production environment.

## Author
[Benny API Inc.](bennyapi.com)

## License 
The Benny iOS SDK is available under the MIT license.
