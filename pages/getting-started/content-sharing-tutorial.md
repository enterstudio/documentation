---
type: recipe
directory: getting-started
title: Content Sharing Tutorial
page_title: Content Sharing Tutorial
description: Learn how to create Branch Links and share content with your friends directly from your app!
keywords: Contextual Deep Linking, Deep links, Deeplinks, Deep Linking, Deeplinking, Deferred Deep Linking, Deferred Deeplinking, Google App Indexing, Google App Invites, Apple Universal Links, Apple Spotlight Search, Facebook App Links, AppLinks, Deepviews, Deep views, Link Properties, Redirect Customization, Mobile SDK, Web SDK, HTTP API
hide_section_selector: true
hide_platform_selector: true
platforms:
- ios
sections:
- guide
content: list
---

Welcome to the Branch Content Sharing Tutorial! Today you will be learning how to share deep linked content with your friends by simply pressing a button inside your app and generating a link with the Branch SDK.

This tutorial assumes that you have created your own project in Xcode or are using the Branch sample project ([click here](https://github.com/BranchMetrics/cat-facts/archive/template.zip) to download it!). Before you start, please make sure that you have [signed up](https://dashboard.branch.io/login) for a Branch user account, are logged in, and are in [dashboard.branch.io](https://dashboard.branch.io) in your browser.

The tutorial is broken up into six parts: integrating the Branch SDK, setting up your app in the Apple Developer Portal, setting up Universal Links, creating deep links, allowing for deep link routing, and testing your app. Let’s get started!

## Integrating Branch SDK

1. Click [here](https://s3-us-west-1.amazonaws.com/branchhost/Branch-iOS-SDK.zip) to download the latest version of the SDK
2. Unzip the SDK
3. Drag and drop the unzipped “Branch-iOS-SDK” folder into your project folder inside the Xcode navigator (the following image highlights the **project _folder_**)
{% image src="/img/pages/getting-started/content-sharing-tutorial/screenshots/project_folder.png" center third %}
{% image src="/img/pages/getting-started/content-sharing-tutorial/tutorial-videos/sdk-into-folder.gif" center half %}
4. A window will pop up once the folder has been placed inside the project. Be sure that  “Copy items if needed” and “Create groups” are selected and click "Finish"
{% image src="/img/pages/getting-started/content-sharing-tutorial/screenshots/framework_pop_up.png" center 2-thirds %}
5. Select the project file in your project navigator (the following image highlights the **project _file_**)
{% image src="/img/pages/getting-started/content-sharing-tutorial/screenshots/project_file.png" center third %}
6. Select the "Build Phases" tab once inside the **project _file_**
{% image src="/img/pages/getting-started/content-sharing-tutorial/screenshots/build_phases_tab.png" center third %}
7. Open the "Link Binary with Libraries" section and import the following frameworks by clicking the `+` button:

> * AdSupport.framework
* CoreTelephony.framework
* CoreSpotlight.framework
* MobileCoreServices.framework
* SafariServices.framework

{% image src="/img/pages/getting-started/content-sharing-tutorial/tutorial-videos/add-frameworks.gif" center actual %}

### Add your Branch Key

*The Branch Key is a unique value which helps identify the data being sent and received in your app*

1. Create a new app by selecting “Create new app” from the drop down menu in the top right corner of the [Branch Dashboard](https://dashboard.branch.io) 
{% image src="/img/pages/getting-started/content-sharing-tutorial/tutorial-videos/create-new-app-dashboard.gif" center actual %}
2. Next to the drop down menu, make sure that the “Live” button is highlighted blue- meaning that it is selected
{% image src="/img/pages/getting-started/content-sharing-tutorial/tutorial-videos/test-to-live.gif" center 2-thirds %}
3. Go to the [Settings](https://dashboard.branch.io/settings) page in the Branch dashboard
4. Make sure the “General” tab is selected
5. Copy your Branch Key
{% image src="/img/pages/getting-started/content-sharing-tutorial/screenshots/branch_key.png" center 3-quarters %}
6. In Xcode, open your project’s **info.plist** file from the project navigator
{% image src="/img/pages/getting-started/content-sharing-tutorial/screenshots/info_plist.png" center half %}
7. Mouse hover over “Information Property List” until a `+` appears to the right. Click it.
8. A new row will have been added under “Information Property List.” 
9. Edit the new row so that the key is "branch_key" and the value is the Branch Key that you copied in *step 5*:

| Key | Type | Value |
| :--- | --- | --- |
| branch_key | String | [your Branch key] |

{% image src="/img/pages/getting-started/content-sharing-tutorial/tutorial-videos/add-branch-key.gif" center 3-quarters %}

### Register a URI Scheme

*A URI (Uniform Resource Identifier) Scheme is similar to the typical URL that you enter into your browser on a daily basis. It identifies the content of your app and places it under a single location that will be available to others*

1. In Xcode, select your **project _file_** in the navigator
2. Select the "General" tab
3. In the "Identity" section, copy your "Bundle Identifier"
4. Select the “Info” tab
5. Expand the “URL Types” section at the bottom
6. Click the `+` button
{% image src="/img/pages/getting-started/content-sharing-tutorial/tutorial-videos/add-uri-scheme.gif" center 3-quarters %}
7. In the “Identifier” text field, input the “Bundle Identifier” you copied in *step 3*
8. In the "URI Schemes" text field, input a URI scheme of your choice

{% image src="/img/pages/getting-started/content-sharing-tutorial/screenshots/general_identifier.png" center 3-quarters %}

{% image src="/img/pages/getting-started/content-sharing-tutorial/screenshots/info_identifier.png" center 3-quarters %}

  > * The URI Scheme must follow the format: `urischemename://`
  >
  > If my app name is Cat Facts, my URI Scheme could be: `cat-facts://`

### Set URI in Dashboard

6. Go to [Link Settings](https://dashboard.branch.io/settings/link)
7. Make sure that the checkbox for "I have an iOS App" is selected
8. Fill out “iOS URI Scheme” with the same URI that you came up with in the previous section
9. Select **Custom URL** and type in your website's URL or `https://branch.io` if you don't have one
{% image src="/img/pages/getting-started/content-sharing-tutorial/screenshots/dashboard_custom_url.png" center actual %}
10. Scroll to the bottom of the page and click "Save"

### Support Strong Matching

*Strong Matching is a Branch feature that allows Branch to recognize indiviudals that it has interacted with before and providing relevant information- creating a more streamlined and personal experience*

1. In the Branch Dashboard, go to [Link Settings](https://dashboard.branch.io/settings/link)
2. Under **Custom Link Domain**, copy your **Default domain name** (if you have a Custom Link Domain then select that instead)
{% image src="/img/pages/getting-started/content-sharing-tutorial/screenshots/settings_custom_link_domain.png" center 3-quarters %}
3. In Xcode, open your project’s **info.plist** file
4. Mouse hover over “Information Property List” until a `+` appears to the right. Click it.
5. A new row will have been added under “Information Property List”
6. Edit the new row to show:

  | Key | Type | Value |
  | :--- | --- | --- |
  | branch_app_domain | String | [your default/custom domain name] |

  {% image src="/img/pages/getting-started/content-sharing-tutorial/tutorial-videos/add-branch-app-domain.gif" center 3-quarters %}

### Add a Bridging Header

*Bridging headers allow the Branch framework, which is written in Objective-C, to be integrated into your Swift code*

1. In Xcode, select your **project _folder_**
2. Add a new file to your **project _folder_** (*Select project folder* -> File -> New -> File..)
3. Choose “Header File” and click “Next”
4. Name the new header file. For example, if my project name is “Cat Facts” then the file should be saved as “Cat-Facts-Bridging-Header”
5. Before clicking “Create”, make sure that your app is selected in Targets
{% image src="/img/pages/getting-started/content-sharing-tutorial/screenshots/bridging_header_targets.png" center half %}
6. Once the file has been created, open it up
7. Delete all the text in the file and type in (do not copy and paste): `#import "Branch.h"`
{% image src="/img/pages/getting-started/content-sharing-tutorial/tutorial-videos/add-bridging-header.gif" center 3-quarters %}
8. Open your **project _file_** and navigate to *Build Settings*
10. In the top left corner, make sure that "All" is highlighted and not "Basic"
  {% image src="/img/pages/getting-started/content-sharing-tutorial/screenshots/all-basic.png" center quarter %}
11. Like in the screenshot below, search for “bridging header." 
  {% image src="/img/pages/getting-started/content-sharing-tutorial/tutorial-videos/add-bridging-header-build-settings.gif" center 3-quarters %}
12. Edit “Objective-C Bridging Header” so that its Tutorial Helper column reads: YourAppName/Your-Bridging-Header.h (this will let Xcode know where to look for the bridging header)
  {% example %}
   `Cat Facts/Cat-Facts-Bridging-Header.h`
  {% endexample %}

### Start a Branch Session

1. In Xcode, open the **AppDelegate.swift** file
2. Directly underneath the line that reads: `import UIKit`, copy and paste `import Branch`

### Handle incoming links

Copy and paste the following code into **AppDelegate.swift** right before the very last `}` :

{% highlight swift %}
// Respond to URI scheme links
func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
    // pass the url to the handle deep link call
    Branch.getInstance().handleDeepLink(url);

    // do other deep link routing for the Facebook SDK, Pinterest SDK, etc
    return true
}

// Respond to Universal Links
func application(application: UIApplication, continueUserActivity userActivity: NSUserActivity, restorationHandler: ([AnyObject]?) -> Void) -> Bool {
    // pass the url to the handle deep link call

    return Branch.getInstance().continueUserActivity(userActivity)
}
{% endhighlight %}

{% image src="/img/pages/getting-started/content-sharing-tutorial/tutorial-videos/handle-incoming-sessions.gif" center 3-quarters %}

## Access Apple Developer Account

### Get your Team ID

1. Select “Certificates, Identifiers, and Profiles” in the [Apple Developer Portal](http://developer.apple.com/account)
{% image src="/img/pages/getting-started/content-sharing-tutorial/screenshots/apple_developer_homepage.png" center third %}
2. In the top right corner of the page, click your name and select “View Account”
{% image src="/img/pages/getting-started/content-sharing-tutorial/screenshots/apple_view_account.png" center third %}
3. Copy your “Team ID” from the Membership Information section
{% image src="/img/pages/getting-started/content-sharing-tutorial/screenshots/team_id.png" center half %}

## Set up Universal Links

### Enable Universal Links on the Dashboard

1. In the Dashboard, navigate to [Link Settings](https://dashboard.branch.io/#/settings/link)
2. Check the box that says **Enable Universal Links** in the “iOS redirects” section
3. In the Apple App Prefix box, type in your Team ID (same one that you copied in *step 3* of the previous section)
{% image src="/img/pages/getting-started/content-sharing-tutorial/screenshots/apple_app_prefix_in_dashboard.png" center 3-quarters %}
4. Type in your Bundle Identifier from Xcode (**Project _file_** -> General)
5. Scroll to the bottom and Save

### Add the Associated Domains entitlement to your project

*Associated Domains create the connection between the* `app.link` *address and your app*

1. Go to the “Capabilities” tab of your **project _file_**
2. Scroll down and in the “Associated Domains” section flip the switch in the right hand side from “Off” to “On”- enabling Associated Domains
{% image src="/img/pages/getting-started/content-sharing-tutorial/screenshots/associated_domains_ON.png" center actual %}
  * A message may pop up asking you to select a “Development Team to use for provisioning”. Choose the name associated with your Apple Developer Account
3. Go to the [Link Settings](https://dashboard.branch.io/#/settings/link) tab in the Branch Dashboard
4. Locate the “Default domain name” box from the “Custom Link Domain” area
5. In the “Domains” section of “Associated Domains” in Xcode click the `+` and add the following entries:

	> * `applinks:xxxx.app.link` (ex. if your default domain name is `abcd.app.link`, then type in `applinks:abcd.app.link`)
	> * `applinks:xxxx-alternate.app.link` (ex. if your default domain name is `abcd.app.link`, then type in `applinks:abcd-alternate.app.link`)

{% image src="/img/pages/getting-started/content-sharing-tutorial/screenshots/associated_domains_capabilites.png" center actual %}
6. Select your [projectname].entitlements file in the Xcode navigator
{% image src="/img/pages/getting-started/content-sharing-tutorial/screenshots/entitlements_folder.png" center third %}
7. Open the right hand sidebar
{% image src="/img/pages/getting-started/content-sharing-tutorial/screenshots/right_hand_sidebar.png" center third %}
8. Ensure that the correct build target (your project name) is checked off in the right hand sidebar
{% image src="/img/pages/getting-started/content-sharing-tutorial/screenshots/entitlements_target.png" center third %}


## Creating Links

### Create a Share Button

*A button will be added to the interface of the app so that when it is clicked, it will provide the ability to share your deep link*

1. Select the **Main.storyboard** file
5. Open the assistant editor by clicking the the two rings in the top right corner of Xcode
{% image src="/img/pages/getting-started/content-sharing-tutorial/screenshots/assistant_editor_button.png" center third %}
6. Control-click and hold the UIButton you created
7. While still holding down the mouse and clicking "control", drag and drop the button (a connecting line will appear) into the associated view controller file in the assistant editor window. Watch the video below to see an example
{% image src="/img/pages/getting-started/content-sharing-tutorial/tutorial-videos/adding-share-button-to-class.gif" center 3-quarters %}
8. A characteristics box will pop up for the UIButton that you just added to the class file
9. Make sure that the Connection type of the button is “Action” when adding it to the class file and the type is "UIButton." You can name it whatever you like.

### Import the Branch Framework

If it isn't already there, copy and paste the following code at the top of the view controller file where you plan to create and share links from (the same view controller where the button was added): `import Branch`

### Create a Branch Universal Object

*A Branch Universal Object contains specific data that is created by the user. When a Branch Link is opened, it is retrieving the data from the Universal Object that it refers to*

1. Look for the line of code that starts with: `@IBAction func [yourbuttonname] (sender: AnyObject) {`
2. In the function body (after the first `{` ) of the button, insert the following code in order to create a [universal object](https://dev.branch.io/getting-started/branch-universal-object/) once the button is clicked:
{% highlight swift %}
let branchUniversalObject: BranchUniversalObject = BranchUniversalObject(canonicalIdentifier: "item/12345")
branchUniversalObject.title = "Cat Facts"
branchUniversalObject.contentDescription = "Here is a cat fact"
branchUniversalObject.addMetadataKey("factWords", value: "Example value for factWords")
branchUniversalObject.addMetadataKey("imageLink", value: "Example value for imageLink")
{% endhighlight %}

{% image src="/img/pages/getting-started/content-sharing-tutorial/tutorial-videos/add-universal-object.gif" center 3-quarters %}

{% protip title="Key Value Pairs" %}
The `addMetadataKey` method allows you to create key value pairs which can then be accessed upon opening the app from a Branch link

  * "factWords" and "imageLink" are keys and can be edited to be named whatever you like
{% endprotip %}

### Assemble Parameters and Setup Share Sheet

Also in the function body of the share button, add the following code which creates and opens a share sheet upon clicking the button that it is associated with:
{% highlight swift %}
let linkProperties: BranchLinkProperties = BranchLinkProperties()
linkProperties.feature = "sharing"
branchUniversalObject.showShareSheetWithLinkProperties(linkProperties,
                                        andShareText: "Super amazing thing I want to share!",
                                        fromViewController: self,
                                        completion: { (String, Bool) -> Void in
    print("done showing share sheet!")
})
{% endhighlight %}

{% image src="/img/pages/getting-started/content-sharing-tutorial/tutorial-videos/add-share-sheet.gif" center 3-quarters %}

## Allow for Deep Link Routing

*Now that the links have been created, you must configure your app to let Branch know what to do with the information from the deep link*

### Configure View Controller to accept deep links

1. In the view controller that you wish to deep link to, import the Branch framework by inserting the following code at the top of the associated file:
`import Branch`
2. Setup your view controller so that it will be recognized as a view controller that is accessible from a deep link:
   `class ExampleDeepLinkingController: UIViewController, BranchDeepLinkingController {`
3. The following method will be called when the view controller is loaded from a link click. Copy and paste the following code into the view controller that you want your link to route to. The data keys “factWords” and “imageLink”  are the same keys that were created in the universal object:
{% highlight swift %}
func configureControlWithData(data: [NSObject : AnyObject]!){
	factWords = data["factWords"] as! String
        imageLink = data["imageLink"] as! String
    }
{% endhighlight %}

{% image src="/img/pages/getting-started/content-sharing-tutorial/tutorial-videos/add-configure-control-with-data.gif" center 3-quarters %}

4. Since the view controller is displayed modally, you must add a close button. Insert the following code underneath the previous function:
{% highlight swift %}
var deepLinkingCompletionDelegate: BranchDeepLinkingControllerCompletionDelegate?
func closePressed() {
    self.deepLinkingCompletionDelegate!.deepLinkingControllerCompleted()
}
{% endhighlight %}

### Register the view controller for deep link routing

*Here you will tell your app which key value pairs should be accessed by the view controller that you set up for deep linking*

1. In your Main.storyboard file, select the view controller that you wish to link to
2. Open up the right hand sidebar
3. Select the "Identity Inspector" button
{% image src="/img/pages/getting-started/content-sharing-tutorial/screenshots/identity_inspector_button.png" center quarter %}
3. Fill out a Storyboard ID and check the “Use Storyboard ID” button
{% image src="/img/pages/getting-started/content-sharing-tutorial/screenshots/set_storyboard_id.png" center half %}
4. Inside the **AppDelegate.swift** file, find the line beginning with:
`func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {`

Underneath it, immediately after the `{`, add the following code. This is telling Xcode that the view controller with indentifier `FactViewController` should receive information from the keys named `"imageLink"` and `"factWords"`:
{% highlight swift %}
let branch: Branch = Branch.getInstance()
var controller = UIStoryboard.init(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("FactViewController")

        branch.registerDeepLinkController(controller, forKey: "imageLink")
        branch.registerDeepLinkController(controller, forKey: "factWords")
        branch.initSessionWithLaunchOptions(launchOptions, automaticallyDisplayDeepLinkController: true)
{% endhighlight %}

{% image src="/img/pages/getting-started/content-sharing-tutorial/tutorial-videos/update-app-delegate.gif" center 3-quarters %}

Make sure that the `instantiateViewControllerWithIdentity` method is filled out with the Storyboard ID you just created

### Enable Deepviews

*Deepviews allows the user to see content that you shared inside a web view even if they do not have the app installed*

1. Head to the [Deepviews configuration page](https://dashboard.branch.io/settings/deepviews) on the Branch dashboard
2. Select the platform that you want to enable Deepviews on (iOS, Android, and Desktop)
3. Select "Enable"
4. In the view controller file where you created your `branchUniversalObject`, add the following code underneath your current data dictionary. This will set the title, description and image that is presented in the deepview:
{% highlight swift %}
  branchUniversalObject.addMetadataKey("$og_title", value: "Your App Name")
  branchUniversalObject.addMetadataKey("$og_description", value: "Your Description")
  branchUniversalObject.addMetadataKey("$og_image_url", value: "Your image link")
{% endhighlight %}

{% image src="/img/pages/getting-started/content-sharing-tutorial/tutorial-videos/add-og-data.gif" center 3-quarters %}

{% protip %}
  Make sure that the values for `"$og_title"`, `"$og_description"`, and `"$og_image_url"` are all strings
{% endprotip %}

## Testing

*To ensure that everything is working properly, you are going to text yourself a deep link from your application*

1. Click the share button that you created within the app
2. A Branch share sheet should pop up
3. Select the Messages icon and type in your own contact
4. When you receive the message, click the link and you should be taken directly to the content that you wanted to share
