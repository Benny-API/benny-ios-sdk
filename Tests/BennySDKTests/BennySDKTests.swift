import XCTest
@testable import BennySDK

final class BennySDKTests: XCTestCase {
    var viewModel: BaseWebViewVM!
    var mockWebView: MockWKWebView!

    override func setUp() {
        super.setUp()
        mockWebView = MockWKWebView()
        viewModel = BaseWebViewVM()
        viewModel.webView = mockWebView
    }

    override func tearDown() {
        viewModel = nil
        mockWebView = nil
        super.tearDown()
    }

    func testLoadWebPageWithValidURL() {
        let validURL = "https://www.example.com"
        viewModel.webResource = validURL
        viewModel.loadWebPage()

        XCTAssertNotNil(mockWebView.lastLoadedRequest)
        XCTAssertEqual(mockWebView.lastLoadedRequest?.url, URL(string: validURL))
    }
}
