---
type: recipe
title: Deeplinked Ads
platforms:
- ios
- android
---

Deeplinked ads are not a new breed--just a rare one. With Branch they're as easy as creating a link on the Dashboard and setting up your {{page.platform_formatted}} app to handle incoming deep links.

This makes the following possible:

* A user clicks on an ad for 20% off all purchases before the end of the week, and upon opening the app sees the coupon and has it automatically added to the shopping cart.
* A user clicks on an ad for blue sneakers. You show him the blue sneakers as soon as he opens the app.
* You run a massive ad campaign that drives a ton of new users to the app. You want create a funnel to see how many users signed up and/or completed purchases after clicking different ads (and the conversion rate).
* You know that users clicking on your ads are already familiar with your product. So in your app you reduce the carousel shown to new users from 5 to 2 if they've come in through an ad.

{% protip title="With or without the app!" %}
Note that all the deeplink always succeeds when the app is opened, _even if the app was not installed when the ad was clicked on!_ This is the power of deferred deeplinking thanks to Branch.
{%endprotip%}

## Configuring the Dashboard for your {{ page.platform_formatted }} app

{% ingredient dashboard_setup/app_name %}{% endingredient %}
{% ingredient dashboard_setup/web_url %}{% endingredient %}
{% ingredient dashboard_setup/store_or_custom_url %}{% endingredient %}
{% ingredient dashboard_setup/uri_scheme %}
	{%override client_uri %}For more details on finding/setting your URI scheme in the client, see the section below on [setting the client app's URI scheme](/recipes/deeplinked_ads/{{page.platform}}/#uri-scheme-1).{%endoverride%}
{% endingredient %}
{% ingredient dashboard_setup/end_required %}{% endingredient %}
<!--- /Basic Setup -->


## Creating your Link

{% ingredient dashboard_links/creating_links %}
	{%override screenshot_description%}One example description if you want to treat this guide is: "Facebook ad for blue sneakers - summer 2015."{%endoverride%}
	{%override screenshot%}![Description](/img/ingredients/dashboard_links/fb_example_create.png){%endoverride%}
{% endingredient %}

{% ingredient dashboard_links/tags %}
	{%override deep_link_data_url%}For information of the form *[key]*: *[value]* such as "product": "shoes", we recommend adding them to "Deep Link Data (Advanced)", discussed [below](/recipes/deeplinked_ads/ios/#deep-link-data-advanced).
    {%endoverride%}
	{%override screenshot%}![Description](/img/ingredients/dashboard_links/fb_example_tags.png){%endoverride%}
{% endingredient %}

{% ingredient dashboard_links/alias %}
	{%override explanation%}This is more important for links that will be visible. For ads, this URL will be buried in the add and most users won't see it. However, you still have the option to customize it.{%endoverride%}
	{%override screenshot%}{%endoverride%}
{% endingredient %}

{% ingredient dashboard_links/custom_redirects %}{% endingredient %}
{% ingredient dashboard_links/og_tags %}{% endingredient %}
{% ingredient dashboard_links/end %}{% endingredient %}

### So Far, So Good
{% ingredient dashboard_links/no_sdk %}
	{%override alias%}{%endoverride%}
	{%override more_power%}keep reading.{%endoverride%}
{% endingredient %}
<!--- /Creating your Link -->


## Configuring your app to track installs

Based on what you've built so far, you will be able to track your ad campaign's clicks by device -- how many people on each platform (desktop, iOS, Android) have clicked your ads.

If you integrate our SDK into your app, you can:

1. See exactly how many people are installing your app based on each of your ads.
2. Personalize a user's experience after clicking on an ad. This works regardless of whether the user previously had your app installed. Examples include:
   i. display a campaign-specific message
   ii. automatically take the user to the same pair of shoes that were featured in the ad that was clicked on
   iii. apply a certain coupon towards a purchase of a new pair of shoes, with a coupon icon at the top of the screen
3. Track events and create funnels so you can see which ads are performing best on concrete measures such as # of completed signups or number/type of purchases even if the app was not previously installed.

{% ingredient sdk_setup/installing_the_sdk %}{% endingredient %}
{% ingredient sdk_setup/branch_key %}{% endingredient %}
{% ingredient sdk_setup/uri_scheme %}
  {%override dashboard_uri %}For more info on setting up a URI scheme on the Dashboard, check out the [section above](/recipes/deeplinked_ads/{{page.platform}}/#uri-scheme).{%endoverride%}
{% endingredient %}
{% ingredient sdk_setup/init_session %}{% endingredient %}
{% ingredient sdk_setup/handle_deep_link %}{% endingredient %}
<!--- /Creating your Link -->


## Example: Facebook Ads

Navigate to [https://www.facebook.com/ads/create](https://www.facebook.com/ads/create) while logged in to your Facebook page. (If you don't yet have a Facebook page, you will need to create one before advertising on Facebook.)

Choose "Send people to your website". Unfortunately due to limitations with Facebook's API, you cannot currently run campaigns for app downloads through the option "Get installs of your app."

![Description](/img/recipes/deeplink_ads/facebook_ad_1.png)

On the next page, you need to enter the Branch link that was generated in the last step. Here's a gif to help:

![Description](/img/recipes/deeplink_ads/facebook_ad_2.gif)

You can now customize your ad per the usual Facebook ad creation interface.

Notice that any OG tag information your provided has prepopulated in the interface.

![Description](/img/recipes/deeplink_ads/facebook_ad_3.png)

Last step is to make sure you target the mobile app, not the desktop! If you need help, see the gif below:

![Description](/img/recipes/deeplink_ads/facebook_ad_4.gif)

Now make sure you have a picture of the appropriate size, then order up that ad!


## (Optional) Routing to content based on the ad

After you've added `handleDeepLink` call (discussed in the section [Handle Deep Link](/recipes/deeplinked_ads/{{page.platform}}/#handle-deep-link) above), you can add deep linking straight to content.

<!--- CUSTOM DATA -->
{% ingredient dashboard_links/custom_data %}{%endingredient%}

<!--- ROUTING -->
{% ingredient sdk_routing/routing %}

{% override ios_explanation %}
Inside of the `deepLinkHandler`, you will want to examine the params dictionary to determine whether the user clicked on a link to content. Regardless of whether your app involves pictures, videos, text or whatever novel content your app contains, you likely have an internal system of identifiers.

In this case, we want to handle users clicking on ads. When creating an ad, you specified an `ad_id`. If a user clicks a link to a from an ad, this Id will show up in the params dictionary in the deepLinkHandler.

Now you need to customize the code in your deep link handler to route to content based on the `ad_id`. In the example below, we push to a special view controller to content based on ads inside the app. It can show an offer (e.g. 20% off), a product (e.g. blue shoes!) or anything you want.
{%endoverride%}

{% override android_explanation %}
[TODO] @Sahil, please convert this to Java/Android-speak.

Inside of the deepLinkHandler, you will want to examine the params dictionary to determine whether the user clicked on a link to content. Regardless of whether your app involves pictures, videos, text or whatever novel content your app contains, you likely have an internal system of identifiers.

In this case, we want to handle users clicking on ads. When creating an ad, you specified an `ad_id`. If a user clicks a link to a from an ad, this Id will show up in the params dictionary in the deepLinkHandler.

Now you need to customize the code in your deep link handler to route to content based on the `ad_id`. In the example below, we push to a special view controller to content based on ads inside the app. It can show an offer (e.g. 20% off), a product (e.g. blue shoes!) or anything you want.
{%endoverride%}


{%if page.android%}[TODO] @Sahil, please make the code sample change to fit this guide. Note that I did this on iOS (you can see it in the routing.md and the overrides here.){%endif%}


{%override ios_key %}ad_id{%endoverride%}
{%override ios_comment %}// then load the ad screen with the appropriate content{%endoverride%}
{%override ios_key_U %}AdId{%endoverride%}
{%override vc_name %}adVC{%endoverride%}

{% endingredient %}


## Conclusion

It's pretty simple! You need to configure the dashboard, generate links for your ads, and setup your {{page.platform_formatted}} app to track installs. You can optionally deep link straight to content based on the ad that the user clicked on!

{% ingredient recipe_endings/intro %}{%endingredient%}
{% ingredient recipe_endings/incentivized_referral_program %}{%endingredient%}
{% ingredient recipe_endings/personalized_invite_system %}{%endingredient%}
{% ingredient recipe_endings/influencers %}{%endingredient%}
{% ingredient recipe_endings/channel_tags %}{%endingredient%}
{% ingredient recipe_endings/contact_us %}{%endingredient%}