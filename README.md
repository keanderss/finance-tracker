# Finance Tracker

The project should be runnable locally by running the following commands. If not you can check out the deployed version.

`flutter pub upgrade --major-versions`

`flutter run`

#### Description:

Finance tracker for tracking personal finances, spending, income and tracking top spending categories. The applications features some automatic calculations to give you an easy overview of your spending habits. The application is made to be usable on multiple screen sizes and has been tested on the narrowest screen size available in Chrome dev tools (Galaxy Z Fold 5) in both portrait and landscape mode.

# URL:

[Deployment](https://finance-tracker-b8efd.web.app/)

# How to use:

The application features 4 distinct pages that can be navigated between through the navigation bar. A payment can be logged in the app through the floating action button on the bottom right. This button opens up a payment form which allows entering a new payment into the system. Here you can give the payment a title, a sum, a date when the payment is made, choosing a category (optional), and optionally schdeule the payment as a monthly payment.

## Home Page:

The home page is the initial page the application opens to. This page features two widgets, a statistics widget, and a pending payments widget.

### Statistics widget:

The statistics widget displays some stats on income and expenses for scheduled payments, payments for the current month, the last month and the current year. The satistics widget also displays stats on top 3 spending categories in the last 30 days.

### Pending payments widget:

When a scheduled payment is past its schdeduled date, the payment becomes "pending" and will be shown in the pending payments list where it can be confirmed by the user. This is done by opening the menu on the right and selecting the confirm option.

## Payments page:

The payments page displays a full list of made payments. Payments can be edited or deleted in the menu on the right.

## Schedule page:

The schdeule page displays a list of scheduled payments and the date which they are scheduled for, here the payments can also be edited or delted through the menu on the right.

## Settings page:

In the settings page you can change the localization and currency settings for the app. Here you can also customize the spending categories in the app.