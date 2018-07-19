# zesty-ios-swift-application-basic-example
---
## What is this?
This is a example project that uses the [ZestySwiftContentEndpointWrapper](https://github.com/zesty-io/ZestySwiftContentEndpointWrapper). It is intended to assist you in building your own app through its usage of the wrapper. It's based off of the example [ZestyBurger](http://burger.zesty.site) website. 

## How can I try it out?
We recommend [forking](https://github.com/zesty-ios-swift-application-basic-example/fork) the project, or simply downloading /  cloning the repo and running it in Xcode. You'll have to login with your apple id to get the app on your device.

## How can I use the ZestySwiftContentEndpointWrapper in my own project?
We support [Cocoapods!](https://cocoapods.org). Simply add us to your `Podfile`. If you've never used Cocoapods before, we recommend [this guide](https://guides.cocoapods.org/using/using-cocoapods)

### Example `Podfile`

    source 'https://github.com/CocoaPods/Specs.git'
    platform :ios, '10.0' # or higher
    use_frameworks!

    target 'YourProject' do

        use_frameworks!

        pod 'ZestySwiftContentEndpointWrapper'
        pod 'SwiftyJSON', '~> 4.0' # if you want to use custom endpoints in addition to the basic endpoints

        target 'YourProjectTests' do
            inherit! :search_paths
            # Pods for testing
        end

        target 'YourProjectUITests' do
            inherit! :search_paths
            # Pods for testing
        end

    end

## Is there documentation for the Cocoapod?
Yes! Check out [the Github Repository](https://github.com/zesty-io/ZestySwiftContentEndpointWrapper)! Additionally, the wrapper is documented using SwiftDocs, so you can see the documentation inside Xcode using QuickHelp.



---


Written by [@ronakdev](https://github.ronakshah.net)
