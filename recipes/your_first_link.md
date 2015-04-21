---
type: recipe
title: Your First Link
platforms:
- ios
- android
---

## Getting Started

Branch Links enable deep linking, install attribution, and in-depth analytics. While configuring your apps--whether Android, iOS or web--enables you to be much more powerful, basic links can be set up before writing a line of code.

You can do this from the [Branch Dashboard](https://dashboard.branch.io/). We will first walk you through creating an app, then proceed to link creation.

## Basic Setup
{% ingredient dashboard_setup/app_name %}{% endingredient %}
{% ingredient dashboard_setup/store_or_custom_url %}{% endingredient %}

That's the end of the required setup for the Dashboard! The dashboard is incredibly powerful, so if you want to dive in deeper, definitely check out [Configuring the Dashboard](/domains/configuring_the_dashboard/{{page.platform}}/) for the full setup.


## Creating your Link

{% ingredient dashboard_links/creating_links %}
	{%override screenshot_description%}One example description if you want to treat this guide is: "Marketing our launch on Facebook."{%endoverride%}
{% endingredient %}

{% ingredient dashboard_links/tags %}
	{%override deep_link_data_url%}For information of the form *[key]*: *[value]* such as "product": "shoes", we recommend adding them to "Deep Link Data (Advanced)", discussed in [Links and Sharing](/domains/links_and_sharing/{{page.platform}}/#attaching-custom-data-to-links) [TODO!].
    {%endoverride%}
{% endingredient %}

{% ingredient dashboard_links/alias %}
	{%override optional%}(Optional -- highly recommended){%endoverride%}
{% endingredient %}

{% ingredient dashboard_links/og_tags %}{% endingredient %}
{% ingredient dashboard_links/end %}{% endingredient %}
<!--- /Creating your Link -->


## Conclusion and Advanced Options

{% ingredient dashboard_links/no_sdk %}{%endingredient%}